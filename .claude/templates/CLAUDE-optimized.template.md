---
v: {{CREATED}}|{{UPDATED}}|{{COMMIT}}
---

# {{PROJECT_NAME}}

{{PROJECT_DESC}}

## 필수
@[$essentials]

<!-- if:exists custom/overrides/work-principles.md -->
@[$custom/overrides/work-principles]
<!-- else -->
@[$work-principles]
<!-- endif -->

<!-- if:exists custom/overrides/dev-principles.md -->
@[$custom/overrides/dev-principles]
<!-- else -->
@[$dev-principles]
<!-- endif -->

## 명령어
- `/clauder start` - 시작
- `/clauder daily` - 일일 체크
- `/clauder track` - 버전 관리
- [전체 목록](@[$commands/])

## 기술
{{TECH_STACK}}

<!-- if:exists custom/contexts/ -->
## 가이드
@[$custom/contexts/]
<!-- endif -->

---
자세한 정보: @[$readme]