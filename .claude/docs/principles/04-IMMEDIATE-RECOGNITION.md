---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "11d1061"
  
dependencies:
  - file: "CLAUDE.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/instructions.md"
    commit: "11d1061"
    status: "current"
    
references:
  - file: ".claude/docs/principles/README.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/instructions.md"
    commit: "11d1061"
    status: "current"
---

# 원칙 4: 즉시 인지 가능

## 핵심 규칙

### Claude Code 시작 시 로드
- CLAUDE.md에서 모든 원칙 참조
- instructions.md에서 핵심 규칙 명시
- 세션 시작 시 자동 확인

### 명확한 구조
- 원칙별 번호 부여
- 시각적 구분 (이모지, 제목)
- 빠른 참조 가능

## 실천 방법

1. **CLAUDE.md 최상단**
   ```markdown
   ## 🚨 핵심 원칙
   1. @.claude/docs/principles/01-REFERENCE-STRUCTURE.md
   2. @.claude/docs/principles/02-PROJECT-INDEPENDENCE.md
   3. @.claude/docs/principles/03-DOCUMENT-MODULARITY.md
   4. @.claude/docs/principles/04-IMMEDIATE-RECOGNITION.md
   ```

2. **즉시 접근 가능**
   - 짧은 경로
   - 명확한 이름
   - 일관된 형식

## 관련 문서
- 메인 가이드: @CLAUDE.md
- Claude 지시사항: @.claude/instructions.md