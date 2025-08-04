---
doc_id: 500
---

# Claude 필수 지시사항

> 💡 이 문서는 Lazy Loading 방식으로 최적화되었습니다.
> 필요한 규칙만 필요할 때 참조하세요.

## 🔴 즉시 필요 (항상 확인)

### 워크플로우 
- **5단계 체계**: @.clauder-dev/principles/09-SYSTEMATIC-WORKFLOW.md
- **상태 표시**: `🔍 현재 단계: [분석/작업/회고/문서화/커밋]`

### 핵심 규칙
- **작업 단위 커밋**: 완료 즉시 GitHub에 저장 (@.clauder-dev/principles/06-WORK-UNIT-COMMITS.md)
- **doc_id 필수**: 모든 .md 파일에 doc_id 포함
- **실제 commit hash**: `git log -1 --format="%h"` 사용

## 📋 작업별 지시사항

### 문서 작업
- **편집 시**: @.claude/instructions/editing-documents.md
- **생성 시**: @.claude/instructions/creating-documents.md
- **버전 트리**: @/.clauder-dev/tools/helpers/VERSION-TREE-GUIDE.md

### Git 작업
- **커밋 전후**: @.claude/instructions/git-operations.md
- **필수 명령**: `git add . && git commit -m '[message]' && git push`

### 자동화
- **훅 동작**: @.claude/instructions/hooks-behavior.md
- **패턴 실행**: @.claude/instructions/automation-patterns.md

## 🚫 금지사항

1. doc_id 없이 .md 파일 생성/수정
2. 작업 완료 후 커밋 없이 종료
3. 버전 트리 업데이트 누락
4. 템플릿과 실제 파일 혼동

## ⚡ 빠른 참조

- 원칙 전체: @.clauder-dev/principles/README.md
- 체크리스트: @.claude/instructions/checklists.md
- 토큰 최적화: @.claude/instructions/token-optimization.md

> "모든 문서는 버전이 있고, 모든 버전은 추적된다"
