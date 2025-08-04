---
doc_id: 400
---

이 문서는 Claude Code가 {{PROJECT_NAME}} 프로젝트를 이해하고 지원하기 위한 가이드입니다.

> 💡 **Clauder의 핵심 가치**: 구조화된 지식과 원칙을 통해 Claude를 더 강력하게 만드는 시스템입니다.
> 자세한 내용: @docs/guides/claude-enhancement-guide.md

## 🎯 프로젝트 정보
<!-- if:exists custom/overrides/01-essentials.md -->
# 커스텀 오버라이드 파일 (선택적)
<!-- else -->
@.claude/templates/core/01-essentials.template.md
<!-- endif -->

## 🌟 작업 원칙
<!-- if:exists custom/overrides/02-work-principles.md -->
# 커스텀 오버라이드 파일 (선택적)
<!-- else -->
@.claude/templates/core/02-work-principles.template.md
<!-- endif -->

## 📐 개발 원칙
<!-- if:exists custom/overrides/03-dev-principles.md -->
# 커스텀 오버라이드 파일 (선택적)
<!-- else -->
@.claude/templates/core/03-dev-principles.template.md
<!-- endif -->

## 🔧 상황별 가이드
### 기본 가이드
@/.claude/templates/contexts/README.template.md

### 프로젝트별 가이드
<!-- for:file in custom/contexts/*.md -->
@.claude/custom/contexts/{{file}}
<!-- endfor -->

생성일: {{GENERATED_DATE}}
버전: {{TEMPLATE_VERSION}}
