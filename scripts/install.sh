#!/bin/bash
# Clauder 설치 스크립트

set -e

# 색상 정의
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Clauder - Claude Code 문서 템플릿 시스템 설치${NC}"
echo ""

# 기존 .claude 디렉토리 확인
if [ -d ".claude" ]; then
    echo -e "${RED}⚠️  .claude 디렉토리가 이미 존재합니다.${NC}"
    read -p "덮어쓰시겠습니까? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "설치가 취소되었습니다."
        exit 1
    fi
    mv .claude .claude.backup.$(date +%Y%m%d%H%M%S)
    echo -e "${GREEN}✓ 기존 디렉토리를 백업했습니다.${NC}"
fi

# 기존 CLAUDE.md 백업
if [ -f "CLAUDE.md" ]; then
    mv CLAUDE.md CLAUDE.md.backup.$(date +%Y%m%d%H%M%S)
    echo -e "${GREEN}✓ 기존 CLAUDE.md를 백업했습니다.${NC}"
fi

# Clauder 다운로드
echo -e "${BLUE}▶ 템플릿 다운로드 중...${NC}"
curl -fsSL https://github.com/chanhyeok-made/clauder/archive/main.tar.gz | tar -xz

# 파일 이동
mv clauder-main/.claude .
rm -rf clauder-main

echo -e "${GREEN}✓ 설치가 완료되었습니다!${NC}"
echo ""
echo "다음 단계:"
echo "1. Claude Code를 실행하세요"
echo "2. 다음 명령을 입력하세요: @initialize project"
echo ""
echo -e "${BLUE}자세한 사용법은 .claude/README.md를 참조하세요.${NC}"