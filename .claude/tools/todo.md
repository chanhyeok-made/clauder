---
doc_id: 4001
---

# TODO 관리 시스템

## 자동 TODO 생성

### 워크플로우별 TODO
```execute
# 분석 단계
TodoWrite([
  {"content": "요구사항 정의", "status": "pending"},
  {"content": "영향 범위 파악", "status": "pending"},
  {"content": "리스크 평가", "status": "pending"}
])

# 구현 단계
TodoWrite([
  {"content": "코드 작성", "status": "pending"},
  {"content": "테스트 작성", "status": "pending"},
  {"content": "통합 테스트", "status": "pending"}
])
```

### 에러 발생 시 TODO
```execute
# 에러 해결 TODO
TodoWrite([
  {"content": "에러 원인 분석", "status": "pending"},
  {"content": "해결책 적용", "status": "pending"},
  {"content": "결과 검증", "status": "pending"},
  {"content": "패턴 기록", "status": "pending"}
])
```

## TODO 관리 규칙

1. **즉시 생성**: 작업 시작 시 TODO 먼저
2. **단계별 업데이트**: pending → in_progress → completed
3. **하나씩 진행**: in_progress는 1개만
4. **완료 확인**: completed 후 다음 작업

## TODO 상태 추적
```execute
# 현재 TODO 상태 확인
@.claude/workflow/current.md#TODO_STATUS

# TODO 개수 확인
PENDING_COUNT=$(todo_count "pending")
IN_PROGRESS_COUNT=$(todo_count "in_progress")
COMPLETED_COUNT=$(todo_count "completed")
```