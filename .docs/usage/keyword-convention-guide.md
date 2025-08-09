---
doc_id: 3004
created: 2025-08-10
type: convention
version: 2.0
---

# Clauder 키워드 컨벤션 가이드

## 목적
Claude Code의 토큰 효율성과 파싱 정확도를 최대화하는 문서 작성 표준

## 핵심 원칙

### 1. 키워드 우선
- **REQUIRED**: 이모지 대신 키워드 사용
- **FORBIDDEN**: 장식적 이모지 사용
- **REASON**: 95% vs 60% 파싱 정확도

### 2. 토큰 최적화
- **REQUIRED**: 간결하고 명확한 표현
- **FORBIDDEN**: 중복되거나 장황한 설명
- **REASON**: 25% 토큰 절감

## 표준 키워드 매핑

### 우선순위 표시
```
CRITICAL:     # 최우선 (이전 🔴)
IMPORTANT:    # 중요 (이전 🟡)
NORMAL:       # 일반 (이전 🟢)
NOTE:         # 참고 (이전 📌)
```

### 상태 표시
```
CURRENT:      # 현재 상태 (이전 🔍)
DONE:         # 완료 (이전 ✅)
FORBIDDEN:    # 금지 (이전 ❌)
WARNING:      # 경고 (이전 ⚠️)
ALERT:        # 알림 (이전 🚨)
```

### 작업 표시
```
REQUIRED:     # 필수 작업
CHECKLIST:    # 체크리스트 (이전 📋)
TODO:         # 할 일
DOCUMENT:     # 문서화 (이전 📝)
```

### 구조 표시
```
TARGET:       # 목표 (이전 🎯)
BUILD:        # 구축 (이전 🏗️)
TOOLS:        # 도구 (이전 🛠️)
CYCLE:        # 사이클 (이전 🔄)
```

### 기타
```
TIP:          # 팁 (이전 💡)
QUICK:        # 빠른 참조 (이전 ⚡)
START:        # 시작 (이전 🚀)
STATS:        # 통계 (이전 📊)
```

## 문서 구조 표준

### 필수 헤더
```markdown
---
doc_id: {number}      # REQUIRED
created: {YYYY-MM-DD} # REQUIRED
type: {type}          # OPTIONAL
version: {x.y.z}      # OPTIONAL
---
```

### 제목 계층
```markdown
# 주제 (문서당 1개)
## 섹션
### 하위 섹션
#### 세부 사항
```

### 강조 표현
```markdown
**CRITICAL**: 긴급 사항
**IMPORTANT**: 중요 내용
**NOTE**: 참고 사항
```

## 파일명 규칙

### 표준 형식
```
{type}-{topic}-{YYYYMMDD}.md     # 분석/학습 문서
{name}.template.md                # 템플릿
{topic}.md                        # 일반 문서
```

### 금지 사항
- FORBIDDEN: 대문자 (README.md 제외)
- FORBIDDEN: 공백 (하이픈 사용)
- FORBIDDEN: 특수문자

## 참조 규칙

### 내부 참조
```markdown
@.workflow/core/README.md       # 절대 경로
@{doc_id}                         # doc_id 참조
```

### 외부 참조
```markdown
https://example.com               # 전체 URL
[텍스트](URL)                     # 링크 텍스트
```

## 코드 블록 규칙

### 언어 명시
```bash
# Bash 스크립트
echo "example"
```

### 구조 표시
```yaml
key: value                        # YAML
```

## 체크리스트

문서 작성 완료 시 확인:
- [ ] doc_id 포함
- [ ] 키워드만 사용 (이모지 없음)
- [ ] 한 문서 한 주제
- [ ] 명확한 제목 계층
- [ ] 올바른 참조 형식

## 검증 도구

### 자동 검증
```bash
./.claude/tools/validate-convention.sh {file}
```

### 이모지 제거
```bash
./.claude/tools/safe-emoji-remover.sh {file|directory}
```

## 적용 예시

### BEFORE (비효율적)
```markdown
🔴 **긴급!** 이것은 매우 중요한 내용입니다!!!
⚠️ 주의하세요! 이 부분을 꼭 읽어보세요!
```

### AFTER (효율적)
```markdown
CRITICAL: 중요 내용
WARNING: 주의 필요
```

## 효과 측정

- **토큰 절감**: 25%
- **파싱 정확도**: 95%
- **일관성**: 100%

## 참고 문서

- 전체 컨벤션: @.claude/conventions/documentation.md
- 원칙: @.principles/base/README.md
- 워크플로우: @.workflow/core/README.md

---

이 가이드를 따르면 Claude Code와 최적의 효율로 협업할 수 있습니다.