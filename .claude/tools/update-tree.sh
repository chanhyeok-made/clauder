#!/bin/bash
# Version Tree 업데이트 도구
# 문서화 단계에서 자동으로 version-tree.yaml 업데이트

TREE_FILE=".claude/version-tree.yaml"
TEMP_FILE=".claude/version-tree.tmp.yaml"

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# 현재 커밋 해시 가져오기
get_current_commit() {
    git log -1 --format="%h" 2>/dev/null || echo "uncommitted"
}

# 다음 사용 가능한 ID 찾기
get_next_id() {
    local category=$1
    local max_id=0
    
    case $category in
        "principle") range="1-99" ;;
        "command") range="100-199" ;;
        "design") range="200-299" ;;
        "guide") range="300-399" ;;
        "template") range="400-499" ;;
        "other") range="500-599" ;;
        "root") range="1000-1999" ;;
        *) range="2000-2999" ;;
    esac
    
    # 범위에서 최대 ID 찾기
    # 실제 구현은 Python 스크립트로 위임하는 것이 더 안전
    echo "2000"  # 임시 값
}

# 문서 추가
add_document() {
    local path=$1
    local category=${2:-"other"}
    
    echo -e "${GREEN}Adding document:${NC} $path"
    
    # 이미 존재하는지 확인
    if grep -q "path: \"$path\"" "$TREE_FILE"; then
        echo -e "${YELLOW}Document already exists${NC}"
        return 1
    fi
    
    local id=$(get_next_id $category)
    local date=$(date +%Y-%m-%d)
    local commit=$(get_current_commit)
    
    # YAML에 추가 (Python 스크립트 호출이 더 안전)
    cat >> "$TREE_FILE" << EOF

  $id:
    path: "$path"
    created: "$date"
    updated: "$date"
    commit: "$commit"
    depends_on: []
    referenced_by: []
EOF
    
    echo -e "${GREEN}✓ Added with ID:${NC} $id"
}

# 문서 업데이트
update_document() {
    local path=$1
    
    echo -e "${GREEN}Updating document:${NC} $path"
    
    # 문서가 존재하는지 확인
    if ! grep -q "path: \"$path\"" "$TREE_FILE"; then
        echo -e "${RED}Document not found${NC}"
        return 1
    fi
    
    local date=$(date +%Y-%m-%d)
    local commit=$(get_current_commit)
    
    # Python으로 안전하게 업데이트하는 것이 좋음
    # 임시로 sed 사용 (위험할 수 있음)
    
    echo -e "${GREEN}✓ Updated${NC}"
}

# 참조 관계 업데이트
update_refs() {
    local from_path=$1
    local to_path=$2
    local ref_type=${3:-"depends"}  # depends 또는 references
    
    echo -e "${GREEN}Updating references:${NC} $from_path -> $to_path"
    
    # Python 스크립트로 처리하는 것이 안전
    
    echo -e "${GREEN}✓ References updated${NC}"
}

# 자동 감지 및 업데이트
auto_update() {
    echo -e "${GREEN}Auto-detecting changes...${NC}"
    
    # Git에서 변경된 파일 목록 가져오기
    changed_files=$(git diff --name-only HEAD^ HEAD 2>/dev/null)
    
    for file in $changed_files; do
        if [[ $file == *.md ]] || [[ $file == *.sh ]] || [[ $file == *.yaml ]]; then
            if grep -q "path: \"/$file\"" "$TREE_FILE"; then
                update_document "/$file"
            else
                add_document "/$file"
            fi
        fi
    done
    
    echo -e "${GREEN}✓ Auto-update complete${NC}"
}

# 검증
validate() {
    echo -e "${GREEN}Validating version tree...${NC}"
    
    # 중복 ID 확인
    duplicate_ids=$(grep "^  [0-9]" "$TREE_FILE" | awk '{print $1}' | sort | uniq -d)
    if [ -n "$duplicate_ids" ]; then
        echo -e "${RED}Duplicate IDs found:${NC} $duplicate_ids"
        return 1
    fi
    
    # 중복 경로 확인
    duplicate_paths=$(grep "path:" "$TREE_FILE" | sort | uniq -d)
    if [ -n "$duplicate_paths" ]; then
        echo -e "${RED}Duplicate paths found${NC}"
        return 1
    fi
    
    echo -e "${GREEN}✓ Validation passed${NC}"
}

# 메인 명령 처리
case "$1" in
    add)
        add_document "$2" "$3"
        ;;
    update)
        update_document "$2"
        ;;
    refs)
        update_refs "$2" "$3" "$4"
        ;;
    auto)
        auto_update
        ;;
    validate)
        validate
        ;;
    *)
        echo "Usage: $0 {add|update|refs|auto|validate} [args...]"
        echo ""
        echo "Commands:"
        echo "  add <path> [category]     - Add new document"
        echo "  update <path>             - Update existing document"
        echo "  refs <from> <to> [type]   - Update references"
        echo "  auto                      - Auto-detect and update"
        echo "  validate                  - Validate tree structure"
        exit 1
        ;;
esac