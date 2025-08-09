---
doc_id: 866
---

# 구조 분리 원칙 위반 사례

## 발견한 문제
`.claude/workflow/` 파일들이 `.clauder-dev/principles/`를 참조하고 있었음.

## 문제점
- `.claude/`는 사용자에게 제공되는 템플릿
- `.clauder-dev/`는 Clauder 개발 전용
- 사용자가 템플릿을 복사했을 때 참조가 깨짐

## 해결 방법
1. 사용자가 필요한 원칙들을 `.claude/principles/`로 복사
2. 모든 참조를 `.claude/principles/`로 변경
3. `.clauder-dev/principles/`는 Clauder 개발 전용으로 유지

## 교훈
프로젝트 독립성 원칙(02-PROJECT-INDEPENDENCE)을 항상 염두에 두고:
- 템플릿 영역과 개발 영역을 명확히 구분
- 교차 참조 금지
- 사용자 관점에서 구조 설계