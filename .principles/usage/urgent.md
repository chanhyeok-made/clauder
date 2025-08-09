---
doc_id: 755
---

# ALERT: 긴급 사항

## CRITICAL: 즉시 수행

### 1. 작업 완료 시 커밋
```bash
git add .
git commit -m "type: 설명"
git push
```
**원칙**: @.principles/base/workflow/work-unit-commits.md

### 2. 새 문서 생성 시
- doc_id 추가 필수
- 버전 트리 업데이트
**가이드**: @.claude/guides/new-document.md

### 3. 파일 수정 시
- 메타데이터 업데이트
- 참조 일관성 확인
**가이드**: @.claude/guides/file-editing.md

## WARNING: 주의 사항
- 원칙 무시 금지
- 템플릿과 실제 파일 구분
- 순환 참조 금지