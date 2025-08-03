---
doc_id: 508
---

이 문서 시스템은 모든 프로젝트에서 사용 가능한 범용 템플릿입니다.

## 🚨 중요 요구사항

**Git이 필수입니다!** 이 시스템은 Git 커밋 해시를 사용하여 문서 버전을 추적합니다.
프로젝트는 반드시 Git 저장소로 초기화되어야 합니다.

## 🚀 빠른 시작

Claude Code에서 다음 명령 하나로 모든 것을 자동화:
```
/clauder start
```

이 명령은 Git 확인, 프로젝트 분석, 필요한 파일 생성을 모두 자동으로 처리합니다.

### 통합 명령어 (추천)
- `/clauder start` - 프로젝트 자동 설정 🊕
- `/clauder daily` - 매일 상태 체크 및 동기화
- `/clauder hooks install` - 자동화 훅 설치

### 개별 명령어 (고급)
- `/clauder initialize` - 프로젝트 초기화
- `/clauder generate` - CLAUDE.md 생성
- `/clauder check` - 상태 확인
- `/clauder add` - 요소 추가
- `/clauder update` - 설정 업데이트
- `/clauder track` - 문서 버전 관리

자세한 사용법:
- 명령어 인덱스: @/docs/commands/README.md
- 템플릿 가이드: @/docs/templates/README.md
- 문서: `.claude/docs/` 디렉토리 참조

## 📁 디렉토리 구조
```
.claude/
├── templates/              # 범용 템플릿 (수정하지 마세요)
│   ├── core/              # 핵심 템플릿
│   │   ├── 01-essentials.template.md
│   │   ├── 02-work-principles.template.md
│   │   └── 03-dev-principles.template.md
│   └── contexts/          # 상황별 템플릿
│       └── *.template.md
├── custom/                # 사용자 정의 (프로젝트별)
│   ├── project.md         # 프로젝트 정보 (필수)
│   ├── overrides/         # 템플릿 오버라이드
│   └── contexts/          # 추가 컨텍스트
└── CLAUDE.md             # 자동 생성됨 (수정 금지)
```

## 🪝 자동화 훅 시스템

Clauder는 명시적인 훅을 통해 자동화됩니다:

### 핵심 훅 동작
1. **문서 편집 시**: 버전 메타데이터 자동 업데이트
2. **Git 커밋 시**: 모든 문서 버전 동기화
3. **프로젝트 시작 시**: 상태 자동 확인

자세한 설계: `.claude/docs/design/HOOKS.md`

### 훅 설치
```bash
# Git hooks 설치
/clauder hooks install

# 또는 수동 설치
.claude/hooks/install.sh
```

### Claude 지시사항
`.claude/instructions.md`에 명시된 규칙을 Claude가 자동 따릅니다.

## 🚀 사용 방법

### 1. 자동 설정 (추천)
```
# Claude Code에서:
/clauder start
```
한 번의 명령으로 Git 확인부터 모든 설정까지 자동 처리됩니다.

### 2. 수동 설정 (고급 사용자)
```bash
# Git 저장소 확인
git status

# Git이 없다면 초기화
git init
git add .
git commit -m "Initial commit"

# Claude Code에서 개별 명령 실행
/clauder initialize
```

### 2. 커스터마이징
- `custom/project.md`: 프로젝트별 정보 입력
- `custom/overrides/`: 기본 템플릿 수정 시 여기에 복사 후 수정
- `custom/contexts/`: 프로젝트별 추가 가이드

### 3. CLAUDE.md 생성
템플릿과 커스텀 설정을 병합하여 최종 CLAUDE.md가 생성됩니다.

## 🔧 템플릿 시스템

### 변수 치환
```markdown
{{PROJECT_NAME}}      # 프로젝트명
{{PROJECT_DESC}}      # 프로젝트 설명
{{TECH_STACK}}        # 기술 스택
{{CUSTOM_SECTION}}    # 사용자 정의 섹션
```

### 조건부 포함
```markdown
<!-- if:exists custom/overrides/work-principles.md -->
# 커스텀 work-principles 파일 (선택적)
<!-- else -->
@.claude/templates/core/02-work-principles.template.md
<!-- endif -->
```

### 확장 포인트
```markdown
<!-- extend:before -->
[템플릿 내용 앞에 추가할 내용]
<!-- extend:after -->
[템플릿 내용 뒤에 추가할 내용]
```

## 📌 원칙
1. **템플릿 보존**: templates/ 폴더는 수정하지 않음
2. **커스텀 우선**: custom/이 templates/보다 우선
3. **명시적 확장**: 모든 수정은 custom/에서만
4. **버전 관리**: templates/는 업데이트 가능, custom/은 보존
