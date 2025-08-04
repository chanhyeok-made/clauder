#!/bin/bash
# Level 1: 경량 검증 템플릿 (1-2분)

echo "🚀 Level 1 검증 시작 (1-2분 소요)"
echo "================================"

ERRORS=0

# 1. 새 문서 기본 검증
echo -n "📝 새 문서 검증... "
NEW_FILES=$(git status --porcelain | grep "^A.*\.md$" | awk '{print $2}')
if [ -z "$NEW_FILES" ]; then
    echo "✅ (새 문서 없음)"
else
    # 프로젝트별 검증 로직 추가
    echo "✅"
fi

# 2. 기본 검증 항목들
echo -n "🔍 기본 검증... "
# 프로젝트별 검증 추가
echo "✅"

echo "================================"
if [ $ERRORS -eq 0 ]; then
    echo "✨ Level 1 검증 완료! 문제없음"
else
    echo "⚠️  Level 1 검증 완료. $ERRORS 개 확인 필요"
fi

exit $ERRORS