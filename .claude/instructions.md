---
doc_id: 756
---

# Claude Code 작업 지시사항

> 이 문서는 Claude Code가 Clauder 프로젝트에서 작업할 때 자동으로 수행해야 하는 행동을 정의합니다.

## 🚨 작업 요청 시 자동 수행

### 1. 워크플로우 TODO 생성
모든 작업 요청을 받으면 **즉시** TodoWrite 도구로 다음 5단계를 등록:

```
1. 📊 분석: [작업 내용] 분석 및 계획 수립
2. 🛠️ 구현: [작업 내용] 구현
3. 🤔 회고: 작업 중 발견사항 및 개선점 정리
4. 📝 문서화: 변경사항 및 학습내용 문서화
5. 💾 커밋: 검증 후 변경사항 커밋
```

### 2. 상태 표시
각 단계 진입 시 명확하게 표시:
```
🔍 현재 단계: [분석]
```

### 3. 단계별 가이드 참조
- **분석**: @.claude/workflow/01-analysis.md
- **구현**: @.claude/workflow/02-implementation.md  
- **회고**: @.claude/workflow/03-retrospective.md
- **문서화**: @.claude/workflow/04-documentation.md
- **커밋**: @.claude/workflow/05-commit.md

## 📋 작업 크기별 접근

### 소형 작업 (30분 이내)
- 5단계 간소화 가능
- 하지만 TODO 등록은 필수

### 중형 작업 (2시간 이내)
- 세부 TODO 추가: @.claude/workflow/planning-medium.md

### 대형 작업 (2시간 이상)
- 상세 계획 수립: @.claude/workflow/planning-large.md

## ⚠️ 절대 금지사항

1. **워크플로우 단계 건너뛰기 금지**
   - 특히 회고와 문서화 단계

2. **TODO 없이 작업 진행 금지**
   - 모든 작업은 추적 가능해야 함

3. **상태 표시 없이 단계 전환 금지**
   - 사용자가 현재 진행 상황을 알 수 있어야 함

## 💡 모범 사례

### TODO 계층화
```
1. 분석 단계
   1-1. 현황 파악
   1-2. 문제점 식별
   1-3. 해결 방안 도출
```

### 진행 상황 업데이트
- 각 세부 작업 완료 시 즉시 상태 업데이트
- 메인 단계는 모든 세부 작업 완료 후 완료 처리

## 🔄 참조 문서
- **워크플로우 개요**: @.claude/workflow/README.md
- **긴급 사항**: @.claude/alerts/urgent.md
- **기반 원칙**: @.base-principles/README.md