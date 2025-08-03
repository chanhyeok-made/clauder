---
doc_id: 526
---

# Clauder 개발자 가이드

이 디렉토리는 Clauder 프로젝트 자체를 개발하고 개선하는 사람들을 위한 공간입니다.

## 디렉토리 구조

```
.clauder-dev/
├── principles/      # 개발 원칙 및 철학
├── design/         # 아키텍처 및 설계 문서
├── roadmap/        # 개발 계획 및 마이그레이션
└── tools/          # 개발 도구 및 스크립트
```

## 개발 원칙

### 핵심 원칙
1. **참조 구조** - 모든 문서의 완벽한 참조 관리
2. **프로젝트 독립성** - 템플릿과 실제 파일 분리
3. **문서 모듈화** - 단일 책임 원칙
4. **즉시 인지** - Claude Code 시작 시 자동 로드
5. **양방향 참조** - 역참조 필수
6. **작업 단위 커밋** - 완료된 작업은 즉시 푸시

상세 내용: @.clauder-dev/principles/

## 아키텍처

- **전체 구조**: @.clauder-dev/design/architecture.md
- **버전 추적**: @.clauder-dev/design/VERSION_TRACKING.md
- **훅 시스템**: @.clauder-dev/design/HOOKS.md
- **참조 전략**: @.clauder-dev/design/REFERENCE_STRATEGY.md

## 개발 가이드

### 새 기능 추가
1. 원칙 준수 확인
2. 설계 문서 작성
3. 구현 및 테스트
4. 문서 업데이트
5. 버전 트리 동기화

### 버전 트리 관리
- 가이드: @.clauder-dev/tools/helpers/VERSION-TREE-GUIDE.md
- 헬퍼: @.clauder-dev/tools/helpers/version-tree-helper.md
- 스크립트: @.clauder-dev/tools/scripts/

### 문서 작성 규칙
- 전문적인 톤 유지
- 경고나 느낌표 사용 자제
- 명확하고 간결한 설명
- 예시 포함

## 기여 방법

1. 이슈 생성 및 논의
2. 개발 원칙 숙지
3. 설계 검토
4. PR 제출
5. 리뷰 및 병합

## 주의사항

이 디렉토리의 내용은 Clauder 내부 개발용입니다.
일반 사용자는 `/docs` 디렉토리의 문서를 참조하세요.