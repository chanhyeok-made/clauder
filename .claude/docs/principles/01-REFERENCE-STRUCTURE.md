---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "4b2ca7b"
  
dependencies:
  - file: ".claude/aliases.yaml"
    commit: "11d1061"
  - file: ".claude/references.yaml"
    commit: "11d1061"
    
references:
  - file: ".claude/docs/principles/README.md"
    commit: "11d1061"
  - file: ".claude/docs/principles/03-DOCUMENT-MODULARITY.md"
    commit: "11d1061"
  - file: ".claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md"
    commit: "11d1061"
  - file: ".claude/docs/principles/06-WORK-UNIT-COMMITS.md"
    commit: "11d1061"
  - file: ".claude/instructions.md"
    commit: "11d1061"
---

# 원칙 1: 완벽한 참조 구조

## 핵심 규칙

### 모든 문서는 YAML Front Matter 포함
```yaml
---
version:
  created: "YYYY-MM-DD"
  updated: "YYYY-MM-DD"
  commit: "hash"
  
dependencies:
  - file: "path/to/file.md"
    commit: "hash"
    
references:
  - file: "path/to/related/file.md"
    commit: "hash"
---
```

### References 섹션 필수 사항
- **모든 문서**에 `references` 섹션을 포함해야 함
- 빈 배열이라도 명시적으로 표시: `references: []`
- 관련 문서와의 연결 관계를 명확히 표현
- 양방향 참조 구조를 통한 문서 네트워크 형성

### 참조 형식
- **직접 참조**: `@path/to/file.md`
- **별칭 참조**: `@[$alias]`
- **버전 포함**: `@path/to/file.md#commit`

## 순환 참조 금지

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
# A.md → B.md → C.md → A.md  # ❌ 간접 순환!
```

#### 자기 참조 (금지)
```yaml
# A.md
dependencies:
  - file: "A.md"  # ❌ 자기 자신 참조!
```

### 올바른 계층 구조
- 상위 문서 → 하위 문서의 단방향 흐름 유지
- 양방향 관계는 dependencies/references 구분으로 해결
- 공통 의존성은 별도 문서로 분리

## 실천 방법

1. **문서 생성 시**: 반드시 front matter 포함
2. **문서 수정 시**: updated 날짜와 commit 업데이트
3. **참조 추가 시**: dependencies에 명시하고 순환 확인
4. **검증**: 참조 체인이 자기 자신으로 돌아오지 않는지 확인

## 관련 문서
- 별칭 정의: @.claude/aliases.yaml
- 참조 레지스트리: @.claude/references.yaml
- 설계 문서: @.claude/docs/design/REFERENCE_STRATEGY.md