---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "11d1061"
  
dependencies:
  - file: ".claude/aliases.yaml"
    commit: "11d1061"
    status: "current"
  - file: ".claude/references.yaml"
    commit: "11d1061"
    status: "current"
    
references:
  - file: ".claude/docs/principles/README.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/docs/principles/03-DOCUMENT-MODULARITY.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/docs/principles/06-WORK-UNIT-COMMITS.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/docs/principles/07-NO-CIRCULAR-REFERENCES.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/instructions.md"
    commit: "11d1061"
    status: "current"
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
    status: "current"
    
references:
  - file: "path/to/related/file.md"
    commit: "hash"
    status: "current"
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

## 실천 방법

1. **문서 생성 시**: 반드시 front matter 포함
2. **문서 수정 시**: updated 날짜와 commit 업데이트
3. **참조 추가 시**: dependencies에 명시

## 관련 문서
- 별칭 정의: @.claude/aliases.yaml
- 참조 레지스트리: @.claude/references.yaml
- 설계 문서: @.claude/docs/design/REFERENCE_STRATEGY.md