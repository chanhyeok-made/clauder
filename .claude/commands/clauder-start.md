---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "61bcea8"
  
dependencies:
  - file: ".claude/commands/clauder-initialize.md"
    commit: "78b8a7b"
    status: "current"
  - file: ".claude/commands/clauder-generate.md"
    commit: "78b8a7b"
    status: "current"
  - file: ".claude/commands/clauder-track.md"
    commit: "78b8a7b"
    status: "current"
---

# /clauder start

프로젝트를 위한 완전 자동화된 시작 명령입니다.

## 사용법

```
/clauder start [options]
```

### 옵션
- `--quick`: 최소 설정으로 빠르게 시작
- `--interactive`: 모든 옵션을 대화형으로 설정
- `--from-existing`: 기존 파일에서 정보 추출

## 자동 수행 작업

### 1. 환경 검증
- Git 설치 확인
- Git 저장소 상태 확인
- 기존 문서 탐지

### 2. 스마트 초기화
```
이미 package.json이 있나요? → Node.js 프로젝트로 인식
이미 go.mod가 있나요? → Go 프로젝트로 인식
이미 requirements.txt가 있나요? → Python 프로젝트로 인식
```

### 3. 정보 수집 (최소화)
필수 3가지만 질문:
1. 프로젝트 이름 (자동 제안)
2. 한 줄 설명
3. 추가 컨텍스트 필요 여부

### 4. 자동 생성
- `.claude/custom/project.yaml` 생성
- `CLAUDE.md` 생성
- 버전 메타데이터 추가
- Git 커밋 생성

## 실행 예시

### 새 프로젝트
```
User: /clauder start
Claude: 
🚀 Clauder 초기화를 시작합니다...

✅ Git 저장소 확인됨
📦 Node.js 프로젝트 감지 (package.json)

프로젝트 이름은 "my-awesome-app"이 맞나요? (Y/n) 
한 줄로 프로젝트를 설명해주세요: API 서버
특별한 개발 가이드가 필요한가요? (y/N)

✨ 생성 완료!
- .claude/custom/project.yaml
- CLAUDE.md
- 초기 커밋 생성됨

시작할 준비가 되었습니다! 🎉
```

### 기존 프로젝트
```
User: /clauder start --from-existing
Claude:
🔍 기존 프로젝트 분석 중...

✅ CLAUDE.md 발견
✅ README.md 발견
✅ 기술 스택 추론: TypeScript, React, PostgreSQL

이 정보로 초기화하시겠습니까? (Y/n)

♻️ 마이그레이션 완료!
버전 추적이 활성화되었습니다.
```

## 내부 동작 흐름

```mermaid
graph TD
    A[/clauder start] --> B{Git 확인}
    B -->|없음| C[Git 초기화]
    B -->|있음| D[프로젝트 분석]
    C --> D
    D --> E{기존 문서?}
    E -->|있음| F[정보 추출]
    E -->|없음| G[최소 질문]
    F --> H[마이그레이션]
    G --> I[새로 생성]
    H --> J[완료]
    I --> J
```

## 후속 자동화

start 이후 자동으로:
- 파일 변경 시 버전 추적
- 커밋 시 메타데이터 업데이트
- 주기적 일관성 검사

## 관련 명령어
- `/clauder daily` - 일일 체크 자동화
- `/clauder sync` - 전체 동기화
- 개별 명령어들 (고급 사용자용)