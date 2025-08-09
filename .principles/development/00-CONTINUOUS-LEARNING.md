---
doc_id: 701
---

# 원칙 0: 지속적 학습과 개선

## 핵심 규칙

### 실수와 개선 기회의 체계적 관리
- 작업 중 실수 발생 시 즉시 분석
- 더 나은 해결 방법 발견 시 문서화
- 사용자 피드백의 영구적 반영

### 학습 내용의 구조화
```yaml
learning_entry:
  situation: "발생한 상황"
  initial_approach: "초기 접근 방법"
  better_solution: "개선된 해결책"
  root_cause: "초기 접근의 한계점"
  prevention: "재발 방지 방법"  # 필수!
```

### 재발 방지책 필수
- 모든 학습 기록에는 구체적인 재발 방지책 포함
- 프로세스, 도구, 체크리스트 등 실질적 대책 수립
- 재발 방지책 없는 학습은 불완전한 학습

## 실천 방법

### 1. 즉시 기록
- 실수나 개선점 발견 즉시 기록
- `.clauder-dev/learnings/` 디렉토리 활용
- 카테고리별 분류 (error-handling, optimization, user-feedback)

### 2. 패턴 인식
- 반복되는 실수 패턴 식별
- 공통 개선점 도출
- 원칙이나 가이드라인으로 승격

### 3. 지식 전파
- 학습 내용을 관련 문서에 반영
- 명령어나 프로세스 개선
- 다른 프로젝트에도 적용 가능하도록 일반화

## 구현 방법

### 학습 기록 구조
```
.clauder-dev/learnings/
├── error-patterns/      # 실수 패턴과 해결책
├── optimizations/       # 최적화 방법
├── user-feedback/       # 사용자 피드백 기반 개선
└── INDEX.md            # 학습 내용 인덱스
```

### 자동 반영 프로세스
1. 학습 내용 기록
2. 관련 문서 업데이트
3. 필요시 새 원칙 생성
4. 버전 트리에 반영

## 예시

### 토큰 최적화 학습
```yaml
situation: "문서 참조 시 토큰 과다 사용"
initial_approach: "각 파일에 전체 메타데이터 저장"
better_solution: "중앙 버전 트리로 통합 관리"
root_cause: "분산된 정보 관리로 인한 중복"
prevention: "중앙 집중식 메타데이터 관리 원칙 확립"
```

### 사용자 피드백 반영
```yaml
situation: "경고 메시지가 과도하다는 피드백"
initial_approach: "중요 사항에 느낌표와 경고 추가"
better_solution: "전문적이고 간결한 문서 작성"
root_cause: "과도한 강조가 오히려 가독성 저해"
prevention: "문서 작성 톤 가이드라인 수립"
```

## 관련 문서
- 학습 기록: @.learning/lessons/INDEX.md
- 원칙 목록: @.principles/development/README.md