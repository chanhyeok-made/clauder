---
doc_id: 712
---

# 프로젝트 맥락(Contexts) 디렉토리

이 디렉토리는 프로젝트별 맥락 문서를 보관하는 곳입니다.

## 용도
- 프로젝트 특화 가이드
- API 설계 규칙
- 코딩 컨벤션
- 디버깅 가이드
- 배포 프로세스
- 기타 프로젝트별 문서

## 파일 추가 방법

### 1. 명령어 사용 (권장)
```
/clauder add context <name>
```

### 2. 수동 생성
1. 이 디렉토리에 `.md` 파일 생성
2. 문서 작성

## 파일명 규칙
- 소문자 사용
- 단어 구분은 하이픈(-) 사용
- 설명적인 이름 사용

예시:
- DONE: `api-design.md`
- DONE: `error-handling.md`
- DONE: `deployment-process.md`
- FORBIDDEN: `guide1.md`
- FORBIDDEN: `APIDESIGN.md`

## 템플릿
새 맥락 문서 작성 시 다음 템플릿을 참고하세요:
@.claude/templates/contexts/context-template.md

## 자동 로드
이 디렉토리의 모든 `.md` 파일은 Claude Code 시작 시 자동으로 로드됩니다.

## 추가 정보
상세한 가이드는 @docs/guides/adding-contexts.md를 참조하세요.