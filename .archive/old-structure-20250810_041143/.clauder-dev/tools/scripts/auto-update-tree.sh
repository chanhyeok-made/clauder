#!/bin/bash

# 버전 트리 자동 업데이트 스크립트
# Git hook과 연동하여 파일 변경 시 자동으로 버전 트리 업데이트

PROJECT_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
VERSION_TREE="$PROJECT_ROOT/.claude/version-tree.yaml"
TEMP_DIR="$PROJECT_ROOT/.clauder-dev/temp"

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔄 버전 트리 자동 업데이트 시작${NC}"

# 임시 디렉토리 생성
mkdir -p "$TEMP_DIR"

# 현재 커밋 해시 가져오기
CURRENT_COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "uncommitted")
CURRENT_DATE=$(date +%Y-%m-%d)

# 변경된 .md 파일 목록 가져오기
CHANGED_FILES=$(git diff --name-only --cached --diff-filter=AM | grep '\.md$' || true)

if [ -z "$CHANGED_FILES" ]; then
    echo "변경된 마크다운 파일이 없습니다."
    exit 0
fi

# 버전 트리에서 가장 큰 doc_id 찾기
MAX_ID=$(grep -E '^ *[0-9]+:' "$VERSION_TREE" | sed 's/^ *\([0-9]*\):.*/\1/' | sort -n | tail -1)
NEXT_ID=$((MAX_ID + 1))

# 각 변경된 파일 처리
for file in $CHANGED_FILES; do
    # 상대 경로를 절대 경로로 변환
    ABS_PATH="$PROJECT_ROOT/$file"
    REL_PATH="/$file"
    
    # 이미 버전 트리에 있는지 확인
    if grep -q "path: \"$REL_PATH\"" "$VERSION_TREE"; then
        echo -e "${YELLOW}📝 업데이트: $REL_PATH${NC}"
        
        # 해당 문서의 doc_id 찾기
        DOC_ID=$(grep -B1 "path: \"$REL_PATH\"" "$VERSION_TREE" | head -1 | grep -o '^ *[0-9]\+:' | tr -d ': ')
        
        # updated와 commit 필드 업데이트
        sed -i.bak -e "/$DOC_ID:/,/^  [0-9]\+:/{
            s/updated: \"[^\"]*\"/updated: \"$CURRENT_DATE\"/
            s/commit: \"[^\"]*\"/commit: \"$CURRENT_COMMIT\"/
        }" "$VERSION_TREE"
    else
        echo -e "${GREEN}✨ 새 문서 추가: $REL_PATH (doc_id: $NEXT_ID)${NC}"
        
        # 새 항목 추가
        cat >> "$TEMP_DIR/new_entry.yaml" << EOF
  $NEXT_ID:
    path: "$REL_PATH"
    created: "$CURRENT_DATE"
    updated: "$CURRENT_DATE"
    commit: "$CURRENT_COMMIT"
    depends_on: []
    referenced_by: []
    
EOF
        
        # path_to_id 인덱스에도 추가
        echo "  \"$REL_PATH\": $NEXT_ID" >> "$TEMP_DIR/new_index.yaml"
        
        NEXT_ID=$((NEXT_ID + 1))
    fi
done

# 새 항목들을 버전 트리에 병합
if [ -f "$TEMP_DIR/new_entry.yaml" ]; then
    # documents 섹션 끝 찾기
    LINE_NUM=$(grep -n "^# 빠른 검색을 위한 인덱스" "$VERSION_TREE" | cut -d: -f1)
    
    # 새 항목 삽입
    head -n $((LINE_NUM - 1)) "$VERSION_TREE" > "$TEMP_DIR/version-tree-new.yaml"
    cat "$TEMP_DIR/new_entry.yaml" >> "$TEMP_DIR/version-tree-new.yaml"
    tail -n +$LINE_NUM "$VERSION_TREE" >> "$TEMP_DIR/version-tree-new.yaml"
    
    # 인덱스 업데이트
    if [ -f "$TEMP_DIR/new_index.yaml" ]; then
        cat "$TEMP_DIR/new_index.yaml" >> "$TEMP_DIR/version-tree-new.yaml"
    fi
    
    # 원본 파일 교체
    mv "$TEMP_DIR/version-tree-new.yaml" "$VERSION_TREE"
fi

# 메타데이터 업데이트
TOTAL_DOCS=$(grep -c '^ *[0-9]\+:' "$VERSION_TREE")
sed -i.bak \
    -e "s/last_update: \"[^\"]*\"/last_update: \"$CURRENT_DATE\"/" \
    -e "s/last_commit: \"[^\"]*\"/last_commit: \"$CURRENT_COMMIT\"/" \
    -e "s/total_documents: [0-9]*/total_documents: $TOTAL_DOCS/" \
    "$VERSION_TREE"

# 임시 파일 정리
rm -f "$VERSION_TREE.bak"
rm -rf "$TEMP_DIR"/*

echo -e "${GREEN}✅ 버전 트리 업데이트 완료${NC}"
echo "  - 총 문서 수: $TOTAL_DOCS"
echo "  - 현재 커밋: $CURRENT_COMMIT"