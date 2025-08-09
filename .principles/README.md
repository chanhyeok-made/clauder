---
doc_id: 4000
created: 2025-08-10
type: core
version: 0.1.0
---

# Clauder Core Engine

## 목적
Clauder의 모듈 시스템을 구동하는 핵심 엔진

## Core 구성 요소

### 1. Engine (엔진)
- **loader.sh**: 모듈 로딩 및 초기화
- **registry.sh**: 모듈 레지스트리 관리
- **dependency.sh**: 의존성 해결
- **version.sh**: 버전 호환성 검사

### 2. Principles (원칙)
- **base/**: 기반 원칙 (from .base-principles)
- **interfaces/**: 확장 포인트 정의

### 3. API (인터페이스)
- **module.interface**: 모듈 표준 인터페이스
- **hook.interface**: 훅 시스템 인터페이스
- **config.interface**: 설정 인터페이스

## 핵심 기능

### 모듈 생명주기
```bash
1. Discovery   # 모듈 탐색
2. Validation  # 유효성 검사
3. Resolution  # 의존성 해결
4. Loading     # 모듈 로드
5. Initialize  # 초기화
6. Ready       # 사용 준비 완료
```

### 의존성 관리
- Semantic Versioning (SemVer) 지원
- 순환 의존성 감지
- 자동 해결 및 설치

### 훅 시스템
- Pre/Post 훅 지원
- 우선순위 기반 실행
- 비동기 처리 가능

## 디렉토리 구조
```
core/
├── README.md          # 이 파일
├── engine/            # 엔진 구현
│   ├── loader.sh      # 모듈 로더
│   ├── registry.sh    # 레지스트리
│   ├── dependency.sh  # 의존성 관리
│   └── version.sh     # 버전 관리
├── principles/        # 원칙
│   ├── base/          # 기반 원칙
│   └── development/   # 개발 원칙
└── api/              # 인터페이스
    ├── module.json    # 모듈 스키마
    ├── hook.json      # 훅 스키마
    └── config.json    # 설정 스키마
```

## 사용법

### 엔진 초기화
```bash
source core/engine/loader.sh
clauder_init
```

### 모듈 로드
```bash
clauder_load_module "workflow@2.0.0"
```

### 의존성 확인
```bash
clauder_check_dependencies
```

## 설계 원칙

1. **최소 핵심**: Core는 최소한의 기능만 포함
2. **확장 가능**: 모든 기능은 모듈로 확장
3. **하위 호환**: 기존 구조와 공존 가능
4. **격리 실행**: 모듈 간 격리 보장

## 버전 정책
- Core는 독립적 버전 관리
- Major 변경 시 모든 모듈 재검증
- Minor/Patch는 하위 호환 보장

---

IMPORTANT: Core는 Clauder의 심장부입니다. 변경 시 신중하게 진행하세요.