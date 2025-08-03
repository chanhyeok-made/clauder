#!/bin/bash

# 깨진 참조 자동 수정 스크립트

PROJECT_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"

echo "🔧 깨진 참조 수정 시작"

# 공통 패턴 수정
fix_references() {
    local file=$1
    
    # .claude/docs -> docs로 변경
    sed -i.bak 's|@\.claude/docs/|@docs/|g' "$file"
    
    # .claude/commands -> docs/commands로 변경
    sed -i.bak 's|@\.claude/commands/|@docs/commands/|g' "$file"
    
    # .claude/docs/guides -> docs/guides로 변경
    sed -i.bak 's|@\.claude/docs/guides/|@docs/guides/|g' "$file"
    
    # .claude/docs/principles -> .clauder-dev/principles로 변경
    sed -i.bak 's|@\.claude/docs/principles/|@.clauder-dev/principles/|g' "$file"
    
    # .claude/core -> .claude/templates/core로 변경
    sed -i.bak 's|@\.claude/core/|@.claude/templates/core/|g' "$file"
    
    # .claude/contexts -> docs/guides로 변경
    sed -i.bak 's|@\.claude/contexts/|@docs/guides/|g' "$file"
    
    # .claude/custom/overrides -> .claude/custom/overrides로 유지하되 파일 확인
    # 실제로는 존재하지 않는 예시 경로일 수 있음
    
    # .claude/docs/design -> .clauder-dev/design으로 변경
    sed -i.bak 's|@\.claude/docs/design/|@.clauder-dev/design/|g' "$file"
    
    # .claude/scripts -> .clauder-dev/tools/scripts로 변경
    sed -i.bak 's|@\.claude/scripts/|@.clauder-dev/tools/scripts/|g' "$file"
    
    # 별칭 참조 수정 (임시로 제거)
    sed -i.bak 's|@\[\$[^]]*\]|@TODO-ALIAS|g' "$file"
    
    # 백업 파일 제거
    rm -f "${file}.bak"
}

# 모든 .md 파일에 대해 수정 적용
echo "📝 참조 수정 중..."
find "$PROJECT_ROOT" -name "*.md" -type f | while read file; do
    if [[ ! "$file" =~ \.git/ ]]; then
        fix_references "$file"
        echo "✓ $(basename "$file")"
    fi
done

echo "✅ 참조 수정 완료!"