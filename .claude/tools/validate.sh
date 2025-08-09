#!/bin/bash
# 문서 검증 도구

echo "===== Clauder 검증 시작 ====="

# 1. 참조 체크
echo "1. 참조 체크..."
broken_refs=0
for file in $(find . -name "*.md" -not -path "./.archive/*" -not -path "./.git/*"); do
    grep -o "@[^[:space:]]*" "$file" 2>/dev/null | while read ref; do
        ref_path="${ref#@}"
        if [ ! -f "$ref_path" ]; then
            echo "  ❌ 깨진 참조: $ref in $file"
            ((broken_refs++))
        fi
    done
done

# 2. 문서 최신성
echo "2. 문서 최신성..."
old_docs=$(find . -name "*.md" -mtime +30 -not -path "./.archive/*" | wc -l)
if [ $old_docs -gt 0 ]; then
    echo "  ⚠️  30일 이상 된 문서: $old_docs개"
fi

# 3. TODO 상태
echo "3. TODO 상태..."
if [ -f ".claude/workflow/current.md" ]; then
    grep "PENDING:" .claude/workflow/current.md
    grep "IN_PROGRESS:" .claude/workflow/current.md
fi

# 4. 워크플로우 단계
echo "4. 현재 워크플로우..."
if [ -f ".claude/workflow/current.md" ]; then
    grep "CURRENT_STAGE" .claude/workflow/current.md
fi

# 5. 필수 파일 체크
echo "5. 필수 파일..."
required_files=(
    "CLAUDE.md"
    ".claude/workflow/README.md"
    ".claude/learning/patterns.md"
    ".claude/state/current.md"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ❌ $file 없음"
    fi
done

echo "===== 검증 완료 ====="