# /clauder # /generate

템플릿과 설정을 기반으로 문서를 생성합니다.

## 사용법

```
/clauder generate [target]
```

### 대상

- `claude.md` (기본값): CLAUDE.md 파일 재생성
- `all`: 모든 문서 재생성
- `preview`: 변경사항 미리보기

## 동작

1. `.claude/custom/project.yaml` 읽기
2. 템플릿 파일의 변수 치환
3. 조건부 섹션 처리
4. 파일 생성 또는 업데이트

## 예시

### CLAUDE.md 재생성

```
/clauder generate
```

### 미리보기

```
/clauder generate preview
```

## 템플릿 처리

- `{{변수}}`: project.yaml의 값으로 치환
- 조건부 포함: custom 파일이 있으면 우선 사용
- 확장 포인트: 커스텀 내용 삽입
