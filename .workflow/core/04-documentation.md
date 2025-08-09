---
doc_id: 760
---

# 문서화 단계

## 목적
작업 내용을 프로젝트 문서에 반영하여 지식을 보존합니다.

## 문서 작성 원칙

### 1. Lazy Loading 적용
- 긴 내용은 별도 문서로 분리
- 참조로 연결하여 토큰 효율성 극대화

### 2. 참조 규칙
- 같은 디렉토리: `@filename.md` (상대 참조)
- 다른 디렉토리: `@.path/to/file.md` (절대 참조)
- 디렉토리 참조: `@.path/to/directory/` (자동으로 README.md)
- 상세: @.principles/base/structure/directory-organization.md

### 3. 모듈화
- 한 문서 = 한 주제
- 명확한 계층 구조
- 재사용 가능한 단위

## 문서화 대상

### 1. 새로운 패턴/방법
- 위치: @.claude/guides/patterns.md
- 형식: 문제-해결-예시

### 2. 프로젝트 맥락
- 위치: @.claude/project/
- 내용: 아키텍처, 의존성, 설정

### 3. API/인터페이스 변경
- 위치: 해당 모듈 문서
- 포함: 변경사항, 마이그레이션 가이드

### 4. 설정/환경 변경
- 위치: @.claude/project/setup.md
- 내용: 새 의존성, 환경 변수

## 문서 업데이트 체크리스트
- [ ] 변경사항이 문서에 반영되었나?
- [ ] 관련 가이드 업데이트 필요한가?
- [ ] Level 1 검증 실행 (1-2분 빠른 체크)

상세 검증은 @.claude/guides/validation/ 참조

## 참조 관리
- 새 참조 추가: @.claude/guides/references.md
- 버전 트리 업데이트: @.claude/guides/version-tree.md

## TOOLS: 자동 체크 도구
```bash
# 문서화 체크리스트 자동 확인
.clauder-dev/tools/scripts/check-documentation.sh
```

## TARGET: Sub-TODO 템플릿

이 단계 시작 시 TodoWrite로 생성:
```
4.1. 주요 변경사항 문서화
4.2. 필요시 새 가이드 생성
4.3. Level 1 검증 실행
```

## 다음 단계
문서화 완료 → @.workflow/core/05-commit.md