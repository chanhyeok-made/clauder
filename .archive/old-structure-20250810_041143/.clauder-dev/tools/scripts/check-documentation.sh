#!/bin/bash
# Level 2: 표준 검증 (5-10분)

echo "📋 Level 2 표준 검증 시작 (5-10분 소요)"
echo "======================================"

# 1. 새로 생성된 .md 파일 확인
echo "1. 새로 생성된 문서 확인:"
NEW_FILES=$(git status --porcelain | grep "^A.*\.md$" | awk '{print $2}')

if [ -z "$NEW_FILES" ]; then
    echo "   ✅ 새로 생성된 문서 없음"
else
    echo "   ⚠️  새 문서 발견:"
    echo "$NEW_FILES" | while read file; do
        echo "      - $file"
        
        # doc_id 확인
        if grep -q "^doc_id:" "$file"; then
            DOC_ID=$(grep "^doc_id:" "$file" | awk '{print $2}')
            echo "        ✅ doc_id: $DOC_ID"
            
            # 버전 트리에 있는지 확인
            if grep -q "$DOC_ID" .claude/version-tree.yaml; then
                echo "        ✅ 버전 트리에 등록됨"
            else
                echo "        ❌ 버전 트리에 없음! 즉시 추가 필요"
            fi
        else
            echo "        ❌ doc_id 없음! 추가 필요"
        fi
    done
fi

# 2. 수정된 .md 파일 확인
echo -e "\n2. 수정된 문서 확인:"
MODIFIED_FILES=$(git status --porcelain | grep "^M.*\.md$" | awk '{print $2}')

if [ -z "$MODIFIED_FILES" ]; then
    echo "   ✅ 수정된 문서 없음"
else
    echo "   📋 수정된 문서:"
    echo "$MODIFIED_FILES" | while read file; do
        echo "      - $file"
    done
fi

# 3. 버전 트리 상태 확인
echo -e "\n3. 버전 트리 상태:"
if git status --porcelain | grep -q "version-tree.yaml"; then
    echo "   ✅ 버전 트리가 수정됨"
else
    if [ ! -z "$NEW_FILES" ]; then
        echo "   ⚠️  새 문서가 있는데 버전 트리가 수정되지 않음!"
    else
        echo "   ✅ 버전 트리 수정 불필요"
    fi
fi

# 4. 버전 트리 commit 필드 검증
echo -e "\n4. 버전 트리 commit 필드 검증:"
if grep -E 'commit:\s*"(current|latest|HEAD)"' .claude/version-tree.yaml > /dev/null; then
    echo "   ❌ 위험! 상대 참조 발견!"
    echo "      다음 라인에서 'current', 'latest', 'HEAD' 사용:"
    grep -n -E 'commit:\s*"(current|latest|HEAD)"' .claude/version-tree.yaml
    echo "      즉시 실제 커밋 해시로 교체 필요!"
else
    echo "   ✅ 모든 commit 필드가 실제 해시 사용"
fi

echo -e "\n=========================="
echo "체크 완료. 위 사항을 확인하세요!"