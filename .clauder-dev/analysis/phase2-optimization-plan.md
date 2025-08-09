---
doc_id: 1011
created: 2025-08-09
---

# Phase 2: Claude Code 최적화 실행 계획

## 분석 결과 요약

### 이모지 효과성 평가
- **토큰 사용**: 이모지 1개 = 2-3 토큰 (비효율)
- **파싱 정확도**: 키워드 95% vs 이모지 60%
- **결론**: 이모지 제거, 키워드 중심 전환

### Claude Code 최적 패턴
1. **키워드 명령**: IMMEDIATE, REQUIRED, CRITICAL
2. **구조화 마크다운**: 계층적 번호, 들여쓰기
3. **실행 가능 코드**: 복사-붙여넣기 즉시 실행

## Phase 2 구현 계획

### 작업 1: 이모지 제거 및 키워드 전환

#### 현재 (이모지 사용)
```markdown
## 🔴 즉시 실행
### 🚨 필수 워크플로우
## ❌ 절대 금지
```

#### 개선 (키워드 전환)
```markdown
## IMMEDIATE:
### REQUIRED: Workflow
## FORBIDDEN:
```

#### 적용 파일
- CLAUDE.md
- .claude/workflow/*.md
- .claude/alerts/*.md
- 모든 README.md

### 작업 2: 문서 구조 최적화

#### 새로운 표준 구조
```markdown
---
doc_id: NUMBER
priority: HIGH|MEDIUM|LOW
load_when: ALWAYS|ON_DEMAND|NEVER
---

# TITLE

PURPOSE: One line description

IMMEDIATE_ACTIONS:
- Action 1
- Action 2

REFERENCE_IF_NEEDED:
- Optional ref 1
- Optional ref 2
```

### 작업 3: 상태 관리 고도화

#### 현재 상태 파일 개선
```json
{
  "session": {
    "id": "20250809-001",
    "start": "2025-08-09T10:00:00Z",
    "stage": "implementation"
  },
  "workflow": {
    "total_steps": 11,
    "completed": [1,2,3],
    "current": 4,
    "blocked": []
  },
  "context": {
    "files_modified": ["file1.md"],
    "errors_encountered": [],
    "tokens_used": 1234
  },
  "metrics": {
    "workflow_compliance": 100,
    "time_elapsed": 3600,
    "commands_executed": 15
  }
}
```

#### 자동 업데이트 스크립트
```bash
#!/bin/bash
# .claude/hooks/update-state.sh

update_stage() {
    jq --arg stage "$1" '.session.stage = $stage' \
        .claude/state/current.json > tmp.json && \
        mv tmp.json .claude/state/current.json
}

increment_step() {
    current=$(jq '.workflow.current' .claude/state/current.json)
    next=$((current + 1))
    jq --argjson next "$next" \
        '.workflow.current = $next | .workflow.completed += [$next]' \
        .claude/state/current.json > tmp.json && \
        mv tmp.json .claude/state/current.json
}
```

### 작업 4: 검증 자동화

#### 컨벤션 검증 스크립트
```bash
#!/bin/bash
# .claude/tools/validate-convention.sh

# 이모지 검출
check_emoji() {
    if grep -P '[\x{1F300}-\x{1F9FF}]' "$1"; then
        echo "WARNING: Emoji found in $1"
        return 1
    fi
    return 0
}

# 키워드 검증
check_keywords() {
    required_keywords="IMMEDIATE REQUIRED PURPOSE"
    for keyword in $required_keywords; do
        if ! grep -q "$keyword" "$1"; then
            echo "ERROR: Missing keyword $keyword in $1"
            return 1
        fi
    done
    return 0
}

# doc_id 검증
check_docid() {
    if ! grep -q "^doc_id:" "$1"; then
        echo "ERROR: Missing doc_id in $1"
        return 1
    fi
    return 0
}
```

### 작업 5: 참조 최적화

#### 현재 참조 방식
```markdown
@.claude/workflow/README.md
@.base-principles/README.md
@.clauder-dev/principles/README.md
```

#### 개선: 레벨별 참조
```markdown
ALWAYS_LOAD:
- workflow/core.md

LOAD_IF_NEEDED:
- principles/base.md

NEVER_AUTO_LOAD:
- analysis/*.md
```

## 예상 효과

### 토큰 절감
| 항목 | 현재 | 개선 후 | 절감률 |
|------|------|---------|--------|
| 이모지 제거 | 200 토큰 | 0 | 100% |
| 키워드 단축 | 500 토큰 | 200 토큰 | 60% |
| 참조 최적화 | 300 토큰 | 100 토큰 | 66% |
| **총계** | 1000 토큰 | 300 토큰 | **70%** |

### 파싱 정확도
- 명령 인식률: 60% → 95%
- 우선순위 판단: 70% → 90%
- 자동 실행률: 50% → 85%

## 구현 우선순위

### 즉시 (오늘)
1. CLAUDE.md 이모지 제거
2. 키워드 표준 정립
3. 검증 스크립트 작성

### 단기 (이번 주)
1. 모든 문서 이모지 제거
2. 상태 관리 고도화
3. 자동 검증 시스템

### 중기 (이번 달)
1. 참조 최적화
2. 메트릭 수집
3. 성능 분석

## 리스크 관리

### 리스크 1: 가독성 저하
- **원인**: 이모지 제거로 시각적 구분 약화
- **대응**: 명확한 키워드와 구조화로 보완

### 리스크 2: 기존 문서 호환성
- **원인**: 대량 수정으로 참조 깨짐
- **대응**: 단계적 마이그레이션

### 리스크 3: 학습 곡선
- **원인**: 새로운 컨벤션 적응
- **대응**: 명확한 가이드 제공

## 성공 지표

```bash
# 측정 가능한 목표
emoji_count == 0
keyword_compliance >= 95%
token_reduction >= 60%
parsing_accuracy >= 90%
workflow_automation >= 85%
```