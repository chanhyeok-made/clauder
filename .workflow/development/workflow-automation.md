---
doc_id: 757
created: 2025-08-04
category: process-improvement
---

# 워크플로우 자동화 학습사항

## 🎯 배경
Claude Code가 작업 시 워크플로우 5단계(분석→구현→회고→문서화→커밋)를 일관되게 따르지 않는 문제 발견

## 💡 해결 방안

### 1. CLAUDE.md 개선
```markdown
### 🚨 작업 시작 시 필수
모든 작업 요청을 받으면 즉시:
1. TodoWrite로 워크플로우 5단계 등록
2. 상태 표시: 🔍 현재 단계: [분석]
3. 각 단계별 가이드 참조하여 진행
```

### 2. instructions.md 생성
- 위치: `.claude/instructions.md`
- 목적: Claude Code의 자동 수행 행동 정의
- 내용: 워크플로우 TODO 생성, 상태 표시, 금지사항 등

### 3. 시스템적 강제
- 작업 요청 → 즉시 5단계 TODO 등록
- 각 단계마다 상태 표시
- 단계 건너뛰기 금지

## 📊 효과
1. **일관성**: 모든 작업이 동일한 프로세스 따름
2. **추적성**: TODO로 진행 상황 명확히 파악
3. **품질**: 회고와 문서화로 지속적 개선

## 🔄 적용 예시
```
User: 새로운 기능을 추가해줘

Claude: 작업을 시작하겠습니다.

[TodoWrite 실행]
1. 📊 분석: 새 기능 요구사항 분석
2. 🛠️ 구현: 기능 구현
3. 🤔 회고: 구현 과정 회고
4. 📝 문서화: 변경사항 문서화
5. 💾 커밋: 검증 후 커밋

🔍 현재 단계: [분석]
요구사항을 분석하겠습니다...
```

## ⚠️ 주의사항
- CLAUDE.md만으로는 부족, instructions.md 필요
- 명시적이고 반복적인 지시 필요
- 시스템적 강제가 핵심

## 🔗 관련 문서
- @.workflow/core/README.md
- @.claude/instructions.md
- @.principles/development/04-IMMEDIATE-RECOGNITION.md