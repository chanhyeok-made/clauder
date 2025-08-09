---
doc_id: 803
---

# Git 작업 지시사항

## 커밋 전

```
BEFORE git commit:
- RUN: git status
- CHECK: 변경된 .md 파일 목록
- UPDATE: 각 파일의 버전 메타데이터
```

## 커밋 후

```
AFTER git commit:
- LOG: 새로운 commit 해시
- SUGGEST: 관련 문서 업데이트 필요 여부
```

## 작업 완료 시

```
WHEN 작업 완료:
- ALERT: "ALERT: 작업 단위 커밋 필요!"
- SUGGEST: "git add . && git commit -m '[message]' && git push"
- REMIND: @.base-principles/workflow/work-unit-commits.md
```

## TodoWrite 완료 시

```
IF all todos completed:
- MUST: Git commit 제안
- SHOW: 커밋 메시지 예시
- WARN: 커밋 없이 종료 금지
```

## 체크리스트

- [ ] commit 전: 문서 버전 동기화
- [ ] commit 후: 새 해시 기록
- [ ] push 후: 성공 확인