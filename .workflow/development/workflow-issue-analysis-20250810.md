---
doc_id: 5012
created: 2025-08-10
type: critical-issue
priority: HIGH
---

# Workflow 불일치 문제 분석

## 🔴 발견된 문제

### 1. CLAUDE.md vs Workflow Module 불일치

#### CLAUDE.md 지시사항 (잘못됨)
```markdown
즉시 TodoWrite로 11개 항목 생성:
1.1 분석: 요구사항이 명확한가?
1.2 분석: 작업 크기와 접근법 결정
2.1 구현: 코드베이스 이해 후 시작
...
```
- 11개 TODO를 한번에 생성
- 평면적 구조

#### 실제 Workflow Module (올바름)
```bash
# 5개 기본 단계
stages=("analysis" "implementation" "review" "documentation" "commit")

# 각 단계별 서브 태스크
describe_stage() {
  case "$stage" in
    "analysis")
      - Clarify requirements
      - Identify unknowns
      - Determine approach
      - Create TODOs
    "implementation")
      - Write code
      - Create/modify files
      ...
}
```
- 5개 메인 단계
- 각 단계마다 서브 태스크

### 2. 왜 작동하지 않는가?

#### 문제 1: 구조적 불일치
```
CLAUDE.md: 평면 구조 (11개 한번에)
    ↓ 충돌
Workflow: 계층 구조 (5단계 + 서브)
```

#### 문제 2: TodoWrite 오해
```javascript
// Claude Code가 이해하는 것
TodoWrite([11개 항목 한번에])

// 실제로 필요한 것
1. 현재 단계 확인
2. 해당 단계의 서브 태스크 생성
3. 단계 완료 시 다음 단계로
```

#### 문제 3: 상태 관리 불일치
```bash
# Workflow Module
CURRENT_STAGE="analysis"  # 단계별 진행

# CLAUDE.md 지시
"11개 전체 생성"  # 한번에 모든 단계
```

## 💡 올바른 구현

### 수정된 CLAUDE.md
```markdown
## IMMEDIATE: 작업 요청 시 즉시 실행

### REQUIRED: 워크플로우 단계별 TODO 생성
```
현재 워크플로우 단계 확인 후 해당 단계 TODO 생성:
- analysis 단계라면: 요구사항 분석, 접근법 결정
- implementation 단계라면: 코드 작성, 테스트 구현
- review 단계라면: 테스트 실행, 검증
- documentation 단계라면: 문서 업데이트
- commit 단계라면: 변경사항 검토, 커밋
```
```

### 올바른 실행 흐름
```bash
# 1. 현재 단계 확인
current_stage=$(get_current_stage)  # "analysis"

# 2. 해당 단계 서브 태스크 생성
case "$current_stage" in
  "analysis")
    TodoWrite([
      "요구사항 명확히 하기",
      "미지의 것 파악하기",
      "접근법 결정하기"
    ])
    ;;
esac

# 3. 단계 완료 후 전진
advance_stage()  # analysis → implementation
```

## 🔧 Clauder 자체 학습 시스템 설계

### Resonation 대신 내장 학습

#### 1. 학습 데이터 저장 구조
```
.clauder-dev/learning/
├── patterns/           # 패턴 인식
│   ├── errors/        # 에러 해결 패턴
│   ├── success/       # 성공 패턴
│   └── optimization/  # 최적화 패턴
├── project-memory/    # 프로젝트별 기억
│   ├── conventions/   # 코딩 컨벤션
│   ├── preferences/   # 선호 설정
│   └── history/       # 작업 이력
└── insights/          # 통찰과 개선
    ├── automated/     # 자동 발견
    └── manual/        # 수동 기록
```

#### 2. 학습 메커니즘
```bash
# 에러 학습
learn_from_error() {
  local error="$1"
  local solution="$2"
  
  # 패턴 저장
  cat >> .clauder-dev/learning/patterns/errors/$(date +%Y%m).md << EOF
## $(date): $error
해결: $solution
파일: $(git diff --name-only)
EOF
}

# 성공 학습
learn_from_success() {
  local task="$1"
  local approach="$2"
  
  cat >> .clauder-dev/learning/patterns/success/$(date +%Y%m).md << EOF
## $(date): $task
접근법: $approach
소요시간: $duration
EOF
}
```

#### 3. 패턴 적용
```bash
# 유사 문제 검색
find_similar_pattern() {
  local current_issue="$1"
  
  # 이전 해결책 검색
  grep -r "$current_issue" .clauder-dev/learning/patterns/
  
  # 제안
  if [ -f ".clauder-dev/learning/patterns/errors/*$current_issue*" ]; then
    echo "SUGGESTION: 이전에 해결한 유사 문제 발견"
    cat ".clauder-dev/learning/patterns/errors/*$current_issue*"
  fi
}
```

#### 4. 프로젝트 메모리
```bash
# 프로젝트 특성 기억
remember_project_trait() {
  local trait_type="$1"  # convention, preference, pattern
  local trait_value="$2"
  
  echo "$trait_value" >> ".clauder-dev/learning/project-memory/$trait_type/$(date +%Y%m).log"
}

# 적용
apply_project_memory() {
  # 커밋 스타일 적용
  if [ -f ".clauder-dev/learning/project-memory/conventions/commit-style.txt" ]; then
    COMMIT_STYLE=$(cat .clauder-dev/learning/project-memory/conventions/commit-style.txt)
  fi
}
```

## 📝 즉시 필요한 수정

### 1. CLAUDE.md 수정
```markdown
### REQUIRED: 현재 워크플로우 단계 실행
```
1. 현재 단계 확인: get_current_stage
2. 해당 단계 태스크 생성
3. 완료 후 advance_stage
```
```

### 2. Workflow 모듈 개선
```bash
# 단계별 자동 TODO 생성
auto_create_stage_todos() {
  local stage=$(get_current_stage)
  
  case "$stage" in
    "analysis")
      create_workflow_todo "요구사항 명확히 하기"
      create_workflow_todo "접근법 결정하기"
      ;;
    "implementation")
      create_workflow_todo "코드 작성하기"
      create_workflow_todo "테스트 작성하기"
      ;;
    # ...
  esac
}
```

### 3. 학습 시스템 초기화
```bash
# 학습 디렉토리 생성
mkdir -p .clauder-dev/learning/{patterns,project-memory,insights}

# 학습 훅 추가
echo "source .clauder-dev/learning/learn.sh" >> .claude/hooks/post-task.sh
```

## 결론

### 문제의 본질
1. **CLAUDE.md가 Workflow 모듈의 실제 구조를 반영하지 못함**
2. **평면적 TODO 생성 vs 단계별 진행의 충돌**
3. **Resonation 의존 대신 자체 학습 시스템 필요**

### 해결책
1. **CLAUDE.md를 단계별 실행으로 수정**
2. **Workflow 모듈과 일치하는 지시사항**
3. **Clauder 내장 학습 시스템 구축**

이렇게 하면 Workflow가 의도대로 작동하고, Clauder가 스스로 학습하며 발전할 수 있습니다.