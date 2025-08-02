---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "b34f41a"
  
dependencies:
  - file: ".claude/docs/guides/TOKEN_TIPS.md"
    commit: "b34f41a"
  - file: ".claude/LOADING_STRATEGY.md"
    commit: "b34f41a"
    
references:
  - file: ".claude/docs/guides/WORKFLOWS.md"
    commit: "b34f41a"
---

# 🚀 Clauder 최적화 가이드

대규모 프로젝트에서 Claude Code의 성능을 최적화하는 방법입니다.

## 📊 토큰 최적화

### 토큰 절약 팁
@.claude/docs/guides/TOKEN_TIPS.md

효율적인 토큰 사용을 위한 구체적인 전략입니다.

### 로딩 전략
@.claude/LOADING_STRATEGY.md

문서 로딩 순서와 우선순위 관리 방법입니다.

## 🎯 최적화 전략

### 1. 문서 구조 최적화
- 모듈화: 한 문서 = 한 개념
- 참조 활용: 중복 내용 제거
- 압축: 불필요한 공백과 주석 제거

### 2. 선택적 로딩
```yaml
# .claude/config.yaml
loading:
  priority:
    - essential: true
    - context: "current-task"
  defer:
    - type: "reference"
    - size: "> 1000 lines"
```

### 3. 컨텍스트 관리
- 작업별 컨텍스트 분리
- 필요한 문서만 로드
- 세션 간 캐싱 활용

## 📈 성능 측정

### 메트릭
- 토큰 사용량
- 응답 시간
- 컨텍스트 적중률

### 모니터링
```bash
# 토큰 사용량 확인
/clauder stats tokens

# 로딩 성능 분석
/clauder analyze loading
```

## 🔧 최적화 도구

### 자동 최적화
```bash
# 문서 최적화
/clauder optimize docs

# 참조 최적화
/clauder optimize refs
```

### 수동 최적화
1. 중복 제거
2. 참조 구조 개선
3. 불필요한 문서 정리

## 💡 베스트 프랙티스

### DO
- ✅ 모듈화된 문서 구조 유지
- ✅ 별칭으로 긴 경로 단축
- ✅ 작업 컨텍스트 활용
- ✅ 정기적인 문서 정리

### DON'T
- ❌ 한 문서에 모든 내용 포함
- ❌ 깊은 중첩 참조
- ❌ 사용하지 않는 문서 방치
- ❌ 과도한 주석과 예시

## 📊 최적화 결과

### 일반적인 개선 사항
- 토큰 사용량: 30-50% 감소
- 응답 속도: 20-40% 향상
- 정확도: 유지 또는 개선

### 사례 연구
- 대규모 프로젝트 (10k+ 파일): 70% 토큰 절약
- 모노레포: 선택적 로딩으로 80% 개선
- 다국어 프로젝트: 언어별 컨텍스트로 60% 최적화

## 관련 문서
- 워크플로우: @.claude/docs/guides/WORKFLOWS.md
- 문서 모듈화: @.claude/docs/principles/03-DOCUMENT-MODULARITY.md