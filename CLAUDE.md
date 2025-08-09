---
doc_id: 1000
priority: HIGH
load_when: ALWAYS
---

# Clauder 프로젝트 가이드

PURPOSE: Claude Code와 함께하는 Clauder 개발 필수 가이드

## AUTO_LOAD: 모듈 및 학습 시스템
```bash
# 사용 가능한 모듈 자동 로드
source .claude/hooks/auto-module-loader.sh 2>/dev/null || true
# Clauder 자체 학습 시스템 활성화
source .claude/hooks/learning-hook.sh 2>/dev/null || true
```

## NEVER_FORGET: Clauder 핵심 목표
@.principles/base/CORE-PURPOSE.md
- **토큰 효율성**: 최소 토큰으로 최대 정보 전달
- **체계적 작업**: 모든 작업 워크플로우 준수
- **지속적 학습**: 패턴 기록 및 재사용
- **작업 완전성**: 시작한 작업 반드시 완료
- **문서 최신성**: 모든 문서 30일 이내 갱신
- **타 프로젝트 적용**: ./INIT.sh로 어디든 적용 가능

## IMMEDIATE: 작업 요청 시 즉시 실행

### REQUIRED: 워크플로우 단계별 실행
```
현재 워크플로우 단계를 확인하고 해당 단계의 TODO 생성:

1. 현재 단계 확인: workflow_status 또는 get_current_stage
2. 단계별 TODO 생성:
   - analysis: 요구사항 명확화, 접근법 결정, TODO 생성
   - implementation: 코드 작성, 파일 수정, 로직 구현
   - review: 테스트 실행, 검증, 컴플라이언스 체크
   - documentation: 문서 업데이트, 학습 기록
   - commit: 변경사항 검토, 커밋 메시지, 푸시
3. 단계 완료 후: advance_stage로 다음 단계 진행
```

### REQUIRED: 상태 표시
```
CURRENT_STAGE: [analysis/implementation/retrospective/documentation/commit]
```

## LEARNING: 자동 학습 시스템
```bash
# 에러 해결 시 자동 학습
track_claude_action "error_fixed" "TypeError" "null check 추가" "src/auth.js"

# 작업 완료 시 패턴 저장
track_claude_action "task_completed" "인증 구현" "JWT 사용"

# 유사 패턴 검색
find_similar_pattern "TypeError"
```

## REFERENCE_IF_NEEDED: 필요시 참조
- 워크플로우 상세: @.workflow/core/README.md
- 원칙: @.principles/base/README.md | @.principles/development/README.md
- 개발 가이드: @.learning/development/
- 학습 시스템: @.learning/

## FORBIDDEN: 금지사항
- 워크플로우 없이 작업 시작
- 분석 없이 구현
- 회고 없이 커밋