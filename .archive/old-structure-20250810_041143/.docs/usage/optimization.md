---
doc_id: 807
---

# 토큰 최적화 규칙

## 문서 로딩 전략

```
BEFORE 세션 시작:
- LOAD: .claude/config.yaml 참조
- LOAD: 필수 문서만 (설정 파일 참조)
- DEFER: 나머지는 필요 시 로드
```

## 컨텍스트 압축

```
IF 파일 크기 > 2000 토큰:
- USE: context-compressor.py
- APPLY: 메타데이터 압축
- APPLY: 별칭 변환
- TRUNCATE: 긴 코드 블록
```

## 프로젝트 패턴 학습

```
AFTER 각 세션:
- RECORD: 사용된 문서
- UPDATE: .claude/custom/patterns.yaml
- OPTIMIZE: 다음 세션 위해 학습
```

## Lazy Loading 원칙

- **즉시 필요**: 핵심 워크플로우, 긴급 사항만
- **필요 시 로드**: 상세 가이드, 참고 문서
- **연기 로드**: 예시, 문제 해결, 고급 기능

## 최적화 우선순위

1. **instructions.md**: 매 세션 로드됨
2. **README.md**: 자주 참조됨
3. **가이드 문서들**: 특정 작업 시
4. **예시/아키텍처**: 드물게 필요