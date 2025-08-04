---
doc_id: 749
---

# 🔄 자동화된 워크플로우 지원

## Claude가 자동으로 수행하는 작업

### 1. 상태 표시
```
🔍 현재 단계: [분석/작업/회고/문서화/커밋]
```
모든 응답 시작 시 현재 단계를 명시합니다.

### 2. 요구사항 분석 템플릿
```yaml
요구사항 분석:
  명확도: [명확/불명확]
  기술 상세: [충분/부족]
  작업 크기: [소/중/대]
  
불명확한 부분:
  1. [항목1]
  2. [항목2]
  
다음 단계:
  - [액션1]
  - [액션2]
```

### 3. TODO 자동 생성
요구사항이 복잡하거나 불명확할 때 자동으로 TodoWrite 도구 사용:
```yaml
- 분석 필요 사항
- 구현 단계
- 검증 항목
- 문서화 대상
```

### 4. 프로젝트 맥락 관리
```bash
# 자동 감지 및 문서화
- 새로운 아키텍처 패턴 발견 → contexts/에 추가
- 반복되는 문제 패턴 → learnings/에 기록
- 성능 프로파일 변경 → 업데이트
```

### 5. 회고 프롬프트
```yaml
작업 완료 후 자동 질문:
- 예상과 다른 부분이 있었나요?
- 더 나은 방법이 있었을까요?  
- 다음에 주의할 점은?
```

## 워크플로우 강제 사항

### Git Hooks (.git/hooks/pre-commit)
```bash
#!/bin/bash
# 커밋 전 자동 체크
- [ ] 테스트 통과 확인
- [ ] 문서 업데이트 확인
- [ ] TODO 완료 확인
```

### Claude Instructions
```markdown
## 필수 워크플로우
1. 모든 요구사항은 분석 단계 거치기
2. 불명확하면 반드시 명확화
3. 작업 후 회고 작성
4. 관련 문서 업데이트
5. 커밋 메시지 규칙 준수
```

## 프로젝트별 커스터마이징

### 워크플로우 설정 (.claude/custom/workflow.yaml)
```yaml
workflow:
  analysis:
    require_clarity_check: true
    auto_project_scan: true
    
  implementation:
    test_before_commit: true
    lint_required: true
    
  documentation:
    auto_update_contexts: true
    require_learnings: true
    
  commit:
    format: "conventional"
    auto_push: false
```

### 프로젝트 특화 체크리스트
```yaml
# API 프로젝트
checklist:
  - API 문서 업데이트
  - Postman 컬렉션 동기화
  - 버전 관리

# 프론트엔드 프로젝트  
checklist:
  - 컴포넌트 스토리북 업데이트
  - 접근성 테스트
  - 번들 크기 확인
```

## 측정 가능한 개선 효과

1. **요구사항 명확화**: 재작업 80% 감소
2. **단계 누락**: 100% → 0%
3. **문서화 일관성**: 모든 작업이 기록됨
4. **학습 축적**: 같은 실수 반복 제거

---

이 템플릿은 체계적 워크플로우를 자동화하여 
일관된 높은 품질의 작업을 보장합니다.