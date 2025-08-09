---
doc_id: 4001
module: workflow
version: 2.0.0
---

# Workflow Module

## 개요
Clauder의 체계적인 워크플로우 관리를 제공하는 핵심 모듈

## 기능

### 1. Stage Management
- 5단계 워크플로우: Analysis → Implementation → Review → Documentation → Commit
- 현재 단계 추적
- 단계별 진행 관리

### 2. TODO Integration
- 단계별 TODO 생성
- 진행 상황 추적
- 완료 표시

### 3. State Management
- 세션 관리
- 진행 상황 저장
- 복구 지원

## 설치

```bash
clauder module add workflow@2.0.0
```

## 사용법

### 초기화
```bash
# 모듈이 자동으로 초기화됨
source modules/workflow/src/init.sh
```

### 현재 단계 확인
```bash
get_current_stage
# Output: analysis
```

### 단계 변경
```bash
set_current_stage "implementation"
# Output: DONE: Stage updated to: implementation
```

### 다음 단계로 진행
```bash
advance_stage
# Output: DONE: Stage updated to: review
```

### 워크플로우 상태 확인
```bash
show_workflow_status
# Output:
# → analysis (current)
#   implementation
#   review
#   documentation
#   commit
```

### TODO 관리
```bash
# TODO 생성
create_workflow_todo "API 엔드포인트 구현"

# TODO 완료
complete_todo 1
```

## 설정

### clauder.config
```yaml
modules:
  - workflow@2.0.0

overrides:
  workflow:
    stages:
      - planning
      - development
      - testing
      - deployment
    auto_advance: false
    strict_mode: true
```

## 단계별 가이드

### Analysis (분석)
- 요구사항 명확화
- 접근 방법 결정
- TODO 목록 작성

### Implementation (구현)
- 코드 작성
- 파일 생성/수정
- 기능 구현

### Review (검토)
- 테스트 실행
- 코드 리뷰
- 버그 수정

### Documentation (문서화)
- 변경사항 기록
- 가이드 작성
- 학습 사항 정리

### Commit (커밋)
- 변경사항 검토
- 커밋 메시지 작성
- GitHub 푸시

## 파일 구조

```
workflow/
├── module.json       # 모듈 메타데이터
├── README.md        # 이 파일
├── src/
│   └── init.sh      # 초기화 스크립트
├── bin/
│   ├── stage.sh     # Stage 관리 명령
│   └── workflow.sh  # Workflow 명령
├── templates/       # 워크플로우 템플릿
└── hooks/          # 생명주기 훅
```

## 의존성
- validation@^1.0.0 (선택적)

## 호환성
- Clauder: ^2.0.0
- OS: macOS, Linux
- Shell: bash, zsh

## 문제 해결

### 워크플로우가 초기화되지 않음
```bash
# 수동 초기화
source modules/workflow/src/init.sh
```

### 단계가 변경되지 않음
```bash
# 상태 파일 확인
cat $RUNTIME_DIR/state/workflow.json
```

## 기여
Issues와 PR은 GitHub 저장소로 제출해주세요.

## 라이선스
MIT