# Claude Code 프로젝트 가이드 - Clauder

> 🛠️ **이것은 Clauder 프로젝트를 위한 실제 CLAUDE.md입니다**
> 
> 이 파일은 .gitignore에 포함되어 있으며, 
> Clauder 자체 개발을 위한 가이드입니다.

## 🆘 작업 완료 시 즉시 커밋!

> **경고**: 모든 작업은 완료 즉시 GitHub에 커밋해야 합니다!
> 
> ```bash
> git add .
> git commit -m "작업 설명"
> git push
> ```
> 
> 원칙: @.claude/docs/principles/06-WORK-UNIT-COMMITS.md

## 🚨 핵심 원칙 (필수 준수)

모든 작업은 다음 원칙을 따라야 합니다:

1. **완벽한 참조 구조**: @.claude/docs/principles/01-REFERENCE-STRUCTURE.md
2. **프로젝트 독립성**: @.claude/docs/principles/02-PROJECT-INDEPENDENCE.md
3. **문서 모듈화**: @.claude/docs/principles/03-DOCUMENT-MODULARITY.md
4. **즉시 인지 가능**: @.claude/docs/principles/04-IMMEDIATE-RECOGNITION.md
5. **필수 역참조**: @.claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md
6. **작업 단위 커밋**: @.claude/docs/principles/06-WORK-UNIT-COMMITS.md

전체 원칙 목록: @.claude/docs/principles/README.md

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
├── README.md                # 프로젝트 소개 및 사용법
├── CLAUDE.base.md          # 템플릿 파일
├── CLAUDE.md               # 실제 프로젝트 가이드 (gitignore)
├── EXAMPLES.md             # 사용 예시
├── ARCHITECTURE.md         # 기술 아키텍처
├── FEATURE_MAP.md          # 기능 지도
└── .claude/
    ├── templates/          # 범용 템플릿 (수정 금지)
    ├── custom/             # 프로젝트별 커스터마이징
    ├── commands/           # Claude Code 명령어 정의
    ├── docs/               # 상세 문서
    ├── hooks/              # 자동화 훅
    └── scripts/            # 유틸리티 스크립트
```

## 🔧 개발 가이드

### 작업 원칙
- 템플릿 보존: templates/ 폴더는 수정하지 않음
- 커스텀 우선: custom/이 templates/보다 우선
- 명시적 확장: 모든 수정은 custom/에서만
- 버전 관리: templates/는 업데이트 가능, custom/은 보존
- 문서 기반: 스크립트 대신 문서로 설정

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

### 문서
- 시스템 설명: @.claude/README.md
- 아키텍처: @ARCHITECTURE.md
- 사용 예시: @EXAMPLES.md
- 기능 지도: @FEATURE_MAP.md

### 설계 문서
- 버전 추적: @.claude/docs/design/VERSION_TRACKING.md
- 훅 시스템: @.claude/docs/design/HOOKS.md
- 참조 전략: @.claude/docs/design/REFERENCE_STRATEGY.md

### 가이드
- 워크플로우: @.claude/docs/guides/WORKFLOWS.md
- 문제 해결: @.claude/docs/guides/TROUBLESHOOTING.md

## 💡 주요 기능

1. **템플릿 시스템**
   - 변수 치환 지원
   - 조건부 포함
   - 오버라이드 메커니즘

2. **버전 추적**
   - Git 커밋 해시 기반
   - 의존성 추적
   - 자동 동기화

3. **참조 시스템**
   - 경로 별칭
   - 중앙 레지스트리
   - 컨텍스트 최적화

4. **훅 시스템**
   - Git hooks
   - Claude instructions
   - 명시적 자동화

5. **명령어 인터페이스**
   - `/clauder` 네임스페이스
   - 자동 완성
   - 도움말 지원

---

*이 문서는 Clauder 프로젝트 자체를 위한 것입니다. 
다른 프로젝트에 적용하려면 CLAUDE.base.md를 사용하세요.*