#!/bin/bash
# Clauder Git hooks 설치 스크립트

echo "🔧 Clauder Git hooks 설치 중..."

# Git 저장소 확인
if [ ! -d ".git" ]; then
    echo "❌ Git 저장소가 아닙니다. 먼저 git init을 실행하세요."
    exit 1
fi

# hooks 디렉토리 생성
mkdir -p .git/hooks

# pre-commit hook 설치
if [ -f ".claude/hooks/git/pre-commit" ]; then
    cp .claude/hooks/git/pre-commit .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
    echo "✅ pre-commit hook 설치 완료"
else
    echo "⚠️  pre-commit hook 파일을 찾을 수 없습니다"
fi

# 기존 hook 백업
if [ -f ".git/hooks/pre-commit.bak" ]; then
    echo "ℹ️  기존 hook 백업이 이미 존재합니다"
else
    if [ -f ".git/hooks/pre-commit" ]; then
        mv .git/hooks/pre-commit .git/hooks/pre-commit.bak
        echo "ℹ️  기존 pre-commit hook을 백업했습니다"
    fi
fi

echo ""
echo "📌 설치 완료!"
echo "이제 git commit 시 자동으로 문서 버전이 업데이트됩니다."
echo ""
echo "🔄 제거하려면: rm .git/hooks/pre-commit"
echo "🔙 복원하려면: mv .git/hooks/pre-commit.bak .git/hooks/pre-commit"