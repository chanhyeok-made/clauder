---
doc_id: 751
---

# 🎯 Lazy Loading 아키텍처 설계

## 문제점
현재 CLAUDE.md가 너무 많은 정보를 포함하고 있어, Claude가 새 세션마다 모든 것을 읽어야 함

## 해결 방안: 계층적 참조 구조

### 1단계: 최소화된 CLAUDE.md
```markdown
# Clauder 프로젝트

## 필수 사항
- 작업 방식: @.claude/guides/workflow.md
- 원칙: @.principles/base/README.md
- 긴급: @.claude/alerts/urgent.md

## 프로젝트 정보
- 개요: @.claude/project/overview.md
- 기술: @.claude/project/tech-stack.md
```
**토큰: ~200개**

### 2단계: 1차 참조 문서 (필요시 로드)
```markdown
# workflow.md (간략)
## 작업 단계
1. 분석: @.workflow/core/analysis.md
2. 구현: @.workflow/core/implementation.md
3. 회고: @.workflow/core/retrospective.md

## 자동화
- TodoWrite 사용법: @.tools/todo.md
- Git 워크플로우: @.tools/git.md
```
**토큰: ~300개**

### 3단계: 세부 참조 (특정 작업시만)
```markdown
# analysis.md (상세)
## 요구사항 분석
### 명확성 체크리스트
- 기술 명세 확인
- 성공 기준 파악
- ...상세 내용...

### 불명확시 프로토콜
- ...구체적 단계...
```
**토큰: 필요시만**

## 참조 계층 구조

```
CLAUDE.md (200 토큰)
  ├── 필수 워크플로우 (300 토큰)
  │   ├── 분석 상세 (500 토큰)
  │   ├── 구현 상세 (500 토큰)
  │   └── 회고 상세 (300 토큰)
  ├── 원칙 요약 (200 토큰)
  │   ├── 기반 원칙 상세 (각 300 토큰)
  │   └── 개발 원칙 상세 (각 300 토큰)
  └── 프로젝트 개요 (300 토큰)
      ├── 기술 상세 (500 토큰)
      └── 아키텍처 (800 토큰)
```

## 로딩 전략

### 1. 초기 로드 (필수)
- CLAUDE.md만 (~200 토큰)

### 2. 작업별 로드
```yaml
"API 수정해줘":
  - workflow.md
  - project/tech-stack.md
  - project/api-patterns.md

"문서 작성해줘":
  - workflow.md
  - principles/documentation.md
  
"버그 수정해줘":
  - workflow.md
  - workflow/analysis.md
  - debugging-guide.md
```

### 3. 깊이별 로드
```
Level 0: CLAUDE.md (항상)
Level 1: 작업 유형별 가이드 (필요시)
Level 2: 구체적 방법론 (특정 상황)
Level 3: 예시와 템플릿 (참고용)
```

## 구현 방법

### 1. CLAUDE.md 리팩토링
```markdown
# 현재 (1500+ 토큰)
[모든 내용 직접 포함]

# 개선 후 (200 토큰)
[참조만 포함]
```

### 2. 참조 문서 모듈화
- 각 문서는 하나의 주제만
- 300-500 토큰 이내
- 더 깊은 참조 제공

### 3. 스마트 로딩 힌트
```markdown
<!-- load-when: api-work -->
@.claude/api/patterns.md

<!-- load-when: debugging -->
@.claude/debug/guide.md
```

## 효과

### Before
- 초기 로드: 3000+ 토큰
- 불필요한 정보 포함
- 매 세션마다 전체 로드

### After  
- 초기 로드: 200 토큰
- 필요한 것만 로드
- 작업별 최적화

### 토큰 절약
- 일반 작업: 80% 절약
- 특수 작업: 50% 절약
- 평균: 65% 절약

## 마이그레이션 계획

1. 새로운 디렉토리 구조 생성
2. 기존 내용을 모듈로 분할
3. 참조 관계 재정립
4. CLAUDE.md 최소화
5. 테스트 및 검증