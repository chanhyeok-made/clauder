---
doc_id: 1001
priority: HIGHEST
role: main_router
last_updated: 2025-01-09
---

# Clauder 마스터 라우터

## 🔴 현재 상태
```bash
cat .claude/STATE.md | head -10  # 이전 작업 확인
```

## 🗺️ 네비게이션 맵

### 작업 시작할 때
→ **워크플로우**: @.workflow/core/INDEX.md
→ **현재 단계**: @.claude/STATE.md#current_stage

### 원칙 확인할 때
→ **기반 원칙**: @.principles/base/INDEX.md
→ **개발 원칙**: @.principles/development/INDEX.md

### 도구 사용할 때
→ **도구 목록**: @.tools/INDEX.md
→ **검증 도구**: @.claude/validators/

### 학습 확인할 때
→ **학습 기록**: @.learning/INDEX.md
→ **패턴 분석**: @.learning/lessons/

## 📊 모듈 사용 통계

### 자주 사용 (매일)
- .claude/workflow/01-analysis.md
- .claude/workflow/05-commit.md
- .claude/STATE.md

### 가끔 사용 (주 1-2회)
- .base-principles/README.md
- .clauder-dev/principles/

### 거의 안 씀 (월 1회 이하)
- templates/
- modules/
- projects/

## 🎯 빠른 명령

### 상태 확인
```bash
source .claude/hooks/show-status.sh
```

### 참조 검증
```bash
.claude/validators/document-freshness.sh
```

### 학습 기록
```bash
echo "배운 것: $LESSON" >> .claude/learning/today.md
```

## ⚠️ 핵심 규칙
1. **STATE.md 항상 업데이트**
2. **작업은 워크플로우 따라**
3. **학습은 즉시 기록**

---
이 파일이 모든 것의 시작점입니다. 여기서 필요한 곳으로 이동하세요.