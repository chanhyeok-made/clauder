---
doc_id: 527
---

# Clauder 디렉토리 구조 개편 계획

## 목표
- 사용자용 문서와 개발자용 문서의 명확한 분리
- 직관적인 디렉토리 구조
- 접근성 향상

## 제안하는 새 구조

```
clauder/
├── README.md                    # 프로젝트 소개 (사용자 진입점)
├── quick-start.md              # 빠른 시작 가이드 (신규)
├── EXAMPLES.md                 # 실제 사용 예시
│
├── docs/                       # 사용자 문서 (공개)
│   ├── README.md              # 문서 인덱스
│   ├── installation/          # 설치 가이드
│   │   ├── README.md
│   │   └── requirements.md
│   ├── commands/              # 명령어 레퍼런스
│   │   ├── README.md         # = 현재 COMMAND_INDEX.md
│   │   ├── clauder-start.md
│   │   ├── clauder-daily.md
│   │   └── ...
│   ├── guides/                # 사용 가이드
│   │   ├── workflows.md
│   │   ├── troubleshooting.md
│   │   ├── best-practices.md  # TOKEN_TIPS + OPTIMIZATION 통합
│   │   └── capabilities.md
│   └── templates/             # 사용자가 참고할 템플릿
│       ├── README.md
│       └── examples/
│
├── .claude/                    # Claude Code 전용 (핵심)
│   ├── config.yaml            # 통합 설정 (aliases + references)
│   ├── version-tree.yaml      # 버전 관리 데이터
│   ├── instructions.md        # Claude 동작 지시
│   │
│   ├── templates/             # 시스템 템플릿 (건드리지 않음)
│   │   ├── CLAUDE.template.md
│   │   ├── core/
│   │   └── contexts/
│   │
│   └── custom/                # 사용자 커스터마이징
│       ├── project.yaml
│       └── overrides/
│
└── .clauder-dev/              # 개발자 전용 (신규, 숨김)
    ├── README.md              # 개발자 가이드
    ├── principles/            # 개발 원칙
    │   ├── README.md
    │   ├── 00-meta-principles.md
    │   ├── 01-reference-structure.md
    │   └── ...
    ├── design/                # 설계 문서
    │   ├── architecture.md    # 현재 ARCHITECTURE.md
    │   ├── version-tracking.md
    │   ├── hooks-system.md
    │   └── reference-strategy.md
    ├── roadmap/               # 개발 계획
    │   ├── migration-plan.md
    │   ├── version-tree-migration.md
    │   └── future-features.md
    └── tools/                 # 개발 도구
        ├── scripts/
        └── helpers/
```

## 주요 변경사항

### 1. 사용자 문서 통합 (`docs/`)
- 모든 사용자용 문서를 최상위 `docs/`로 이동
- 명령어 문서를 `docs/commands/`로 재구성
- 가이드 문서 통합 및 개선

### 2. 개발자 문서 분리 (`.clauder-dev/`)
- 숨김 디렉토리로 일반 사용자 혼란 방지
- 원칙, 설계, 로드맵 명확히 구분
- 개발 도구 전용 공간

### 3. 핵심 시스템 간소화 (`.claude/`)
- 꼭 필요한 파일만 유지
- 설정 파일 통합 (config.yaml)
- 명확한 역할 분담

## 마이그레이션 계획

### Phase 1: 구조 생성
1. 새 디렉토리 생성
2. 문서 이동 및 재구성
3. 참조 업데이트

### Phase 2: 통합 및 개선
1. 중복 내용 통합
2. 사용자 문서 개선
3. 개발 문서 정리

### Phase 3: 검증
1. 모든 참조 확인
2. 명령어 동작 테스트
3. 문서 접근성 확인

## 예상 효과

### 사용자 관점
- ✅ 필요한 문서를 쉽게 찾을 수 있음
- ✅ 개발 문서에 혼란스러워하지 않음
- ✅ 명확한 시작점 (quick-start.md)

### 개발자 관점
- ✅ 체계적인 개발 문서 관리
- ✅ 원칙과 설계의 명확한 구분
- ✅ 효율적인 도구 관리

### 유지보수 관점
- ✅ 명확한 책임 분리
- ✅ 버전 관리 용이
- ✅ 확장성 향상