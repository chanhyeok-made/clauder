---
doc_id: 829
---

# 컨텍스트 템플릿

> 다양한 작업 컨텍스트를 위한 템플릿들입니다.

## 📁 구조

- **bug-fix-context.template.md**: 버그 수정 컨텍스트
- **feature-development.template.md**: 기능 개발 컨텍스트
- **refactoring-context.template.md**: 리팩토링 컨텍스트
- **testing-context.template.md**: 테스트 컨텍스트

## CURRENT: 주요 내용

특정 작업 유형에 맞춰 Claude Code에게 제공할 컨텍스트 템플릿입니다. 각 작업 유형별로 필요한 정보와 고려사항을 체계적으로 정리합니다.

## NOTE: 활용 예시

```markdown
# 버그 수정 시
1. bug-fix-context.template.md 복사
2. 버그 정보 입력
3. custom/contexts/에 저장
4. Claude Code 실행 시 자동 로드
```