---
doc_id: 716
---

# 프로젝트 맥락(Context) 추가하기

> 💡 이 문서는 Lazy Loading 방식으로 최적화되었습니다.
> 필요한 섹션만 참조하세요.

프로젝트에 특화된 가이드나 맥락을 추가하여 Claude Code가 더 잘 이해하고 도움을 줄 수 있도록 할 수 있습니다.

## 맥락이란?

맥락(Context)은 프로젝트의 특정 부분에 대한 상세 가이드입니다. 예를 들어:
- API 엔드포인트 설계 규칙
- 데이터베이스 스키마 가이드
- 에러 처리 패턴
- 테스트 작성 방법
- 배포 프로세스

## 맥락 추가 방법

### 방법 1: 명령어 사용 (권장)
```
/clauder add context <이름>
```

예시:
```
/clauder add context api-design
```

이 명령은:
1. `.claude/custom/contexts/api-design.md` 파일 생성
2. 기본 템플릿 제공
3. 수정할 수 있도록 파일 열기

### 방법 2: 수동 생성
```bash
# 1. contexts 디렉토리로 이동
cd .claude/custom/contexts/

# 2. 새 마크다운 파일 생성
touch debugging-guide.md

# 3. 내용 작성
```

## 맥락 문서 형식

### 기본 구조
```markdown
# [맥락 제목]

## 목적
이 가이드의 목적과 언제 사용되는지 설명

## 핵심 규칙
- 규칙 1
- 규칙 2
- 규칙 3

## 상세 내용
### 섹션 1
내용...

### 섹션 2
내용...

## 예시
구체적인 코드 예시나 시나리오

## 참고 자료
- 관련 문서 링크
- 외부 리소스
```

### 실제 예시: API 설계 가이드
```markdown
# API 설계 가이드

## 목적
이 프로젝트의 RESTful API 설계 원칙과 패턴을 정의합니다.

## 핵심 규칙
- 모든 엔드포인트는 복수형 명사 사용 (예: /users, /posts)
- HTTP 메서드를 올바르게 사용 (GET, POST, PUT, DELETE)
- 일관된 에러 응답 형식 유지

## 엔드포인트 네이밍
### 리소스 접근
- GET /users - 모든 사용자 조회
- GET /users/:id - 특정 사용자 조회
- POST /users - 새 사용자 생성
- PUT /users/:id - 사용자 정보 수정
- DELETE /users/:id - 사용자 삭제

### 중첩 리소스
- GET /users/:id/posts - 특정 사용자의 게시물
- POST /users/:id/posts - 사용자의 새 게시물 생성

## 응답 형식
### 성공 응답
\`\`\`json
{
  "success": true,
  "data": { ... },
  "message": "Successfully retrieved"
}
\`\`\`

### 에러 응답
\`\`\`json
{
  "success": false,
  "error": {
    "code": "USER_NOT_FOUND",
    "message": "User with ID 123 not found"
  }
}
\`\`\`

## 인증
- Bearer 토큰 사용
- Authorization 헤더에 포함
- 예: `Authorization: Bearer <token>`
```

## 맥락 활성화

추가한 맥락은 자동으로 프로젝트에 포함됩니다:

1. **자동 로드**: Claude Code 시작 시 `.claude/custom/contexts/` 디렉토리의 모든 `.md` 파일이 로드됨
2. **우선순위**: 프로젝트별 맥락이 기본 템플릿보다 우선
3. **선택적 로드**: 특정 작업에만 필요한 맥락은 별도 디렉토리에 구성 가능

## 모범 사례

### 1. 명확한 파일명
- ✅ `api-design.md`
- ✅ `database-schema.md`
- ❌ `guide1.md`
- ❌ `temp.md`

### 2. 구조화된 내용
- 목차 포함
- 섹션별 구분
- 구체적인 예시

### 3. 유지보수
- 정기적인 업데이트
- 오래된 정보 제거
- 팀원과 공유

## 고급 기능

### 조건부 맥락
특정 상황에서만 로드되는 맥락 생성:
```yaml
# .claude/custom/contexts/config.yaml
contexts:
  debugging:
    when: "error|bug|fix"
    files:
      - debugging-guide.md
      - error-patterns.md
  
  deployment:
    when: "deploy|release|production"
    files:
      - deployment-checklist.md
      - rollback-procedures.md
```

### 템플릿 변수
프로젝트 정보를 동적으로 포함:
```markdown
# {{PROJECT_NAME}} 코딩 규칙

이 문서는 {{PROJECT_NAME}} 프로젝트의 코딩 규칙을 정의합니다.
현재 버전: {{PROJECT_VERSION}}
```

## 문제 해결

### 맥락이 로드되지 않을 때
1. 파일이 `.claude/custom/contexts/` 디렉토리에 있는지 확인
2. 파일 확장자가 `.md`인지 확인
3. 파일 권한 확인 (읽기 가능)
4. `/clauder check` 실행하여 상태 확인

### 맥락 충돌
여러 맥락이 같은 주제를 다룰 때:
1. 더 구체적인 맥락이 우선
2. 파일명 알파벳 순서로 로드
3. 명시적으로 순서 지정 가능 (config.yaml)

## 📚 다음 단계
- **워크플로우 가이드**: @workflows.md
- **모범 사례**: @best-practices.md