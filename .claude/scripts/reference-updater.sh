#!/bin/bash
# 간단한 참조 업데이터 (Python 의존성 없음)

# 현재 커밋 해시
COMMIT=$(git log -1 --format="%h" 2>/dev/null || echo "initial")

# 사용법
if [ "$1" = "" ]; then
    echo "Usage: reference-updater.sh <file|all>"
    exit 1
fi

# 단일 파일 업데이트
update_file() {
    local file=$1
    if [ ! -f "$file" ]; then
        return
    fi
    
    # .md 파일만 처리
    if [[ ! "$file" =~ \.md$ ]]; then
        return
    fi
    
    echo "Processing: $file"
    
    # 임시 파일
    temp_file="${file}.tmp"
    cp "$file" "$temp_file"
    
    # @ 참조를 @[] 형식으로 변환
    # 예: @.claude/README.md → @[.claude/README.md]#커밋해시
    sed -i.bak -E "s|@(\.claude/[^[:space:]]+\.md)|@[\1]#${COMMIT}|g" "$temp_file"
    
    # 별칭 적용 (간단한 케이스만)
    sed -i.bak -E "s|@\[\.claude/templates/core/01-essentials\.template\.md\]|@[\$essentials]|g" "$temp_file"
    sed -i.bak -E "s|@\[\.claude/templates/core/02-work-principles\.template\.md\]|@[\$work-principles]|g" "$temp_file"
    sed -i.bak -E "s|@\[\.claude/templates/core/03-dev-principles\.template\.md\]|@[\$dev-principles]|g" "$temp_file"
    sed -i.bak -E "s|@\[\.claude/custom/project\.yaml\]|@[\$project]|g" "$temp_file"
    sed -i.bak -E "s|@\[CLAUDE\.md\]|@[\$claude-md]|g" "$temp_file"
    sed -i.bak -E "s|@\[README\.md\]|@[\$readme]|g" "$temp_file"
    
    # 변경사항 확인
    if ! diff -q "$file" "$temp_file" > /dev/null; then
        mv "$temp_file" "$file"
        echo "  ✓ Updated references in $file"
    else
        rm "$temp_file"
        echo "  - No changes needed"
    fi
    
    # 백업 파일 제거
    rm -f "${temp_file}.bak"
}

# 모든 파일 처리
if [ "$1" = "all" ]; then
    echo "Updating all markdown files..."
    find . -name "*.md" -type f | grep -v ".git" | while read file; do
        update_file "$file"
    done
else
    update_file "$1"
fi

echo "Done!"