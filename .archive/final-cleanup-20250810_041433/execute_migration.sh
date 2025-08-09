#!/bin/bash
# Clauder 문서 마이그레이션 실행 스크립트

set -e  # 에러 발생 시 중단

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "================================================"
echo "Clauder Migration Execution Script"
echo "================================================"
echo ""

# 1. 백업 생성
echo -e "${BLUE}Step 1: 백업 생성${NC}"
BACKUP_DIR=".backup/$TIMESTAMP"
mkdir -p "$BACKUP_DIR"

# 현재 상태 저장
tar -czf "$BACKUP_DIR/clauder_backup_$TIMESTAMP.tar.gz" \
    --exclude='.git' \
    --exclude='node_modules' \
    --exclude='.backup' \
    .

echo -e "${GREEN}✓ 백업 완료: $BACKUP_DIR${NC}"
echo ""

# 2. 새 디렉토리 구조 생성
echo -e "${BLUE}Step 2: 새 디렉토리 구조 생성${NC}"

NEW_DIRS=(
    ".principles/base"
    ".principles/development"
    ".principles/usage"
    ".workflow/core"
    ".workflow/automation"
    ".workflow/patterns"
    ".learning/lessons"
    ".learning/analysis"
    ".learning/patterns"
    ".tools/validators"
    ".tools/hooks"
    ".tools/scripts"
    ".templates/project"
    ".templates/document"
    ".templates/code"
    ".docs/guides"
    ".docs/references"
    ".examples"
    ".archive/legacy"
    ".archive/deprecated"
    ".archive/misc"
)

for dir in "${NEW_DIRS[@]}"; do
    mkdir -p "$dir"
    echo -e "  ${GREEN}✓${NC} $dir"
done

echo ""

# 3. Python 스크립트로 마이그레이션 실행
echo -e "${BLUE}Step 3: 문서 마이그레이션${NC}"

python3 << 'EOF'
import json
import os
import shutil
import re
from pathlib import Path

# migration_map.json 로드
with open('migration_map.json', 'r') as f:
    migration_map = json.load(f)

# 마이그레이션 카운터
migrated = 0
failed = 0
skipped = 0

# 카테고리별 타겟 디렉토리 매핑
category_dirs = {
    'principles': '.principles/',
    'workflow': '.workflow/',
    'learning': '.learning/',
    'tools': '.tools/',
    'templates': '.templates/',
    'documentation': '.docs/',
    'examples': '.examples/',
    'misc': '.archive/misc/'
}

# 마이그레이션 실행
for item in migration_map['migrations']:
    old_path = item['old']
    category = item['category']
    
    # 파일이 존재하는지 확인
    if not os.path.exists(old_path):
        print(f"  ⚠️  파일 없음: {old_path}")
        skipped += 1
        continue
    
    # 새 경로 결정
    base_dir = category_dirs.get(category, '.archive/misc/')
    
    # 세부 디렉토리 결정
    if '.clauder-dev/' in old_path:
        sub_dir = 'development/'
    elif '.claude/' in old_path:
        sub_dir = 'usage/'
    elif '.base-principles/' in old_path:
        sub_dir = 'base/'
    else:
        sub_dir = ''
    
    new_dir = base_dir + sub_dir
    new_path = new_dir + os.path.basename(old_path)
    
    # 이미 새 위치에 파일이 있는지 확인
    if os.path.exists(new_path):
        # 내용이 같은지 확인
        with open(old_path, 'r') as f1, open(new_path, 'r') as f2:
            if f1.read() == f2.read():
                print(f"  → 이미 존재 (동일): {new_path}")
                skipped += 1
                continue
            else:
                # 다른 내용이면 백업
                backup_path = new_path + '.backup'
                shutil.copy2(new_path, backup_path)
                print(f"  ⚠️  기존 파일 백업: {backup_path}")
    
    # 파일 복사 (이동이 아닌 복사)
    try:
        os.makedirs(os.path.dirname(new_path), exist_ok=True)
        shutil.copy2(old_path, new_path)
        print(f"  ✓ {old_path} → {new_path}")
        migrated += 1
    except Exception as e:
        print(f"  ✗ 실패: {old_path} - {e}")
        failed += 1

print(f"\n마이그레이션 결과:")
print(f"  - 성공: {migrated}개")
print(f"  - 실패: {failed}개")
print(f"  - 건너뜀: {skipped}개")

# 마이그레이션 결과 저장
result = {
    'migrated': migrated,
    'failed': failed,
    'skipped': skipped
}

with open('migration_result.json', 'w') as f:
    json.dump(result, f, indent=2)
EOF

echo ""

# 4. INDEX 파일 생성
echo -e "${BLUE}Step 4: INDEX 파일 생성${NC}"

# 각 주요 디렉토리에 INDEX.md 생성
for dir in .principles .workflow .learning .tools .templates .docs; do
    if [ -d "$dir" ]; then
        cat > "$dir/INDEX.md" << INDEXEOF
---
doc_id: $(uuidgen | tr '[:upper:]' '[:lower:]' | head -c 8)
role: navigation_hub
last_updated: $(date +%Y-%m-%d)
auto_generated: true
---

# $(basename $dir) Navigation Hub

## 디렉토리 구조
$(find $dir -type d | head -20)

## 문서 목록
$(find $dir -name "*.md" -type f | head -50 | while read f; do echo "- @${f#./}"; done)

## 통계
- 총 문서: $(find $dir -name "*.md" | wc -l)개
- 하위 디렉토리: $(find $dir -type d | wc -l)개

---
이 INDEX는 자동 생성되었습니다.
INDEXEOF
        echo -e "  ${GREEN}✓${NC} $dir/INDEX.md 생성"
    fi
done

echo ""

# 5. 참조 업데이트
echo -e "${BLUE}Step 5: 참조 업데이트${NC}"

# 참조 매핑 테이블 생성
cat > update_references.py << 'REFEOF'
import os
import re

# 주요 경로 변경 매핑
path_mappings = [
    (r'@\.clauder-dev/principles/', '@.principles/development/'),
    (r'@\.claude/workflow/', '@.workflow/core/'),
    (r'@\.claude/tools/', '@.tools/'),
    (r'@\.base-principles/', '@.principles/base/'),
    (r'@\.clauder-dev/learnings/', '@.learning/lessons/'),
    (r'@\.clauder-dev/analysis/', '@.learning/analysis/'),
]

# 모든 마크다운 파일에서 참조 업데이트
updated_files = 0
for root, dirs, files in os.walk('.'):
    if '.git' in root or '.backup' in root:
        continue
        
    for file in files:
        if file.endswith('.md'):
            filepath = os.path.join(root, file)
            
            try:
                with open(filepath, 'r') as f:
                    content = f.read()
                
                original = content
                for old_pattern, new_pattern in path_mappings:
                    content = re.sub(old_pattern, new_pattern, content)
                
                if content != original:
                    with open(filepath, 'w') as f:
                        f.write(content)
                    updated_files += 1
                    print(f"  ✓ 참조 업데이트: {filepath}")
                    
            except Exception as e:
                print(f"  ✗ 실패: {filepath} - {e}")

print(f"\n총 {updated_files}개 파일의 참조 업데이트 완료")
REFEOF

python3 update_references.py
rm update_references.py

echo ""

# 6. 검증
echo -e "${BLUE}Step 6: 마이그레이션 검증${NC}"

# 깨진 참조 확인
echo "깨진 참조 확인 중..."
BROKEN_REFS=$(grep -r "@\." --include="*.md" 2>/dev/null | while read line; do
    file=$(echo "$line" | cut -d: -f1)
    ref=$(echo "$line" | grep -o "@[./a-zA-Z0-9_-]*\.md")
    target=${ref#@}
    
    if [ ! -f "$target" ]; then
        echo "  BROKEN: $file → $ref"
    fi
done | wc -l)

echo -e "  깨진 참조: ${BROKEN_REFS}개"

# 통계
echo ""
echo -e "${BLUE}마이그레이션 통계${NC}"
echo "------------------------------------------------"
echo "원본 문서:"
find . -name "*.md" -not -path "./.principles/*" \
       -not -path "./.workflow/*" \
       -not -path "./.learning/*" \
       -not -path "./.tools/*" \
       -not -path "./.templates/*" \
       -not -path "./.docs/*" \
       -not -path "./.archive/*" \
       -not -path "./.backup/*" | wc -l

echo "마이그레이션된 문서:"
find .principles .workflow .learning .tools .templates .docs -name "*.md" 2>/dev/null | wc -l

echo ""

# 7. 정리 옵션
echo -e "${YELLOW}Step 7: 정리${NC}"
echo "마이그레이션이 완료되었습니다."
echo ""
echo "다음 명령으로 원본 파일을 제거할 수 있습니다:"
echo "  ./cleanup_old_structure.sh"
echo ""
echo "원본 파일을 유지하려면 이 단계를 건너뛰세요."
echo ""

# 완료
echo "================================================"
echo -e "${GREEN}✅ 마이그레이션 완료!${NC}"
echo "================================================"
echo ""
echo "다음 단계:"
echo "1. 새 구조 확인: tree -L 2"
echo "2. 문서 검증: .claude/validators/document-freshness.sh"
echo "3. Git 커밋: git add . && git commit -m 'refactor: 문서 구조 마이그레이션'"