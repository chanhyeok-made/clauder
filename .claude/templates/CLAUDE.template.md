---
doc_id: 400
---

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

생성일: {{GENERATED_DATE}}
버전: {{TEMPLATE_VERSION}}
