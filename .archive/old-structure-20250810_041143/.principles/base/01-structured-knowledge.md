---
doc_id: 743
---

# 원칙 1: 구조화된 지식 증강

## 핵심 개념
Claude가 프로젝트를 더 잘 이해하도록 정보를 구조화하여 제공합니다.

## 왜 중요한가?

### 문제 상황
```
User: 로그인 API 수정해줘
Claude: 어떤 프레임워크를 사용하시나요? 
        데이터베이스는 무엇인가요?
        인증 방식은 무엇인가요?
        API 경로는 어떻게 되나요?
        ... (끝없는 질문)
```

### 해결된 상황
```
User: 로그인 API 수정해줘
Claude: [CLAUDE.md 참조] Express + PostgreSQL + JWT 구조를 확인했습니다.
        /api/auth/login 엔드포인트를 수정하겠습니다.
        [즉시 정확한 코드 생성]
```

## 구현 방법

### 1. 문서 구조화
```yaml
# 명시적 메타데이터
doc_id: 123
version: 
  created: "2025-08-03"
  commit: "abc123"
  
# 명확한 의존성
dependencies:
  - file: "auth-guide.md"
    commit: "def456"
```

### 2. 정보 계층화
```
프로젝트 정보 (최상위)
  ├── 기술 스택 (구체적)
  ├── 아키텍처 패턴
  └── 코딩 컨벤션
      ├── 네이밍 규칙
      └── 파일 구조
```

### 3. 컨텍스트 최적화
```yaml
# 필요한 정보만 로드
api_development:
  relevant_docs:
    - api-patterns.md
    - error-handling.md
  exclude:
    - frontend/
    - devops/
```

## 적용 예시

### Clauder 자체에서
- 버전 트리: 모든 문서를 중앙에서 관리
- doc_id 시스템: 효율적인 참조
- 명시적 의존성: 관계 명확화

### 사용자 프로젝트에서
```yaml
# .claude/custom/project.yaml
project:
  name: "my-api"
  tech_stack:
    backend: ["Node.js", "Express", "PostgreSQL"]
    auth: ["JWT", "OAuth2"]
  patterns:
    api: "RESTful"
    error: "Standard HTTP codes"
```

## 측정 가능한 효과

1. **컨텍스트 파악 시간**: 5-10회 질답 → 0회
2. **정확도**: 여러 번 수정 → 첫 시도 성공
3. **토큰 효율성**: 불필요한 정보 제외로 30% 절약

## 핵심 원리

> "모든 지식은 찾을 수 있고, 연결되어 있으며, 최신이어야 한다"

- **찾을 수 있음**: 명확한 경로와 ID
- **연결됨**: 의존성과 참조 관계
- **최신**: 버전 추적과 커밋 해시

---

구조화된 지식은 Claude와의 협업을 질적으로 변화시킵니다.
묻고 답하는 관계에서 즉시 이해하고 실행하는 관계로 발전합니다.