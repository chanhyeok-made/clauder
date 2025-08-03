---
doc_id: 720
---

#!/bin/bash

# doc_id 일괄 마이그레이션 스크립트

PROJECT_ROOT="/Users/chanhyeok/Documents/DocumentsChanhyeokMacStudio/projects/clauder"
VERSION_TREE="$PROJECT_ROOT/.claude/version-tree.yaml"

echo "🚀 doc_id 일괄 마이그레이션 시작"

# 통계
migrated=0
already_done=0
not_found=0

# 모든 .md 파일 처리
find "$PROJECT_ROOT" -name "*.md" -type f | while read file; do
    # 제외할 디렉토리
    if [[ "$file" == *"/.git/"* ]] || [[ "$file" == */node_modules/* ]] || [[ "$file" == */.resonation/* ]]; then
        continue
    fi
    
    # 이미 doc_id가 있는지 확인
    if grep -q "^doc_id:" "$file"; then
        already_done=$((already_done + 1))
        continue
    fi
    
    # 상대 경로 계산
    rel_path="/${file#$PROJECT_ROOT/}"
    
    # 버전 트리에서 doc_id 찾기
    doc_id=$(grep -B1 "path: \"$rel_path\"" "$VERSION_TREE" | head -1 | grep -o '^ *[0-9]\+:' | tr -d ': ')
    
    if [ -z "$doc_id" ]; then
        echo "⚠️  버전 트리에 없음: $rel_path"
        not_found=$((not_found + 1))
        continue
    fi
    
    # 임시 파일 생성
    temp_file=$(mktemp)
    
    # doc_id 추가하고 구 메타데이터 제거
    echo "---" > "$temp_file"
    echo "doc_id: $doc_id" >> "$temp_file"
    echo "---" >> "$temp_file"
    echo "" >> "$temp_file"
    
    # 기존 front matter 제거하고 내용 추가
    if grep -q "^---" "$file"; then
        # front matter가 있으면 제거
        awk 'BEGIN{fm=0} /^---$/{fm++; if(fm==2){getline; fm=0}} fm==0{print}' "$file" | sed '1,/^$/d' >> "$temp_file"
    else
        # front matter가 없으면 그대로
        cat "$file" >> "$temp_file"
    fi
    
    # 원본 파일 교체
    mv "$temp_file" "$file"
    
    echo "✅ 마이그레이션 완료: $rel_path (doc_id: $doc_id)"
    migrated=$((migrated + 1))
done

echo ""
echo "📊 마이그레이션 결과:"
echo "  마이그레이션 완료: $migrated"
echo "  이미 완료됨: $already_done"  
echo "  버전 트리에 없음: $not_found"