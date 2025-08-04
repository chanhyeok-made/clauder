---
doc_id: 1000
---

> 🛠️ **이것은 Clauder 프로젝트를 위한 실제 CLAUDE.md입니다**
> 
> 이 파일은 .gitignore에 포함되어 있으며, 
> Clauder 자체 개발을 위한 가이드입니다.

## 📌 작업 완료 시 커밋 및 푸시

모든 작업은 완료 즉시 GitHub에 커밋하고 푸시합니다.

```bash
git add .
git commit -m "작업 설명"
git push origin main
```

원칙: @.clauder-dev/principles/06-WORK-UNIT-COMMITS.md

## 🚨 핵심 원칙 (필수 준수)

### 🎯 기반 원칙
모든 것의 토대가 되는 원칙: @.base-principles/README.md

### 📋 Clauder 개발 원칙
모든 작업은 다음 원칙을 따라야 합니다:

0. **지속적 학습과 개선**: @.clauder-dev/principles/00-CONTINUOUS-LEARNING.md
1. **완벽한 참조 구조**: @.clauder-dev/principles/01-REFERENCE-STRUCTURE.md
2. **프로젝트 독립성**: @.clauder-dev/principles/02-PROJECT-INDEPENDENCE.md
3. **문서 모듈화**: @.clauder-dev/principles/03-DOCUMENT-MODULARITY.md
4. **즉시 인지 가능**: @.clauder-dev/principles/04-IMMEDIATE-RECOGNITION.md
5. **필수 역참조**: @.clauder-dev/principles/05-BIDIRECTIONAL-REFERENCES.md
6. **작업 단위 커밋 및 푸시**: @.clauder-dev/principles/06-WORK-UNIT-COMMITS.md
8. **문서 작성 기준**: @.clauder-dev/principles/08-DOCUMENTATION-STANDARDS.md

전체 원칙 목록: @.clauder-dev/principles/README.md

## 📋 프로젝트 정보

### 프로젝트 개요
- **이름**: Clauder
- **설명**: Claude Code를 위한 범용 문서 템플릿 시스템
- **기술 스택**: Markdown, YAML, Shell Script, Python
- **주요 목적**: 모든 프로젝트에서 재사용 가능한 구조화된 문서화 프레임워크 제공

### 빠른 시작 가이드
1. Git 저장소 확인/초기화
2. `/clauder start` 명령 실행
3. 프로젝트 정보 입력
4. 자동으로 CLAUDE.md 생성

### 프로젝트 구조
```
clauder/
├── README.md                # 프로젝트 소개
├── quick-start.md          # 빠른 시작 가이드
├── EXAMPLES.md             # 사용 예시
├── CLAUDE.md               # 실제 프로젝트 가이드 (gitignore)
├── CLAUDE.base.md          # 템플릿 파일
├── docs/                   # 사용자 문서
│   ├── commands/           # 명령어 레퍼런스
│   ├── guides/             # 사용 가이드
│   └── templates/          # 템플릿 가이드
├── .claude/                # 시스템 핵심
│   ├── templates/          # 시스템 템플릿
│   ├── custom/             # 프로젝트 커스텀
│   │   └── personal/       # 개인 설정
│   ├── hooks/              # 자동화 훅
│   ├── config.yaml         # 통합 설정
│   └── version-tree.yaml   # 중앙 버전 관리
└── .clauder-dev/           # 개발자 전용
    ├── principles/         # 개발 원칙
    ├── design/             # 설계 문서
    ├── learnings/          # 학습 기록
    ├── temp/               # 임시 파일 (gitignore)
    ├── logs/               # 로그 파일 (gitignore)
    ├── FILE-MANAGEMENT-POLICY.md  # 파일 관리 정책
    └── tools/              # 개발 도구
```

## 🔧 개발 가이드

### 작업 원칙
- 템플릿 보존: templates/ 폴더는 수정하지 않음
- 커스텀 우선: custom/이 templates/보다 우선
- 명시적 확장: 모든 수정은 custom/에서만
- 버전 관리: 중앙 version-tree.yaml로 통합 관리
- 문서 기반: 스크립트 대신 문서로 설정
- 학습 지향: 실수와 개선사항을 learnings/에 기록
- 파일 수명 주기: FILE-MANAGEMENT-POLICY.md 준수

### 코딩 컨벤션
**Markdown:**
- GitHub Flavored Markdown 사용
- YAML front matter로 메타데이터 관리
- 참조는 @[alias] 형식 사용

**YAML:**
- 2 space 들여쓰기
- 명확한 키 네이밍
- 주석으로 설명 추가

**Scripts:**
- Shell: POSIX 호환성 유지
- Python: 3.8+ 호환
- 에러 처리 필수

### 테스트 및 빌드
```bash
# 문서 및 설정 검증
/clauder check

# 훅 시스템 테스트
.claude/hooks/test.sh

# 템플릿 생성 테스트
/clauder generate --dry-run
```

## 🚀 개발 워크플로우

### 새 기능 추가
1. GitHub에 이슈 생성
2. feature 브랜치 생성
3. 템플릿 수정 시 하위 호환성 유지
4. 명령어 추가 시 문서 업데이트
5. PR 전 `/clauder check` 실행

### 기여 가이드
1. Fork 후 feature 브랜치 생성
2. 커밋 메시지는 명확하게
3. 테스트 통과 확인
4. 문서 업데이트 포함

## 📚 핵심 참조

### 사용자 문서
- 빠른 시작: @quick-start.md
- 사용 예시: @EXAMPLES.md
- 명령어 인덱스: @docs/commands/README.md
- 워크플로우: @docs/guides/workflows.md
- 문제 해결: @docs/guides/troubleshooting.md
- 모범 사례: @docs/guides/best-practices.md

### 개발자 문서
- 개발자 가이드: @.clauder-dev/README.md
- 아키텍처: @.clauder-dev/design/architecture.md
- 기능 지도: @.clauder-dev/design/feature-map.md
- 버전 추적: @.clauder-dev/design/VERSION_TRACKING.md
- 훅 시스템: @.clauder-dev/design/HOOKS.md
- 참조 전략: @.clauder-dev/design/REFERENCE_STRATEGY.md

## 💡 주요 기능

1. **템플릿 시스템**
   - 변수 치환 지원
   - 조건부 포함
   - 오버라이드 메커니즘
   - 개인 설정 지원

2. **중앙 버전 추적**
   - doc_id 기반 참조 (90% 토큰 절약)
   - Git 커밋 해시 추적
   - 자동 동기화
   - 의존성 관리

3. **참조 시스템**
   - 경로 별칭
   - 중앙 레지스트리
   - 양방향 참조 추적
   - 순환 참조 방지

4. **훅 시스템**
   - Git hooks
   - Claude instructions
   - 명시적 자동화

5. **명령어 인터페이스**
   - `/clauder` 네임스페이스
   - 15+ 명령어 지원
   - 자동 완성
   - 도움말 지원

6. **학습 시스템**
   - 실수 패턴 기록
   - 개선사항 추적
   - 재발 방지책 수립
   - 지식 전파

