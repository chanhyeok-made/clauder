---
doc_id: 752
---

# 원칙 6: Lazy Loading (지연 로딩)

## 핵심 개념
필요한 정보만, 필요한 시점에, 필요한 만큼만 로드합니다.

## 왜 중요한가?

### 문제 상황
```
새 세션 시작:
- CLAUDE.md: 1500 토큰
- 원칙들: 2000 토큰  
- 가이드들: 3000 토큰
→ 총 6500 토큰을 매번 로드
→ 대부분은 사용하지 않음
```

### 해결된 상황
```
새 세션 시작:
- CLAUDE.md: 200 토큰 (참조만)

API 작업 요청시:
- workflow.md: 300 토큰
- api-guide.md: 400 토큰
→ 필요한 700 토큰만 로드
```

## 구현 방법

### 1. 계층적 참조 구조
```
Level 0 (핵심) - 200 토큰
    ↓ 필요시
Level 1 (가이드) - 300 토큰
    ↓ 특정 작업시
Level 2 (상세) - 500 토큰
    ↓ 깊은 이해 필요시
Level 3 (예시) - 변동
```

### 2. 최소 정보 원칙
```markdown
# Bad (모든 내용 포함)
## 작업 원칙
1. 분석 단계
   - 요구사항을 명확히...
   - 불명확하면...
   [500줄의 상세 설명]

# Good (참조만 포함)  
## 작업 원칙
- 워크플로우: @workflow/guide.md
- 상세 단계: @workflow/detailed.md
```

### 3. 조건부 로딩
```yaml
# 작업 유형별 로딩
task_type:
  api_development:
    - @api/patterns.md
    - @api/auth.md
  
  bug_fixing:
    - @debug/guide.md
    - @debug/patterns.md
    
  documentation:
    - @docs/style.md
    - @docs/templates.md
```

## 적용 예시

### CLAUDE.md (최소화)
```markdown
# Project Name

## 필수
- 워크플로우: @workflow.md
- 긴급사항: @urgent.md

## 참조
- 원칙: @principles/
- 가이드: @guides/
- 도구: @tools/
```

### 1차 참조 문서
```markdown
# workflow.md
## 핵심 단계
1. 분석 → @workflow/analysis.md
2. 구현 → @workflow/implement.md
3. 검증 → @workflow/verify.md
```

### 2차 참조 문서
```markdown
# workflow/analysis.md
## 요구사항 분석
- 체크리스트: @checklists/requirements.md
- 불명확시: @protocols/clarification.md
```

## 로딩 시나리오

### 시나리오 1: 간단한 수정
```
User: "오타 수정해줘"
Load: CLAUDE.md (200)
Total: 200 토큰
```

### 시나리오 2: API 개발
```
User: "새 API 엔드포인트 추가"
Load: 
- CLAUDE.md (200)
- workflow.md (300)
- api/patterns.md (400)
Total: 900 토큰
```

### 시나리오 3: 복잡한 디버깅
```
User: "이상한 버그가 있어 분석해줘"
Load:
- CLAUDE.md (200)
- workflow.md (300)
- workflow/analysis.md (500)
- debug/guide.md (600)
- debug/patterns.md (400)
Total: 2000 토큰
```

## 측정 가능한 효과

1. **초기 로드**: 6500 → 200 토큰 (97% 감소)
2. **평균 세션**: 3000 → 800 토큰 (73% 감소)
3. **응답 속도**: 2초 → 0.3초
4. **컨텍스트 여유**: 더 많은 코드 분석 가능

## 구현 가이드라인

### DO
- ✅ 각 문서는 하나의 주제만
- ✅ 300-500 토큰 목표
- ✅ 깊은 내용은 하위 참조로
- ✅ 작업별 로딩 맵 제공

### DON'T
- ❌ 한 문서에 모든 내용
- ❌ 긴 설명 직접 포함
- ❌ 순환 참조
- ❌ 3단계 이상 깊이

## 핵심 원리

> "정보는 필요할 때만 가치가 있다"

- **최소 시작**: 가장 적은 정보로 시작
- **점진적 확장**: 필요에 따라 추가 로드
- **맥락 유지**: 작업 관련 정보만 유지

---

Lazy Loading은 Claude의 효율성을 극대화하고
더 많은 실제 작업에 집중할 수 있게 합니다.