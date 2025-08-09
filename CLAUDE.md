---
priority: CRITICAL
auto_execute: true
---

# Clauder 실행 시스템

## AUTO_LOAD: 시작 시 즉시 실행
```
1. Read .claude/state/current.md
2. Check workflow stage
3. Load learning patterns
4. Create TODOs if needed
```

## WORKFLOW: 5단계 강제 실행
현재 단계: @.claude/workflow/current.md

### 실행 명령
```
1. 분석: @.claude/workflow/execute.md#analyze
2. 구현: @.claude/workflow/execute.md#implement  
3. 검토: @.claude/workflow/execute.md#review
4. 문서화: @.claude/workflow/execute.md#document
5. 커밋: @.claude/workflow/execute.md#commit
```

## LEARNING: 패턴 자동 적용
```
에러 발생 시: @.claude/learning/errors.md#search
패턴 검색: @.claude/learning/patterns.md#find
해결책 적용: @.claude/learning/apply.md#execute
```

## VALIDATION: 검증 도구
```
참조 체크: @.claude/tools/validate.sh
상태 확인: @.claude/state/current.md
TODO 관리: @.claude/tools/todo.md
```

## PRINCIPLES: 핵심 원칙
@.base-principles/README.md

## NEVER_FORGET
1. 모든 작업은 워크플로우 준수
2. 발견한 패턴 즉시 기록
3. 작업 완료 즉시 커밋
4. 실행 가능한 코드만 작성