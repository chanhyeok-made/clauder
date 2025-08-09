#!/bin/bash
# 간단한 Version Tree 업데이트 도구
# YAML 라이브러리 없이 기본 도구로 처리

TREE_FILE=".claude/version-tree.yaml"
LOG_FILE=".claude/tools/tree-updates.log"

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# 로그 기록
log_update() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# 현재 커밋 해시 가져오기
get_commit() {
    git log -1 --format="%h" 2>/dev/null || echo "uncommitted"
}

# 문서가 이미 있는지 확인
document_exists() {
    local path=$1
    grep -q "path: \"$path\"" "$TREE_FILE" 2>/dev/null
}

# 메타데이터 업데이트
update_metadata() {
    local date=$(date '+%Y-%m-%d')
    local commit=$(get_commit)
    
    # metadata 섹션 업데이트
    sed -i.bak "s/last_update: .*/last_update: \"$date\"/" "$TREE_FILE"
    sed -i.bak "s/last_commit: .*/last_commit: \"$commit\"/" "$TREE_FILE"
    
    echo -e "${GREEN}✓ Metadata updated${NC}"
    log_update "Metadata updated: date=$date, commit=$commit"
}

# 새 문서 추가 (간단 버전)
add_to_log() {
    local path=$1
    local action=$2
    local category=${3:-"other"}
    
    # 로그에 기록
    cat >> "$LOG_FILE" << EOF
---
action: $action
path: $path
category: $category
date: $(date '+%Y-%m-%d')
commit: $(get_commit)
---
EOF
    
    echo -e "${GREEN}✓ Logged:${NC} $action $path"
}

# 변경사항 감지 및 로그
detect_changes() {
    echo -e "${GREEN}Detecting changes...${NC}"
    
    # 새로 추가된 파일들
    for file in .claude/workflow/*.md .claude/learning/*.md .claude/tools/*.md .claude/state/*.md .base-principles/*.md; do
        if [ -f "$file" ]; then
            path="/$file"
            if ! document_exists "$path"; then
                echo -e "${YELLOW}New document:${NC} $path"
                add_to_log "$path" "ADD" "$(determine_category $path)"
            fi
        fi
    done
    
    # 수정된 파일들 (Git 기반)
    if git diff --name-only HEAD^ HEAD 2>/dev/null | grep -E "\.(md|sh|yaml)$"; then
        git diff --name-only HEAD^ HEAD | grep -E "\.(md|sh|yaml)$" | while read file; do
            path="/$file"
            if document_exists "$path"; then
                echo -e "${YELLOW}Modified:${NC} $path"
                add_to_log "$path" "UPDATE"
            fi
        done
    fi
}

# 카테고리 결정
determine_category() {
    local path=$1
    
    case "$path" in
        *workflow*) echo "workflow" ;;
        *learning*) echo "learning" ;;
        *tools*) echo "tool" ;;
        *state*) echo "state" ;;
        *principles*) echo "principle" ;;
        *template*) echo "template" ;;
        *) echo "other" ;;
    esac
}

# 요약 보고서
generate_report() {
    echo -e "${GREEN}=== Version Tree Update Report ===${NC}"
    echo ""
    
    if [ -f "$LOG_FILE" ]; then
        echo "Recent updates:"
        tail -20 "$LOG_FILE" | grep -E "^\[|action:|path:" | tail -10
    else
        echo "No updates logged yet"
    fi
    
    echo ""
    echo -e "${YELLOW}Note:${NC} Full tree update requires manual YAML editing or Python with PyYAML"
    echo "Updates have been logged to: $LOG_FILE"
}

# 메인 실행
case "$1" in
    update)
        update_metadata
        ;;
    detect)
        detect_changes
        ;;
    report)
        generate_report
        ;;
    *)
        echo "Simple Version Tree Updater"
        echo "Usage: $0 {update|detect|report}"
        echo ""
        echo "Commands:"
        echo "  update  - Update metadata (date, commit)"
        echo "  detect  - Detect and log changes"
        echo "  report  - Show recent updates"
        echo ""
        echo "Note: This is a simplified version that logs changes."
        echo "Full YAML manipulation requires Python with PyYAML."
        ;;
esac