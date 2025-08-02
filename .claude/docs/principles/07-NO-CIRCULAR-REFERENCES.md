---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "11d1061"
  
dependencies:
  - file: ".claude/docs/principles/01-REFERENCE-STRUCTURE.md"
    commit: "11d1061"
  - file: ".claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md"
    commit: "11d1061"
    
references:
  - file: ".claude/docs/principles/README.md"
    commit: "11d1061"
  - file: ".claude/instructions.md"
    commit: "11d1061"
---

# 원칙 7: 순환 참조 금지

## 핵심 규칙

### 절대적 순환 참조 금지
- **dependencies**에서 순환 참조 절대 금지
- **references**에서 순환 참조 절대 금지
- 직접적, 간접적 순환 모두 금지

### 순환 참조 유형

#### 직접 순환 (금지)
```yaml
# A.md
dependencies:
  - file: "B.md"

# B.md  
dependencies:
  - file: "A.md"  # ❌ 직접 순환!
```

#### 간접 순환 (금지)
```yaml
# A.md
dependencies:
  - file: "B.md"

# B.md
dependencies:
  - file: "C.md"

# C.md
dependencies:
  - file: "A.md"  # ❌ A→B→C→A 간접 순환!
```

#### 자기 참조 (금지)
```yaml
# A.md
dependencies:
  - file: "A.md"  # ❌ 자기 자신 참조!
```

## 올바른 구조

### 계층적 구조 유지
```
상위 문서 (개념적 부모)
    ↓ dependencies
하위 문서 (구체적 자식)
    ↓ references (역참조만)
상위 문서
```

### 예시: 올바른 참조 구조
```yaml
# README.md (상위)
dependencies:
  - file: "01-REFERENCE-STRUCTURE.md"
  - file: "02-PROJECT-INDEPENDENCE.md"
  
references: []  # 최상위이므로 역참조 없음

# 01-REFERENCE-STRUCTURE.md (하위)
dependencies:
  - file: "aliases.yaml"  # 더 하위 자원
  
references:
  - file: "README.md"  # 상위 문서만 역참조
```

## 검증 방법

### 수동 검증
1. **의존성 그래프 그리기**: 문서 간 관계를 시각화
2. **경로 추적**: 한 문서에서 시작해 자기 자신으로 돌아오는 경로 확인
3. **계층 확인**: 상→하 방향의 단방향 흐름 검증

### 자동화 검증
```bash
# 순환 참조 검사 명령어 (향후 구현)
/clauder validate circular

# 의존성 그래프 출력
/clauder graph dependencies

# 특정 문서의 참조 체인 확인
/clauder trace <file>
```

## 순환 참조 발견 시 해결

### 1. 구조 재설계
- 공통 의존성을 별도 문서로 분리
- 계층 구조 명확화
- 참조 방향 통일

### 2. 의존성 제거
- 불필요한 dependencies 제거
- 내용 통합으로 참조 줄이기
- 별칭 활용으로 간접 참조

### 3. 리팩터링
```yaml
# 순환 전 (잘못된 구조)
A → B → C → A

# 순환 후 (올바른 구조)
Common ← A, B, C  # 공통 의존성 분리
Index → A, B, C   # 상위 인덱스 생성
```

## 예외 상황

### References vs Dependencies 구분
```yaml
# 올바른 양방향 관계
# A.md
dependencies:
  - file: "B.md"  # A가 B에 의존

# B.md  
references:
  - file: "A.md"  # B가 A에 의해 참조됨
```
이는 순환이 아니라 올바른 양방향 관계입니다.

## 관련 문서
- 참조 구조: @.claude/docs/principles/01-REFERENCE-STRUCTURE.md
- 역참조 시스템: @.claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md