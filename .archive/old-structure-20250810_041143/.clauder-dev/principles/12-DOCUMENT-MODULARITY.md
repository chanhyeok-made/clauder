---
doc_id: 12
title: 문서 모듈화 및 참조 일관성
priority: CRITICAL
last_updated: 2025-08-10
references:
  - @.principles/base/CORE-PURPOSE.md
  - @.principles/development/01-REFERENCE-STRUCTURE.md
back_references:
  - @CLAUDE.md
---

# 문서 모듈화 및 참조 일관성 원칙

## 핵심: 완벽한 모듈화와 참조 체계

### 1. 문서 모듈화 규칙

#### 단일 책임 원칙
```markdown
# BAD: multiple-concepts.md
- 워크플로우 설명
- 도구 사용법
- 설정 가이드

# GOOD: 
- workflow.md (워크플로우만)
- tools.md (도구만)
- config.md (설정만)
```

#### 파일 크기 제한
- **최대 200줄**: 그 이상은 분할
- **최소 20줄**: 그 이하는 병합 고려
- **적정 크기**: 50-150줄

#### 명명 규칙
```
kebab-case.md          # 일반 문서
UPPERCASE.md           # 중요 문서 (CLAUDE.md, README.md)
01-numbered.md         # 순서가 있는 문서
category/subcategory.md # 계층 구조
```

### 2. 참조 구조 일관성

#### 참조 형식
```markdown
# 절대 참조 (프로젝트 루트 기준)
@/.claude/workflow/README.md

# 상대 참조 (현재 위치 기준)
@./sibling.md
@../parent/doc.md

# 섹션 참조
@.workflow/core/README.md#specific-section

# 줄 번호 참조
@src/auth.js:42
```

#### 양방향 참조 관리
```yaml
# 문서 A
references:
  - @document-B.md
  
# 문서 B (자동 업데이트 필요)
back_references:
  - @document-A.md
```

### 3. 최신성 보장 메커니즘

#### 필수 메타데이터
```yaml
---
doc_id: 유니크ID
last_updated: 2025-08-10
expires: 2025-09-10  # 선택적, 임시 문서
stale_after: 30  # 일 단위, 경고 시점
---
```

#### 버전 의존성
```yaml
depends_on:
  - doc: @workflow.md
    version: ">= 2.0.0"
  - doc: @tools.md
    last_updated: ">= 2025-08-01"
```

#### 자동 검증 스크립트
```bash
# check-freshness.sh
find . -name "*.md" -type f | while read file; do
  last_updated=$(grep "last_updated:" "$file" | cut -d: -f2)
  if [[ $(date -d "$last_updated" +%s) < $(date -d "30 days ago" +%s) ]]; then
    echo "OUTDATED: $file"
  fi
done
```

### 4. 참조 검증 시스템

#### 깨진 참조 감지
```bash
# validate-references.sh
grep -r "@\." --include="*.md" | while read line; do
  ref=$(echo "$line" | grep -o "@[./a-zA-Z0-9-]*")
  target=${ref#@}
  if [ ! -f "$target" ]; then
    echo "BROKEN: $ref in $file"
  fi
done
```

#### 순환 참조 방지
```bash
# detect-circular.sh
# A → B → C → A 형태 감지
build_dependency_graph() {
  # 그래프 구축 후 사이클 감지
}
```

### 5. 상시 리마인더 시스템

#### CLAUDE.md 강제 포함
```markdown
## NEVER_FORGET: Clauder 핵심 목표
@.principles/base/CORE-PURPOSE.md
- 토큰 효율성
- 체계적 작업
- 지속적 학습
- 작업 완전성
```

#### 작업 시작 체크리스트
```bash
# pre-work-check.sh
echo "=== CLAUDER 목표 확인 ==="
echo "1. 토큰 효율적인가?"
echo "2. 체계적 프로세스인가?"
echo "3. 학습이 기록되는가?"
echo "4. 작업이 완료되는가?"
read -p "모두 확인했습니까? (y/n): " confirm
```

### 6. 문서 업데이트 훅

#### Git Pre-commit Hook
```bash
#!/bin/bash
# .git/hooks/pre-commit

# 수정된 마크다운 파일 검사
git diff --cached --name-only --diff-filter=M | grep "\.md$" | while read file; do
  # last_updated 자동 갱신
  sed -i "s/last_updated:.*/last_updated: $(date +%Y-%m-%d)/" "$file"
  
  # 참조 검증
  validate_references "$file"
  
  # 역참조 업데이트
  update_back_references "$file"
  
  git add "$file"
done
```

### 7. 문서 품질 메트릭

#### 측정 지표
```yaml
metrics:
  modularity_score:
    files_under_200_lines: 95%
    single_concept_files: 100%
  
  reference_health:
    broken_references: 0
    bidirectional_complete: 100%
  
  freshness:
    updated_within_30_days: 85%
    has_last_updated: 100%
  
  consistency:
    follows_naming: 100%
    has_metadata: 100%
```

## 실제 적용 예시

### 문서 생성 시
```bash
# create-doc.sh
cat > new-doc.md << EOF
---
doc_id: $(uuidgen)
created: $(date +%Y-%m-%d)
last_updated: $(date +%Y-%m-%d)
references: []
back_references: []
---

# 제목

## 목적

## 내용

## 참조
EOF
```

### 문서 참조 시
```markdown
# document-a.md
이 기능은 @.tools/validator.md 참조

# 자동으로 validator.md에 추가됨:
back_references:
  - @document-a.md
```

## 검증 명령

```bash
# 전체 문서 시스템 검증
./validate-all-docs.sh

# 결과
✓ 모듈화: 95% (190/200 files)
✓ 참조 건전성: 100% (0 broken)
✓ 최신성: 87% (174/200 updated)
✓ 일관성: 100% (200/200 compliant)
```

## CRITICAL: 이 원칙을 항상 기억하세요

**문서는 Clauder의 핵심입니다.**
- 모듈화되지 않은 문서는 혼란을 만듭니다
- 깨진 참조는 신뢰를 무너뜨립니다
- 오래된 문서는 잘못된 결정을 만듭니다

**매 작업마다 확인하세요:**
1. 문서가 단일 개념을 다루는가?
2. 참조가 올바른가?
3. last_updated가 현재인가?
4. 역참조가 업데이트되었는가?