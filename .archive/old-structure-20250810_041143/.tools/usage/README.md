---
doc_id: 826
---

# Git 훅

> Git 워크플로우 자동화를 위한 훅 스크립트들입니다.

## 📁 구조

- **pre-commit**: 커밋 전 검증
- **commit-msg**: 커밋 메시지 검증
- **pre-push**: 푸시 전 최종 확인

## CURRENT: 주요 기능

### Pre-commit
- 문서 참조 일관성 검증
- doc_id 존재 여부 확인
- 버전 트리 업데이트 확인

### Commit-msg
- 커밋 메시지 형식 검증
- 타입 프리픽스 확인 (feat:, fix:, docs: 등)

### Pre-push
- 모든 테스트 통과 확인
- 문서 완성도 검증

## START: 활성화

```bash
# Git 훅 디렉토리로 복사
cp .claude/hooks/git/* .git/hooks/
chmod +x .git/hooks/*
```