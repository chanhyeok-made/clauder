# Clauder 모듈화 유지 재구조화 계획

## 핵심 전략: 모듈화는 유지하되 체계화

### 1. 3계층 구조 확립
```
Level 1: CLAUDE.md (Router)
  ├─ Level 2: Domain Indexes (5-7개)
  │   ├─ .claude/workflow/INDEX.md
  │   ├─ .claude/tools/INDEX.md
  │   ├─ .claude/learning/INDEX.md
  │   ├─ .clauder-dev/principles/INDEX.md
  │   └─ .base-principles/INDEX.md
  └─ Level 3: Specific Documents (나머지)
```

### 2. 진입점 최적화
```markdown
# CLAUDE.md (스마트 라우터)

## ACTIVE_CONTEXT
현재 작업: @.claude/STATE.md#current_task
활성 모듈: @.claude/STATE.md#active_modules

## NAVIGATION_MAP
- 작업 시작 → @.workflow/core/INDEX.md
- 원칙 확인 → @.principles/base/INDEX.md
- 도구 사용 → @.tools/INDEX.md
- 학습 기록 → @.learning/INDEX.md
- 개발 가이드 → @.principles/development/INDEX.md
```

### 3. 상태 추적 시스템
```yaml
# .claude/STATE.md
current_session:
  started: 2025-01-09T15:45
  task: "Clauder 재구조화"
  
active_modules:
  - .claude/workflow/analysis.md
  - .clauder-dev/principles/12-DOCUMENT-MODULARITY.md
  
navigation_history:
  - CLAUDE.md
  - .claude/workflow/INDEX.md
  - .claude/workflow/analysis.md
  
pending_tasks:
  - "참조 그래프 정리"
  - "중복 문서 제거"
```

### 4. 자동 유지보수 도구

#### A. 참조 그래프 생성기
```bash
# build-reference-graph.sh
# 모든 @참조를 파싱하여 시각화
find . -name "*.md" | xargs grep "@\." > references.txt
python3 visualize_graph.py references.txt
```

#### B. 사용 빈도 추적
```bash
# track-usage.sh
# Git 히스토리에서 자주 수정되는 파일 추적
git log --name-only --pretty=format: | sort | uniq -c | sort -rn
```

#### C. 중복 감지기
```bash
# find-duplicates.sh
# 유사한 내용의 문서 찾기
for file in $(find . -name "*.md"); do
  md5sum "$file"
done | sort | uniq -d
```

### 5. 문서 정리 우선순위

#### Phase 1: INDEX 파일 생성 (즉시)
```bash
# 각 주요 디렉토리에 INDEX.md 생성
for dir in .claude/workflow .claude/tools .claude/learning; do
  create_index "$dir" > "$dir/INDEX.md"
done
```

#### Phase 2: 참조 수정 (1시간)
```bash
# 깨진 참조 자동 수정
fix_broken_references.sh
```

#### Phase 3: 중복 제거 (2시간)
```bash
# 중복 문서 병합
merge_duplicates.sh
```

### 6. 컨텍스트 유지 전략

#### A. Lazy Loading 강화
```markdown
# CLAUDE.md
## LOAD_ON_DEMAND
- 워크플로우 필요시: @.workflow/core/INDEX.md
- 원칙 확인 필요시: @.principles/base/INDEX.md
- 학습 조회 필요시: @.learning/INDEX.md
```

#### B. 모듈 활성화 추적
```bash
# on-module-load.sh
echo "$(date): Loaded $1" >> .claude/STATE.md
```

#### C. 세션 복구
```bash
# restore-session.sh
active_modules=$(grep "active_modules:" .claude/STATE.md)
for module in $active_modules; do
  echo "Restoring: $module"
done
```

## 실행 계획

### 즉시 (10분)
1. [ ] 주요 디렉토리에 INDEX.md 생성
2. [ ] CLAUDE.md를 라우터로 재구성
3. [ ] STATE.md 구조 확정

### 단기 (1시간)
1. [ ] 참조 그래프 생성 및 시각화
2. [ ] 깨진 참조 목록 작성
3. [ ] 사용 빈도 분석

### 중기 (3시간)
1. [ ] 중복 문서 병합
2. [ ] 사용 안 되는 문서 archive/로 이동
3. [ ] 참조 자동 수정

## 성공 지표
1. **진입점 명확성**: CLAUDE.md에서 3클릭 이내 도달
2. **참조 건전성**: 깨진 참조 0%
3. **컨텍스트 유지**: 재시작 후 이전 작업 즉시 파악
4. **모듈 독립성**: 각 모듈 독립적 업데이트 가능

## 핵심 차별점
- **NOT**: 모든 것을 하나로 합치기
- **BUT**: 체계적 계층과 명확한 네비게이션
- **RESULT**: 모듈화의 장점 + 단순함의 효율성