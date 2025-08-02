---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "11d1061"
  
dependencies:
  - file: ".claude/docs/principles/01-REFERENCE-STRUCTURE.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/docs/principles/02-PROJECT-INDEPENDENCE.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/docs/principles/03-DOCUMENT-MODULARITY.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/docs/principles/04-IMMEDIATE-RECOGNITION.md"
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
    
references:
  - file: "CLAUDE.md"
    commit: "11d1061"
    status: "current"
  - file: "CLAUDE.base.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/instructions.md"
    commit: "11d1061"
    status: "current"
---

# 📋 Clauder 핵심 원칙

모든 Clauder 문서와 시스템은 다음 7가지 핵심 원칙을 따릅니다:

## 1️⃣ 완벽한 참조 구조
@.claude/docs/principles/01-REFERENCE-STRUCTURE.md

모든 문서는 YAML front matter와 명시적 참조를 포함해야 합니다.

## 2️⃣ 프로젝트 독립성
@.claude/docs/principles/02-PROJECT-INDEPENDENCE.md

Clauder 개선이 다른 프로젝트에 영향을 주지 않도록 템플릿과 실제 파일을 분리합니다.

## 3️⃣ 문서 모듈화
@.claude/docs/principles/03-DOCUMENT-MODULARITY.md

한 문서는 한 개념만 다루며, 참조로 연결된 모듈 구조를 유지합니다.

## 4️⃣ 즉시 인지 가능
@.claude/docs/principles/04-IMMEDIATE-RECOGNITION.md

Claude Code 실행 시 모든 원칙을 즉시 인지할 수 있도록 구성합니다.

## 5️⃣ 필수 역참조
@.claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md

모든 참조는 양방향으로 관리되며, 역참조로 문서 최신 상태를 판별합니다.

## 6️⃣ 작업 단위 커밋
@.claude/docs/principles/06-WORK-UNIT-COMMITS.md

모든 작업은 작업 단위로 GitHub에 커밋하며, 커밋 전 참조 상태를 반드시 검증합니다.

## 7️⃣ 순환 참조 금지
@.claude/docs/principles/07-NO-CIRCULAR-REFERENCES.md

모든 참조와 역참조에서 순환 참조는 절대 금지되며, 계층적 구조를 유지해야 합니다.

---

이 원칙들은 Clauder의 핵심이며, 모든 작업에서 반드시 준수되어야 합니다.