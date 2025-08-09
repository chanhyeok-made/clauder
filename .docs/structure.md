---
doc_id: 816
---

# 상세 디렉토리 구조

## 전체 구조

```
your-project/
├── .claude/
│   ├── templates/          # 범용 템플릿 (수정 금지)
│   │   ├── core/          # 핵심 템플릿
│   │   │   ├── 01-essentials.template.md
│   │   │   ├── 02-work-principles.template.md
│   │   │   └── 03-dev-principles.template.md
│   │   └── contexts/      # 상황별 템플릿
│   ├── custom/             # 프로젝트별 커스터마이징
│   │   ├── project.yaml   # 프로젝트 설정
│   │   ├── overrides/     # 템플릿 오버라이드
│   │   ├── contexts/      # 추가 가이드
│   │   └── personal/      # 개인 설정 (gitignore)
│   ├── commands/           # 명령어 정의
│   ├── docs/               # 시스템 문서
│   ├── hooks/              # 자동화 훅
│   ├── scripts/            # 유틸리티 스크립트
│   ├── instructions.md     # Claude 지시사항
│   ├── config.yaml         # 시스템 설정
│   └── version-tree.yaml   # 버전 추적
├── CLAUDE.base.md           # 템플릿 파일 (Git에 포함)
└── CLAUDE.md                # 실제 파일 (gitignore)
```

## 주요 디렉토리

### templates/
- **역할**: 모든 프로젝트에서 공통으로 사용하는 템플릿
- **규칙**: 직접 수정 금지, 업데이트 시 보존

### custom/
- **역할**: 프로젝트별 커스터마이징
- **규칙**: 자유롭게 수정 가능
- **우선순위**: custom > templates

### commands/
- **역할**: `/clauder` 명령어 정의
- **형식**: Markdown 파일로 명령어 명세

### hooks/
- **역할**: 자동화 스크립트
- **구성**: Git hooks, 설치 스크립트

## 파일 우선순위

1. `.claude/custom/personal/` - 개인 설정 (최우선)
2. `.claude/custom/overrides/` - 프로젝트 오버라이드
3. `.claude/custom/contexts/` - 추가 컨텍스트
4. `.claude/templates/` - 기본 템플릿 (최하위)

## gitignore 설정

```
# Clauder 관련
.claude/custom/project.yaml
.claude/custom/personal/
.claude/.generated/
CLAUDE.md
```