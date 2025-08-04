---
doc_id: 760
---

# 문서화 단계

## 목적
작업 내용을 프로젝트 문서에 반영하여 지식을 보존합니다.

## 🚨 Lazy Loading 원칙

문서 작성 시 **반드시** lazy loading 패턴을 적용하세요:
- ❌ 긴 내용을 직접 포함하지 마세요
- ✅ `@경로/파일.md` 참조로 연결하세요
- 💡 필요한 정보만 필요할 때 로드되도록 구성

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
- [ ] 참조 관계가 올바른가?
- [ ] **Lazy loading 적용되었나? (긴 내용은 참조로)**
- [ ] 버전 정보가 최신인가?
- [ ] 관련 가이드 업데이트 필요한가?

## 참조 관리
- 새 참조 추가: @.claude/guides/references.md
- 버전 트리 업데이트: @.claude/guides/version-tree.md

## 🛠️ 자동 체크 도구
```bash
# 문서화 체크리스트 자동 확인
.clauder-dev/tools/scripts/check-documentation.sh
```

## 다음 단계
문서화 완료 → @.claude/workflow/05-commit.md