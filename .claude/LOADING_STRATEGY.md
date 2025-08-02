---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "initial"
---

# 📚 Clauder 문서 로딩 전략

이 문서는 Claude가 어떤 문서를 언제 로드해야 하는지 명시합니다.

## 🚀 항상 로드 (Essential)

다음 문서는 모든 대화 시작 시 자동 로드:
1. `.claude/instructions.md` - 핵심 작업 지시사항
2. `CLAUDE.md` - 프로젝트 메인 가이드 (존재하는 경우)
3. 현재 작업 컨텍스트

## 🎯 조건부 로드 (On-Demand)

### 명령어 관련
**트리거**: `/clauder [command]` 형식 감지
```
예: "/clauder start" → .claude/commands/clauder-start.md 로드
```

### 문제 해결
**트리거**: 에러, 문제, 오류, 해결, 도움 키워드
```
→ .claude/docs/guides/TROUBLESHOOTING.md
→ .claude/docs/guides/TOKEN_TIPS.md
```

### 설계/아키텍처
**트리거**: 설계, 구조, 아키텍처, 철학, 원칙
```
→ .claude/docs/design/*.md
→ ARCHITECTURE.md
```

### 워크플로우
**트리거**: 작업 흐름, 프로세스, 절차, 방법
```
→ .claude/docs/guides/WORKFLOWS.md
→ .claude/docs/guides/CAPABILITIES.md
```

### 버전/참조
**트리거**: 버전, 추적, 참조, 링크
```
→ .claude/docs/design/VERSION_TRACKING.md
→ .claude/docs/design/REFERENCE_STRATEGY.md
```

## 💡 로딩 최적화 규칙

### 1. 중복 방지
- 이미 로드된 문서는 재로드하지 않음
- 세션 내 캐시 활용

### 2. 크기 제한
- 파일당 최대 2,000 토큰
- 초과 시 자동 요약

### 3. 우선순위
1. 사용자가 명시적으로 요청한 문서
2. 현재 작업과 직접 관련된 문서
3. 자주 참조되는 문서
4. 기타 관련 문서

## 📊 효과

이 전략으로:
- 초기 로드: 3,000 토큰 (기존 15,000)
- 필요시 추가: +2,000-3,000 토큰
- 총 절약: 60-70%

## 🔄 동적 조정

Claude는 다음을 학습하여 로딩 전략 개선:
- 사용 패턴
- 자주 요청되는 문서
- 프로젝트별 특성