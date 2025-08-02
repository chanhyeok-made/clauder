# 🚀 Claude Code 문서 시스템 초기화

## initialize 명령

Claude에게 다음과 같이 요청하세요:

```
@initialize project
```

또는 더 구체적으로:

```
@initialize project quick  # 빠른 설정 (필수 항목만)
@initialize project full   # 전체 설정 (모든 항목)
```

## Claude가 할 일

### 1. 프로젝트 분석
- 현재 디렉토리의 파일들을 스캔
- 사용 언어/프레임워크 자동 감지
- 프로젝트 구조 파악

### 2. 질문을 통한 정보 수집
필수 질문:
- 프로젝트 이름은 무엇인가요?
- 프로젝트의 주요 목적은 무엇인가요? (한 문장)
- 주로 사용하는 프로그래밍 언어는?

선택적 질문 (full 모드):
- 아키텍처 패턴은? (Monolithic/Microservices/Serverless)
- 사용하는 주요 프레임워크는?
- 데이터베이스는 무엇을 사용하나요?
- 배포 환경은?

### 3. 자동 생성
Claude가 다음 파일들을 생성합니다:
- `.claude/custom/project.yaml` - 프로젝트 설정
- `CLAUDE.md` - 메인 가이드 문서

## 사용 예시

```
User: @initialize project quick

Claude: 프로젝트 초기화를 시작합니다. 몇 가지 질문에 답해주세요.

1. 프로젝트 이름은 무엇인가요?
User: MyAwesomeApp

2. 프로젝트의 주요 목적은 무엇인가요? (한 문장)
User: 사용자 피드백을 실시간으로 수집하고 분석하는 시스템

3. 주로 사용하는 프로그래밍 언어는?
User: TypeScript

Claude: 프로젝트 구조를 분석한 결과 다음을 발견했습니다:
- package.json 발견 → Node.js 프로젝트
- React 의존성 발견 → React 프레임워크
- PostgreSQL 연결 코드 발견 → PostgreSQL 데이터베이스

이제 설정 파일을 생성하겠습니다...
```

## 재초기화

이미 초기화된 프로젝트에서 다시 실행하면:
```
@reinitialize project  # 기존 설정을 업데이트
@initialize project --force  # 처음부터 다시 설정
```

## 부분 업데이트

특정 부분만 업데이트하려면:
```
@update project tech-stack  # 기술 스택 정보만 업데이트
@update project commands    # 명령어만 업데이트
@update project structure   # 프로젝트 구조만 업데이트
```

---

💡 **팁**: Claude는 프로젝트의 파일들을 분석하여 많은 정보를 자동으로 추론할 수 있습니다. 
"잘 모르겠어요"라고 답하면 Claude가 알아서 채워넣습니다.