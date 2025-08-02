---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "f7db06e"
  
dependencies:
  - file: ".claude/core/02-work-principles.md"
    commit: "f7db06e"
    status: "current"
  - file: ".claude/core/01-essentials.md"
    commit: "f7db06e"
    status: "current"
    
references:
  - file: "CLAUDE.md"
    commit: "f7db06e"
  - file: ".claude/templates/core/02-work-principles.template.md"
    commit: "f7db06e"
    note: "references this as child concept"
---

# 개발 원칙 & 규칙

> 이 문서는 작업 원칙의 하위 개념으로, 구체적인 개발 활동에 적용되는 원칙들을 다룹니다.
> 상위 문서: @.claude/core/02-work-principles.md

## 🎯 핵심 철학
**"증거 > 가정 | 코드 > 문서 | 효율성 > 장황함"**

- 가정보다는 증거에 기반한 결정
- 문서보다는 실제 작동하는 코드
- 장황한 설명보다는 효율적인 해결책

## 🏗 SOLID 원칙

### S - Single Responsibility Principle (단일 책임 원칙)
- 각 모듈/클래스는 하나의 책임만 가진다
- 변경의 이유가 오직 하나여야 한다

### O - Open/Closed Principle (개방-폐쇄 원칙)
- 확장에는 열려있고, 수정에는 닫혀있어야 한다
- 새 기능은 기존 코드 수정 없이 추가 가능해야 한다

### L - Liskov Substitution Principle (리스코프 치환 원칙)
- 상위 타입은 하위 타입으로 대체 가능해야 한다
- 상속 관계에서 일관성 유지

### I - Interface Segregation Principle (인터페이스 분리 원칙)
- 불필요한 인터페이스 의존성 강요 금지
- 작고 구체적인 인터페이스 선호

### D - Dependency Inversion Principle (의존성 역전 원칙)
- 구체적 구현이 아닌 추상화에 의존
- 고수준 모듈이 저수준 모듈에 의존하지 않음

## 📐 핵심 설계 원칙

### DRY (Don't Repeat Yourself)
- 중복 제거를 통한 유지보수성 향상
- 공통 기능은 추상화하여 재사용

### KISS (Keep It Simple, Stupid)
- 단순함을 최우선으로
- 복잡한 해결책보다 간단한 해결책 선호

### YAGNI (You Aren't Gonna Need It)
- 현재 필요한 것만 구현
- 미래의 요구사항을 위한 과도한 설계 지양

### 추가 설계 원칙
- **합성 > 상속**: 상속보다 합성을 통한 기능 확장
- **관심사의 분리**: 각 모듈은 독립적인 관심사 처리
- **느슨한 결합**: 컴포넌트 간 의존성 최소화
- **높은 응집도**: 관련 기능은 하나의 모듈에

## 💻 코딩 표준

### 네이밍 규칙
- **명확성**: 의도가 분명한 이름 사용
- **일관성**: 프로젝트 전체에서 동일한 규칙 적용
- **검색 가능**: grep/search에 친화적인 이름

### 함수 설계
- 하나의 함수는 하나의 일만
- 부작용(side effect) 최소화
- 예측 가능한 입출력

### 에러 처리
- 조기 반환(early return) 패턴 활용
- 명시적 에러 처리
- 의미 있는 에러 메시지

## 🔍 코드 품질 기준

### 가독성
- 코드는 한 번 작성되고 여러 번 읽힌다
- 주석보다는 자기 설명적 코드
- 복잡한 로직은 단계별로 분해

### 테스트 가능성
- 테스트하기 쉬운 구조로 설계
- 의존성 주입 활용
- 순수 함수 선호

### 성능
- 조기 최적화는 금물
- 측정 후 최적화
- 알고리즘 복잡도 고려

## 🛡 보안 원칙
- **최소 권한 원칙**: 필요한 최소한의 권한만 부여
- **입력 검증**: 모든 외부 입력은 검증 필수
- **방어적 프로그래밍**: 예상치 못한 상황 대비
- **보안 기본값**: 안전한 기본 설정 사용

## 📊 개발 접근법

### 증거 기반 개발
- 추측이 아닌 측정
- 로깅과 모니터링 우선
- 데이터 기반 의사결정

### 점진적 개선
- 큰 변경보다 작은 개선의 연속
- 지속적인 리팩토링
- 기술 부채 관리

### 실용적 접근
- 완벽보다는 실용성
- 이론보다는 실제 작동
- 과도한 추상화 경계

## 🔗 관련 문서
- 작업 원칙: @.claude/core/02-work-principles.md (상위 개념)
- 프로젝트 정보: @.claude/core/01-essentials.md
- 코딩 표준 상세: [언어별 가이드 참조]