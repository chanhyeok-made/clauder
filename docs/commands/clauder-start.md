---
doc_id: 109
---

한 번의 명령으로 프로젝트 완전 초기화

## 고유 기능
1. Git 상태 확인/초기화
2. 프로젝트 분석 (언어, 프레임워크 자동 감지)
3. 3가지 핵심 질문
4. 모든 필수 파일 자동 생성
5. Git hooks 설치

## 사용법
```
/clauder start
```

## 프로세스
```mermaid
graph LR
    A[Git 확인] --> B[프로젝트 분석]
    B --> C[대화형 설정]
    C --> D[파일 생성]
    D --> E[Hooks 설치]
```

## 통합 명령어
이 명령은 다음을 자동 실행:
- `/clauder initialize`
- `/clauder generate`
- `/clauder hooks install`

@[$commands/common/usage-template.md]
