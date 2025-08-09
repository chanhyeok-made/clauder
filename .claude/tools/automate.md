---
doc_id: 4002
---

# 자동화 명령

## 자동 실행 트리거

### 파일 변경 시
```execute
# 참조 자동 업데이트
on_file_change() {
  validate.sh
  fix_broken_references()
}
```

### 에러 발생 시
```execute
# 에러 자동 기록
on_error() {
  record_to_errors.md
  search_similar_pattern
  apply_known_solution
}
```

### 작업 완료 시
```execute
# 자동 커밋
on_task_complete() {
  update_state
  git add .
  git commit -m "auto: task completed"
  git push
}
```

## 반복 작업 자동화

### 일일 체크
```execute
# 매일 실행
daily_check() {
  validate.sh
  check_stale_docs
  cleanup_completed_todos
}
```

### 패턴 추출
```execute
# 자동 패턴 인식
extract_patterns() {
  analyze_recent_commits
  identify_common_patterns
  update_patterns.md
}
```

## 스마트 제안

### 다음 작업 제안
```execute
suggest_next() {
  check_current_stage
  check_pending_todos
  suggest_most_relevant
}
```