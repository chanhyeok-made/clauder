#!/bin/bash
# Clauder 최종 구조 설정 스크립트

echo "================================================"
echo "Clauder 최종 10개 파일 구조 설정"
echo "================================================"
echo ""

# 1. 백업 생성
echo "1. 현재 상태 백업..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p .archive/before-final-$TIMESTAMP
tar -czf .archive/before-final-$TIMESTAMP/backup.tar.gz . \
    --exclude='.git' \
    --exclude='.archive' \
    --exclude='.backup' \
    2>/dev/null
echo "✓ 백업 완료"

# 2. 최종 10개 파일 준비
echo ""
echo "2. 핵심 10개 파일 준비..."

# 핵심 파일 목록
cat > CORE_FILES.txt << 'EOF'
1. CLAUDE_FINAL.md - 메인 진입점
2. .claude/STATE.md - 상태 추적
3. CORE_INSIGHTS.md - 축적된 지혜
4. README.md - 프로젝트 설명
5. INIT.sh - 타 프로젝트 적용
6-10. .workflow/core/*.md - 5단계 프로세스
EOF

echo "✓ 핵심 파일 정의 완료"

# 3. 새 구조 생성
echo ""
echo "3. 새 구조 생성..."

# 최종 디렉토리 구조
mkdir -p .final
mkdir -p .final/.claude
mkdir -p .final/.workflow

# 핵심 파일 복사
cp CLAUDE_FINAL.md .final/CLAUDE.md
cp .claude/STATE.md .final/.claude/STATE.md 2>/dev/null || echo "# 상태 추적" > .final/.claude/STATE.md
cp CORE_INSIGHTS.md .final/INSIGHTS.md
cp README.md .final/README.md 2>/dev/null || echo "# Clauder" > .final/README.md
cp INIT.sh .final/INIT.sh 2>/dev/null || echo "#!/bin/bash" > .final/INIT.sh

# 워크플로우 파일 통합
cat > .final/.workflow/README.md << 'EOF'
# 5단계 워크플로우

## 1. 분석 (Analysis)
- 요구사항 파악
- 접근 방법 결정
- TODO 생성

## 2. 구현 (Implementation)
- 코드 작성
- 테스트
- 검증

## 3. 회고 (Retrospective)
- 문제점 발견?
- 개선 사항?
- 학습 기록

## 4. 문서화 (Documentation)
- 변경사항 기록
- README 업데이트
- 인사이트 추가

## 5. 커밋 (Commit)
- git add .
- git commit -m "type: description"
- git push

각 단계는 순서대로 진행하며, 건너뛰지 않습니다.
EOF

echo "✓ 새 구조 생성 완료"

# 4. 아카이브 생성
echo ""
echo "4. 기존 파일 아카이브..."

# 아카이브할 디렉토리들
TO_ARCHIVE=(
    ".clauder-dev"
    ".base-principles"
    ".principles"
    ".learning"
    ".tools"
    ".templates"
    ".docs"
    ".examples"
    "docs"
    "modules"
    "core"
    "templates"
    "*.py"
    "*.json"
    "CLAUDE.base.md"
    "CLAUDE-*.md"
    "CLAUDER_*.md"
    "CLEANUP_*.md"
    "MIGRATION_*.md"
    "SYSTEM_*.md"
)

mkdir -p .archive/old-structure-$TIMESTAMP
for item in "${TO_ARCHIVE[@]}"; do
    if [ -e "$item" ]; then
        mv "$item" .archive/old-structure-$TIMESTAMP/ 2>/dev/null
        echo "  → Archived: $item"
    fi
done

echo "✓ 아카이브 완료"

# 5. 최종 구조 적용
echo ""
echo "5. 최종 구조 적용..."

# .final 내용을 루트로 이동
cp -r .final/* .
rm -rf .final

echo "✓ 최종 구조 적용 완료"

# 6. 정리
echo ""
echo "6. 정리 중..."

# 빈 디렉토리 제거
find . -type d -empty -delete 2>/dev/null

# 통계
echo ""
echo "================================================"
echo "완료!"
echo "================================================"
echo ""
echo "이전: $(find .archive/old-structure-$TIMESTAMP -name "*.md" 2>/dev/null | wc -l) 개 파일"
echo "이후: $(find . -name "*.md" -not -path "./.archive/*" -not -path "./.git/*" 2>/dev/null | wc -l) 개 파일"
echo ""
echo "핵심 파일:"
echo "  - CLAUDE.md (진입점)"
echo "  - .claude/STATE.md (상태)"
echo "  - INSIGHTS.md (지혜)"
echo "  - .workflow/README.md (프로세스)"
echo "  - README.md (설명)"
echo ""
echo "아카이브: .archive/old-structure-$TIMESTAMP/"
echo ""
echo "이제 Clauder는 단순하고 강력합니다."