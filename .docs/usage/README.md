---
doc_id: 856
---

# 검증 레벨 가이드

> 효율적이고 실용적인 검증을 위한 레벨별 가이드입니다.

## TARGET: 핵심 원칙

1. **예방이 최선**: 올바른 작업 방법으로 문제 자체를 방지
2. **검증은 보조**: 필요한 만큼만, 적절한 시점에
3. **자동화 우선**: 반복적인 검증은 자동화

## 📊 검증 레벨

### Level 0: 자동 검증 (항상)
- **실행**: Git hooks, 에디터 플러그인
- **시간**: 즉시
- **항목**:
  - 문법 오류
  - 파일 포맷
  - 기본 린트

### Level 1: 경량 검증 (작업 완료 시)
- **실행**: 수동 또는 스크립트
- **시간**: 1-2분
- **항목**:
  - [ ] 새 파일에 doc_id 있나?
  - [ ] 커밋 메시지 형식 맞나?
  - [ ] 테스트 통과하나?

### Level 2: 표준 검증 (주요 작업 후)
- **실행**: 체크리스트 + 스크립트
- **시간**: 5-10분
- **항목**:
  - [ ] 버전 트리 동기화
  - [ ] 참조 일관성
  - [ ] 문서 완성도

### Level 3: 심층 검증 (주기적/특별)
- **실행**: 전체 검증 스크립트
- **시간**: 30분+
- **항목**:
  - 전체 참조 그래프 분석
  - 순환 참조 탐지
  - 성능 메트릭
  - 사용되지 않는 문서 찾기

## 🔧 검증 도구

### 자동 검증
```bash
# Git pre-commit hook
.git/hooks/pre-commit
```

### 수동 검증
```bash
# Level 1: 빠른 체크
./check-quick.sh

# Level 2: 표준 체크
./check-standard.sh

# Level 3: 전체 검증
./check-full.sh
```

## 📅 권장 주기

- **Level 0**: 항상 (자동)
- **Level 1**: 모든 작업 완료 시
- **Level 2**: PR 생성 전, 큰 기능 완료 시
- **Level 3**: 주 1회, 대규모 리팩토링 후

## TIP: 실용적 접근

### 하지 말아야 할 것
- FORBIDDEN: 모든 체크리스트를 매번 확인
- FORBIDDEN: 사소한 수정에도 전체 검증
- FORBIDDEN: 검증을 위한 검증

### 해야 할 것
- DONE: 작업 중 올바른 패턴 따르기
- DONE: 자동화 가능한 것은 자동화
- DONE: 상황에 맞는 검증 레벨 선택

## 📚 관련 문서

### 체크리스트
- @level1-checklist.md - Level 1 경량 검증 체크리스트
- @using-levels.md - 검증 레벨 사용 가이드

### 검증 스크립트
- 템플릿: @.principles/base/tools/validation/
- 프로젝트별로 복사하여 커스터마이징

### 관련 원칙
- @.principles/base/workflow/systematic-approach.md - 체계적 접근
- @.principles/base/structure/directory-organization.md - 디렉토리 구조