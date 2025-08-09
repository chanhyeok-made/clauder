---
doc_id: 763
---

# {{PROJECT_NAME}}

> TIP: 이 문서는 Lazy Loading 방식으로 구성되어 있습니다.
> 필요한 정보만 필요할 때 참조하세요.

## CRITICAL: 필수 확인

### 즉시 필요
- **작업 방식**: @.workflow/core/README.md
- **긴급 사항**: @.claude/alerts/urgent.md

### 원칙 (필요시)
- **기반 원칙**: @.principles/base/README.md
- **프로젝트 원칙**: @.claude/custom/principles.md

## CHECKLIST: 프로젝트 정보

### 개요
- **이름**: {{PROJECT_NAME}}
- **설명**: {{PROJECT_DESCRIPTION}}
- **상세**: @.claude/project/overview.md

### 기술 정보
- **스택**: @.claude/project/tech-stack.md
- **구조**: @.claude/project/architecture.md
- **설정**: @.claude/project/setup.md

## TOOLS: 작업별 가이드

### 개발
- **{{PRIMARY_LANGUAGE}} 가이드**: @.claude/guides/{{PRIMARY_LANGUAGE_LOWER}}.md
- **API 작업**: @.claude/guides/api.md
- **테스트**: @.claude/guides/testing.md

### 문서화
- **문서 작성**: @.claude/guides/documentation.md
- **API 문서**: @.claude/guides/api-docs.md

### 운영
- **배포**: @.claude/guides/deployment.md
- **모니터링**: @.claude/guides/monitoring.md

## CONFIG: 도구

- **개발 도구**: @.tools/dev-tools.md
- **Git 작업**: @.tools/git.md
- **스크립트**: @.tools/scripts.md

## 📚 추가 정보

### 프로젝트별 가이드
{{#each CUSTOM_CONTEXTS}}
- **{{name}}**: @.claude/custom/contexts/{{file}}
{{/each}}

---

QUICK: **빠른 시작**: 작업 유형을 확인하고 해당 가이드만 참조하세요.