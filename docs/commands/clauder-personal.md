---
doc_id: 718
---

개인 설정 관리

## 고유 기능
```
personal init         # 개인 설정 초기화
personal show         # 현재 개인 설정 표시
personal add context  # 개인 맥락 추가
personal clear        # 개인 설정 초기화
```

## 상세 사용법

### init - 개인 설정 초기화
```
/clauder personal init
```
- `.claude/custom/personal/` 디렉토리 생성
- 템플릿 파일 복사
- 기본 설정 생성

### show - 현재 설정 표시
```
/clauder personal show
```
- 활성화된 개인 설정 표시
- 로드된 개인 맥락 목록
- 개인 별칭 확인

### add context - 개인 맥락 추가
```
/clauder personal add context <name>
```
- `.claude/custom/personal/contexts/<name>.md` 생성
- 개인 전용 맥락 문서

### clear - 설정 초기화
```
/clauder personal clear
```
- 개인 설정 디렉토리 비우기
- 확인 후 실행

## 예시
```
/clauder personal init
→ 개인 설정 디렉토리 및 템플릿 생성

/clauder personal add context debugging
→ 개인 디버깅 가이드 생성

/clauder personal show
→ 현재 개인 설정 상태 표시
```

## 옵션
- `--no-personal`: 일시적으로 개인 설정 비활성화
- `--reset`: 개인 설정을 템플릿으로 리셋

## 관련 문서
- 개인 설정 가이드: @docs/guides/personal-settings.md
- 맥락 추가: @docs/guides/adding-contexts.md

@TODO-ALIAS
