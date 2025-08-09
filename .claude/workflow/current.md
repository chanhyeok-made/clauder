---
doc_id: 2002
auto_update: true
---

# 현재 워크플로우 상태

## CURRENT_STAGE
```
NONE
```

## STAGE_HISTORY
```
# 형식: [TIMESTAMP] STAGE -> NEXT_STAGE
```

## ACTIVE_TASK
```
NONE
```

## TODO_STATUS
```
PENDING: 0
IN_PROGRESS: 0
COMPLETED: 0
```

## 상태 업데이트 방법
```
# 다음 단계로 이동
CURRENT_STAGE="ANALYSIS"

# TODO와 연동
TodoWrite 호출 시 자동 업데이트
```