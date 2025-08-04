---
doc_id: 756
---

# Claude Code 자동 행동 지침

> 이 문서는 Claude Code가 작업 시 **반드시 자동으로** 수행해야 하는 최소한의 행동을 정의합니다.

## 🚨 필수 자동 행동

### 1. 워크플로우 TODO 생성
작업 요청 시 → @.claude/workflow/automation/

### 2. 상태 표시
```
🔍 현재 단계: [분석/구현/회고/문서화/커밋]
```

## 📋 작업별 지침
- **문서 작업**: @.claude/guides/documentation/
- **Git 작업**: @.claude/guides/git/
- **시스템 훅**: @.claude/guides/system/
- **체크리스트**: @.claude/workflow/automation/checklists.md

## ⚠️ 핵심 원칙
- **긴급 규칙**: @.claude/alerts/urgent.md
- **기반 원칙**: @.base-principles/README.md

