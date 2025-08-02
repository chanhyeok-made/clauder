---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "f7db06e"
  
dependencies:
  - file: ".claude/templates/core/01-essentials.template.md"
    commit: "f7db06e"
    status: "current"
  - file: ".claude/templates/core/02-work-principles.template.md"
    commit: "f7db06e"
    status: "current"
  - file: ".claude/templates/core/03-dev-principles.template.md"
    commit: "f7db06e"
    status: "current"
  - file: ".claude/templates/contexts/README.md"
    commit: "f7db06e"
    status: "current"
---

# {{PROJECT_NAME}} - Claude Code 가이드

이 문서는 Claude Code가 {{PROJECT_NAME}} 프로젝트를 이해하고 지원하기 위한 가이드입니다.

## 🎯 프로젝트 정보
<!-- if:exists custom/overrides/01-essentials.md -->
@.claude/custom/overrides/01-essentials.md
<!-- else -->
@.claude/templates/core/01-essentials.template.md
<!-- endif -->

## 🌟 작업 원칙
<!-- if:exists custom/overrides/02-work-principles.md -->
@.claude/custom/overrides/02-work-principles.md
<!-- else -->
@.claude/templates/core/02-work-principles.template.md
<!-- endif -->

## 📐 개발 원칙
<!-- if:exists custom/overrides/03-dev-principles.md -->
@.claude/custom/overrides/03-dev-principles.md
<!-- else -->
@.claude/templates/core/03-dev-principles.template.md
<!-- endif -->

## 🔧 상황별 가이드
### 기본 가이드
@.claude/templates/contexts/README.md

### 프로젝트별 가이드
<!-- for:file in custom/contexts/*.md -->
@.claude/custom/contexts/{{file}}
<!-- endfor -->

---

## 📌 프로젝트별 추가 정보
<!-- if:exists custom/additional.md -->
@.claude/custom/additional.md
<!-- endif -->

## 🎨 커스터마이징
이 프로젝트는 다음과 같이 커스터마이징되었습니다:
- 커스텀 파일: `.claude/custom/` 디렉토리 확인
- 오버라이드: `.claude/custom/overrides/` 디렉토리 확인

---
생성일: {{GENERATED_DATE}}
버전: {{TEMPLATE_VERSION}}