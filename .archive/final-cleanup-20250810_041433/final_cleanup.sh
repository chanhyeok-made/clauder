#!/bin/bash
# 진짜 최종 10개 파일만 남기기

echo "================================================"
echo "Clauder 진짜 최종 정리 (10개 파일만)"
echo "================================================"
echo ""

TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# 1. 유지할 파일 목록 (정확히 10개)
KEEP_FILES=(
    "CLAUDE.md"                    # 1. 메인 진입점
    ".claude/STATE.md"              # 2. 상태 추적
    "INSIGHTS.md"                   # 3. 축적된 지혜
    "README.md"                     # 4. 프로젝트 설명
    "INIT.sh"                       # 5. 타 프로젝트 적용
    ".workflow/README.md"           # 6. 워크플로우 통합
    "CORE_INSIGHTS.md"              # 7. 핵심 인사이트
    "LESSONS.md"                    # 8. 학습 내용
    "PRINCIPLES_CONSOLIDATED.md"    # 9. 통합 원칙
    ".gitignore"                    # 10. Git 설정
)

# 2. 아카이브 디렉토리 생성
echo "1. 아카이브 준비..."
mkdir -p .archive/final-cleanup-$TIMESTAMP
echo "✓ 아카이브 디렉토리 생성"

# 3. 유지할 파일 임시 보관
echo ""
echo "2. 핵심 파일 보호..."
mkdir -p .temp_keep
for file in "${KEEP_FILES[@]}"; do
    if [ -f "$file" ]; then
        mkdir -p ".temp_keep/$(dirname "$file")"
        cp "$file" ".temp_keep/$file"
        echo "  ✓ 보호: $file"
    fi
done

# 4. 모든 MD 파일과 디렉토리 아카이브
echo ""
echo "3. 나머지 파일 아카이브..."

# .workflow 제외한 모든 서브디렉토리 이동
for dir in $(find . -maxdepth 1 -type d -name ".*" -not -name ".git" -not -name ".archive" -not -name ".temp_keep" -not -name "." -not -name ".claude" -not -name ".workflow"); do
    if [ -d "$dir" ]; then
        mv "$dir" .archive/final-cleanup-$TIMESTAMP/ 2>/dev/null
        echo "  → 아카이브: $dir"
    fi
done

# .workflow 내부 정리 (README.md만 유지)
if [ -d ".workflow" ]; then
    find .workflow -type f -not -name "README.md" -exec mv {} .archive/final-cleanup-$TIMESTAMP/ \; 2>/dev/null
    find .workflow -type d -not -path ".workflow" -exec rm -rf {} \; 2>/dev/null
fi

# 루트의 모든 파일 이동 (유지 목록 제외)
for file in $(find . -maxdepth 1 -type f -name "*"); do
    filename=$(basename "$file")
    should_keep=false
    
    for keep in "${KEEP_FILES[@]}"; do
        if [ "$(basename "$keep")" = "$filename" ]; then
            should_keep=true
            break
        fi
    done
    
    if [ "$should_keep" = false ] && [ "$filename" != ".gitignore" ] && [ "$filename" != ".DS_Store" ]; then
        mv "$file" .archive/final-cleanup-$TIMESTAMP/ 2>/dev/null
        echo "  → 아카이브: $filename"
    fi
done

# 5. 보호한 파일 복원
echo ""
echo "4. 핵심 파일 복원..."
cp -r .temp_keep/* . 2>/dev/null
rm -rf .temp_keep
echo "✓ 핵심 파일 복원 완료"

# 6. 통계
echo ""
echo "================================================"
echo "최종 결과"
echo "================================================"
echo ""
echo "남은 파일:"
find . -name "*.md" -not -path "./.archive/*" -not -path "./.git/*" | while read file; do
    echo "  ✓ $file"
done
echo ""
echo "MD 파일 수: $(find . -name "*.md" -not -path "./.archive/*" -not -path "./.git/*" | wc -l)개"
echo "전체 파일 수: $(find . -type f -not -path "./.archive/*" -not -path "./.git/*" | wc -l)개"
echo ""
echo "아카이브: .archive/final-cleanup-$TIMESTAMP/"
echo ""
echo "🎯 Clauder가 진짜 단순해졌습니다!"