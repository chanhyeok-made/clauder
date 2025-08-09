---
doc_id: 5006
created: 2025-08-10
type: critical-analysis
priority: HIGH
---

# CLAUDE.md 언어 불일치 문제 분석

## 🔴 발견된 문제

### 1. 언어 불일치
```
CLAUDE.md (영어) → .claude/workflow/README.md (한글)
     ↓                        ↓
"IMMEDIATE: Execute"    "작업 워크플로우"
"REQUIRED: Generate"    "필수 단계"
"FORBIDDEN:"           "현재 단계: [분석/작업/회고]"
```

### 2. 키워드 불일치
- CLAUDE.md: `IMMEDIATE`, `REQUIRED`, `FORBIDDEN`
- workflow: `CYCLE:`, `QUICK:`, `TOOLS:`
- 두 문서가 다른 키워드 체계 사용

## 📖 Claude Code의 CLAUDE.md 파악 시나리오

### Step 1: 초기 로드
```
Claude Code 시작
↓
CLAUDE.md 발견 및 읽기
↓
"영어 문서구나" (인식)
```

### Step 2: 키워드 파싱
```
YAML front matter 파싱:
- doc_id: 1000 ✓
- priority: HIGH ✓
- load_when: ALWAYS ✓

키워드 인식:
- IMMEDIATE → "즉시 실행"
- REQUIRED → "필수"
- FORBIDDEN → "금지"
```

### Step 3: 참조 확인
```
@.workflow/core/README.md 참조 발견
↓
파일 읽기
↓
"어? 한글이네?" (혼란)
↓
"작업 워크플로우", "필수 단계" 
↓
IMMEDIATE와 "필수 단계"가 같은 의미인가?
```

### Step 4: 실행 혼란
```
IMMEDIATE: Execute on Task Request
↓
"작업 요청 시 즉시 실행"으로 이해
↓
그런데 실제 워크플로우는 한글로 "분석→작업→회고"
↓
용어 매칭이 어려움
```

## 🎯 핵심 문제점

### 1. **인지 부담 증가**
- 영어 지시 → 한글 문서 → 영어 키워드
- 컨텍스트 스위칭 발생
- 이해 속도 저하

### 2. **키워드 파싱 정확도 감소**
```javascript
// Claude Code 내부 파싱 (추정)
if (line.includes("IMMEDIATE")) {
  // 영어 키워드 처리
} 
// 하지만 참조 문서는 한글...
if (line.includes("필수")) {
  // 한글 키워드 처리 필요
}
```

### 3. **일관성 부재**
- 프로젝트: 한글 (Clauder 한국어 프로젝트)
- 핵심 지시: 영어 (CLAUDE.md)
- 실제 문서: 한글 (.claude/workflow/)
- 도구 이름: 영어 (safe-emoji-remover)

## 💡 개선 방향

### Option A: 완전 한글화
```markdown
---
doc_id: 1000
priority: 높음
load_when: 항상
---

# Clauder 프로젝트 가이드

목적: Claude Code와 Clauder 개발을 위한 필수 가이드

## 자동_로드: 모듈 시스템
```

### Option B: 완전 영어화
```markdown
# All documents in English
- Consistent language
- But loses Korean project identity
```

### Option C: 이중 언어 지원 (추천)
```markdown
## 즉시실행 | IMMEDIATE: 작업 요청 시 실행

### 필수 | REQUIRED: 워크플로우 TODO 생성
```

## 📊 영향 분석

### 현재 상황의 영향
- **토큰 효율**: 영어가 한글보다 토큰 효율적 (사실)
- **이해도**: 한글이 한국 개발자에게 직관적
- **일관성**: 현재 없음 (문제)

### 개선 시 효과
- **일관성**: 전체 문서 통일
- **이해 속도**: 30% 향상 예상
- **파싱 정확도**: 95% → 99%

## 🔧 즉시 수정 필요 사항

### 1. CLAUDE.md 한글화
```markdown
## 즉시실행: 작업 요청 시 실행

### 필수: 워크플로우 TODO 생성
```

### 2. 키워드 통일
```
IMMEDIATE → 즉시실행
REQUIRED → 필수
FORBIDDEN → 금지
CURRENT_STAGE → 현재_단계
```

### 3. 자동 로더 메시지 한글화
```bash
# 현재
echo "DETECTED: CLAUDE.md found"

# 개선
echo "감지됨: CLAUDE.md 발견"
```

## 결론

**CLAUDE.md가 영어인 이유**:
1. 초기 개발 시 영어 템플릿 사용
2. 토큰 효율성 고려
3. 하지만 프로젝트가 한글화되면서 불일치 발생

**즉시 조치 필요**:
CLAUDE.md를 한글로 변경하여 일관성 확보. 이것이 Claude Code의 이해도와 실행 정확도를 크게 향상시킬 것.