#!/bin/bash

# Clauder 전체 검증 스크립트
# 문서 구조, 참조 일관성, 템플릿 등을 검증

PROJECT_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
VERSION_TREE="$PROJECT_ROOT/.claude/version-tree.yaml"

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

echo -e "${GREEN}🔍 Clauder 검증 시작${NC}"
echo "================================"

# 1. doc_id 검증
echo -e "\n${YELLOW}1. doc_id 검증${NC}"
echo "----------------"

# doc_id 중복 검사
DUPLICATE_IDS=$(grep "^doc_id:" $(find . -name "*.md" -type f) | awk '{print $2}' | sort | uniq -d)
if [ -n "$DUPLICATE_IDS" ]; then
    echo -e "${RED}❌ 중복된 doc_id 발견:${NC}"
    echo "$DUPLICATE_IDS"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅ doc_id 중복 없음${NC}"
fi

# doc_id 누락 검사
MISSING_DOCID=$(find . -name "*.md" -type f | while read file; do
    if ! grep -q "^doc_id:" "$file" 2>/dev/null; then
        echo "$file"
    fi
done)

if [ -n "$MISSING_DOCID" ]; then
    echo -e "${RED}❌ doc_id 누락 파일:${NC}"
    echo "$MISSING_DOCID" | head -5
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅ 모든 파일에 doc_id 있음${NC}"
fi

# 2. 참조 일관성 검증
echo -e "\n${YELLOW}2. 참조 일관성 검증${NC}"
echo "--------------------"

# 깨진 참조 찾기
BROKEN_REFS=0
while IFS= read -r file; do
    # @로 시작하는 참조 찾기
    refs=$(grep -o '@[^[:space:]]*\.md' "$file" 2>/dev/null || true)
    for ref in $refs; do
        # @ 제거하고 경로 추출
        path="${ref#@}"
        if [ ! -f "$PROJECT_ROOT/$path" ]; then
            echo -e "${RED}❌ 깨진 참조: $file -> $ref${NC}"
            BROKEN_REFS=$((BROKEN_REFS + 1))
        fi
    done
done < <(find . -name "*.md" -type f)

if [ $BROKEN_REFS -eq 0 ]; then
    echo -e "${GREEN}✅ 모든 참조 정상${NC}"
else
    ERRORS=$((ERRORS + BROKEN_REFS))
fi

# 3. 버전 트리 검증
echo -e "\n${YELLOW}3. 버전 트리 일관성${NC}"
echo "--------------------"

if [ -f "$VERSION_TREE" ]; then
    # 버전 트리의 문서 수와 실제 문서 수 비교
    TREE_COUNT=$(grep -c '^ *[0-9]\+:' "$VERSION_TREE")
    ACTUAL_COUNT=$(find . -name "*.md" -type f | grep -v ".git" | wc -l)
    
    echo "버전 트리 문서 수: $TREE_COUNT"
    echo "실제 문서 수: $ACTUAL_COUNT"
    
    if [ $TREE_COUNT -ne $ACTUAL_COUNT ]; then
        echo -e "${YELLOW}⚠️  문서 수 불일치${NC}"
        WARNINGS=$((WARNINGS + 1))
    else
        echo -e "${GREEN}✅ 문서 수 일치${NC}"
    fi
else
    echo -e "${RED}❌ 버전 트리 파일 없음${NC}"
    ERRORS=$((ERRORS + 1))
fi

# 4. 파일 구조 검증
echo -e "\n${YELLOW}4. 파일 구조 검증${NC}"
echo "------------------"

# 필수 디렉토리 확인
REQUIRED_DIRS=(
    ".claude"
    ".clauder-dev"
    "docs"
    "docs/commands"
    "docs/guides"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$PROJECT_ROOT/$dir" ]; then
        echo -e "${GREEN}✅ $dir${NC}"
    else
        echo -e "${RED}❌ $dir 없음${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

# 5. 임시 파일 검사
echo -e "\n${YELLOW}5. 임시 파일 위치 검사${NC}"
echo "----------------------"

MISPLACED_TEMPS=$(find . -name "temp-*" -o -name "draft-*" | grep -v ".clauder-dev/temp" | grep -v ".git" || true)
if [ -n "$MISPLACED_TEMPS" ]; then
    echo -e "${YELLOW}⚠️  잘못된 위치의 임시 파일:${NC}"
    echo "$MISPLACED_TEMPS"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "${GREEN}✅ 모든 임시 파일이 올바른 위치에 있음${NC}"
fi

# 결과 요약
echo -e "\n================================"
echo -e "${GREEN}검증 완료!${NC}"
echo -e "오류: ${RED}$ERRORS${NC}"
echo -e "경고: ${YELLOW}$WARNINGS${NC}"

if [ $ERRORS -gt 0 ]; then
    echo -e "\n${RED}❌ 검증 실패: 오류를 수정하세요${NC}"
    exit 1
elif [ $WARNINGS -gt 0 ]; then
    echo -e "\n${YELLOW}⚠️  경고가 있지만 사용 가능합니다${NC}"
    exit 0
else
    echo -e "\n${GREEN}✅ 모든 검증 통과!${NC}"
    exit 0
fi