# Claude Code 문서 시스템 - 범용 템플릿

이 문서 시스템은 모든 프로젝트에서 사용 가능한 범용 템플릿입니다.

## 🚀 빠른 시작

Claude에게 다음 명령을 입력하세요:
```
@initialize project
```

자세한 사용법:
- 초기화 가이드: @.claude/INITIALIZE.md
- 명령어 목록: @.claude/COMMANDS.md

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

## 🚀 사용 방법

### 1. 초기 설정
```bash
# 템플릿 복사
cp -r .claude/templates/* .claude/custom/

# 프로젝트 정보 입력
edit .claude/custom/project.md
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
@.claude/custom/overrides/work-principles.md
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