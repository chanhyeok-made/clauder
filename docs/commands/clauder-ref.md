---
doc_id: 108
---

참조 시스템 관리

## 고유 기능
```
ref check [file]     # 참조 확인
ref update [file]    # 참조 업데이트  
ref list             # 모든 참조 목록
ref migrate          # 구형식 → 신형식
```

## 참조 형식
- 구: `@.claude/long/path/file.md`
- 신: `@[$alias]#commit`

## 관련 문서
- 전략: @[$ref-strategy]
- 별칭: @[$aliases]

@[$commands/common/usage-template.md]
