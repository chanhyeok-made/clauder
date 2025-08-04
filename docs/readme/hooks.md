---
doc_id: 815
---

# 훅 기반 자동화

## 훅 설치

```bash
# Git hooks 자동 설치
/clauder hooks install
```

## 자동화되는 작업

### 문서 편집 시
- 버전 메타데이터 자동 업데이트
- 참조 일관성 검증
- doc_id 자동 할당

### Git 커밋 시
- 모든 문서의 버전 동기화
- 버전 트리 자동 업데이트
- 참조 무결성 검증

### Claude 작업 시
- 지시사항 자동 적용
- 워크플로우 단계 표시
- 작업 완료 후 커밋 제안

## 훅 타입

### Git Hooks
- `pre-commit`: 커밋 전 검증
- `post-commit`: 커밋 후 동기화

### Claude Hooks
- `before-edit`: 편집 전 확인
- `after-edit`: 편집 후 업데이트

## 설정 파일

- Git hooks: `.git/hooks/`
- Claude 지시사항: `.claude/instructions.md`
- 훅 설계: `.claude/docs/design/HOOKS.md`

## 훅 비활성화

```bash
# 일시적 비활성화
git commit --no-verify

# 훅 제거
rm .git/hooks/pre-commit
```

## 자세한 내용

- 훅 설계: @.claude/docs/design/HOOKS.md
- 자동화 패턴: @.claude/workflow/automation/patterns.md