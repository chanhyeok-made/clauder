---
doc_id: 759
---

# 워크플로우 자동화 지침

## 🚨 작업 시작 시 필수 TODO 생성

모든 작업 요청을 받으면 **즉시** TodoWrite 도구로 5단계 등록:

```
1. 📊 분석: [작업 내용] 분석 → @.claude/workflow/01-analysis.md
2. 🛠️ 구현: [작업 내용] 구현 → @.claude/workflow/02-implementation.md
3. 🤔 회고: 발견사항 정리 → @.claude/workflow/03-retrospective.md
4. 📝 문서화: 변경사항 문서화 → @.claude/workflow/04-documentation.md
5. 💾 커밋: 검증 후 커밋 → @.claude/workflow/05-commit.md
```

## 📋 작업 크기별 접근

- **소형** (30분 이내): 5단계 간소화 가능, TODO는 필수
- **중형** (2시간 이내): @.claude/workflow/planning-medium.md
- **대형** (2시간 이상): @.claude/workflow/planning-large.md

## ⚠️ 금지사항

1. 워크플로우 단계 건너뛰기 금지
2. TODO 없이 작업 진행 금지
3. 상태 표시 없이 단계 전환 금지