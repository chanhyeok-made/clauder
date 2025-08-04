#!/bin/bash
# Level 1: 경량 검증 (1-2분)

echo "🚀 Level 1 검증 시작 (1-2분 소요)"
echo "================================"

ERRORS=0

# 1. 새 .md 파일의 doc_id 확인
echo -n "📝 새 문서 doc_id 확인... "
NEW_FILES=$(git status --porcelain | grep "^A.*\.md$" | awk '{print $2}')
if [ -z "$NEW_FILES" ]; then
    echo "✅ (새 문서 없음)"
else
    DOC_ID_MISSING=false
    while IFS= read -r file; do
        if [ -n "$file" ] && ! grep -q "^doc_id:" "$file" 2>/dev/null; then
            if [ "$DOC_ID_MISSING" = "false" ]; then
                echo ""
            fi
            echo "   ⚠️  $file 에 doc_id 없음!"
            DOC_ID_MISSING=true
        fi
    done <<< "$NEW_FILES"
    
    if [ "$DOC_ID_MISSING" = "false" ]; then
        echo "✅"
    else
        ERRORS=$((ERRORS + 1))
    fi
fi

# 2. 커밋 메시지 형식 힌트
echo -n "💬 커밋 메시지 형식... "
echo "✅ (type: description 형식 사용하세요)"

# 3. 빠른 테스트 실행 (있다면)
if [ -f "package.json" ] && grep -q "test" package.json; then
    echo -n "🧪 테스트 실행... "
    if npm test --silent 2>/dev/null; then
        echo "✅"
    else
        echo "❌"
        ERRORS=$((ERRORS + 1))
    fi
fi

echo "================================"
if [ $ERRORS -eq 0 ]; then
    echo "✨ Level 1 검증 완료! 문제없음"
else
    echo "⚠️  Level 1 검증 완료. $ERRORS 개 확인 필요"
fi

# 다음 단계 안내
if git diff --cached --name-only | grep -E "(version-tree\.yaml|\.md$)" > /dev/null; then
    echo ""
    echo "💡 큰 변경사항이 있어 보입니다. Level 2 검증도 고려해보세요:"
    echo "   ./check-level2.sh"
fi