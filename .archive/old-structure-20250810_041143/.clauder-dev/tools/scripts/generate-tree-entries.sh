#!/bin/bash
# 모든 .md 파일을 찾아서 버전 트리 엔트리 생성

echo "# 누락된 파일들의 버전 트리 엔트리"
echo ""

# 카운터 초기화
cmd_id=100
guide_id=302
template_id=400
other_id=506

# 모든 .md 파일 찾기
find . -name "*.md" -type f | grep -v node_modules | grep -v .resonation | sort | while read -r file; do
    # 상대 경로를 절대 경로로 변환
    path="/${file#./}"
    
    # 이미 트리에 있는 파일인지 확인 (간단한 체크)
    if grep -q "\"$path\"" .claude/version-tree.yaml 2>/dev/null; then
        continue
    fi
    
    # ID 할당
    if [[ $path == *"/commands/"* ]]; then
        id=$cmd_id
        ((cmd_id++))
    elif [[ $path == *"/guides/"* ]]; then
        id=$guide_id
        ((guide_id++))
    elif [[ $path == *"/templates/"* ]]; then
        id=$template_id
        ((template_id++))
    else
        id=$other_id
        ((other_id++))
    fi
    
    # 엔트리 생성
    echo "  $id:"
    echo "    path: \"$path\""
    echo "    created: \"2025-08-02\""
    echo "    updated: \"2025-08-02\""
    echo "    commit: \"e7b2ee3\""
    echo "    depends_on: []"
    echo "    referenced_by: []"
    echo ""
done

echo ""
echo "# path_to_id 인덱스 추가분"
echo ""

# 인덱스 생성
find . -name "*.md" -type f | grep -v node_modules | grep -v .resonation | sort | while read -r file; do
    path="/${file#./}"
    
    if grep -q "\"$path\"" .claude/version-tree.yaml 2>/dev/null; then
        continue
    fi
    
    # ID 재할당 (위와 동일한 로직)
    if [[ $path == *"/commands/"* ]]; then
        id=$cmd_id
        ((cmd_id++))
    elif [[ $path == *"/guides/"* ]]; then
        id=$guide_id
        ((guide_id++))
    elif [[ $path == *"/templates/"* ]]; then
        id=$template_id
        ((template_id++))
    else
        id=$other_id
        ((other_id++))
    fi
    
    echo "  \"$path\": $id"
done