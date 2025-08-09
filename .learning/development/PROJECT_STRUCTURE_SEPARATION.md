---
doc_id: 737
---

# 🎯 Clauder 프로젝트 구조 분리 가이드

## 📊 현재 구조의 이중성

Clauder는 두 가지 목적을 동시에 수행하고 있습니다:
1. **자체 개발**: Clauder 프로젝트 자체의 개발과 개선
2. **범용 템플릿**: 다른 프로젝트에서 사용할 수 있는 템플릿 제공

## 🗂️ 디렉토리별 용도 구분

### 1. Clauder 자체 개발용 (Git에 포함)

```
/.clauder-dev/                  # Clauder 개발 전용
├── principles/                 # Clauder 개발 원칙
│   ├── 00-CONTINUOUS-LEARNING.md
│   ├── 01-REFERENCE-STRUCTURE.md
│   └── ...
├── learnings/                  # 개발 중 배운 점
├── analysis/                   # 프로젝트 분석 문서
├── design/                     # Clauder 설계 문서
│   ├── architecture.md
│   ├── feature-map.md
│   └── ...
├── roadmap/                    # Clauder 로드맵
├── tools/                      # 개발 도구
│   ├── scripts/                # 유틸리티 스크립트
│   ├── helpers/                # 도우미 문서
│   └── archived/               # 보관된 도구
└── FILE-MANAGEMENT-POLICY.md   # 파일 관리 정책

/CLAUDE.md                      # Clauder 개발을 위한 가이드
/CLAUDE.base.md                 # 사용자를 위한 템플릿
```

### 2. 범용 템플릿 (사용자용)

```
/.claude/                       # 사용자가 복사해갈 템플릿
├── templates/                  # 범용 템플릿
│   ├── CLAUDE.template.md      # CLAUDE.md 생성 템플릿
│   ├── core/                   # 핵심 원칙 템플릿
│   │   ├── 01-essentials.template.md
│   │   ├── 02-work-principles.template.md
│   │   └── 03-dev-principles.template.md
│   ├── contexts/               # 컨텍스트 템플릿
│   └── personal/               # 개인 설정 템플릿
├── commands/                   # 명령어 정의 (삭제됨, docs/로 이동)
├── hooks/                      # Git hooks
├── scripts/                    # 사용자 스크립트
├── custom/                     # 사용자 커스터마이징 (gitignore)
│   ├── project.yaml           
│   ├── overrides/             
│   └── contexts/              
├── instructions.md             # Claude 지시사항
├── config.yaml                 # 시스템 설정
└── version-tree.yaml           # 버전 관리 트리

/docs/                          # 사용자 문서
├── commands/                   # 명령어 설명서
├── guides/                     # 사용 가이드
└── templates/                  # 템플릿 가이드
```

### 3. 프로젝트 루트 문서들

```
# Clauder 프로젝트 소개 (Git 포함)
/README.md                      # Clauder 프로젝트 설명
/EXAMPLES.md                    # Clauder 사용 예시
/quick-start.md                 # 빠른 시작 가이드
/interactive-setup.md           # 대화형 설정 가이드

# 사용자가 생성하게 될 파일 (Git 제외)
/CLAUDE.md                      # 자동 생성됨 (gitignore)
```

## 📋 역할별 정리

### Clauder 개발자가 보는 것
1. **/.clauder-dev/**: 모든 개발 관련 문서
2. **/CLAUDE.md**: Clauder 개발을 위한 실제 가이드
3. **/.claude/version-tree.yaml**: Clauder 문서 버전 관리
4. **Git commits**: 모든 개발 이력

### 일반 사용자가 가져가는 것
1. **/.claude/**: 템플릿 시스템 전체
2. **/docs/**: 사용 문서
3. **/CLAUDE.base.md**: 템플릿 기반
4. **예시 파일들**: EXAMPLES.md, quick-start.md

### 사용자가 커스터마이징하는 것
1. **/.claude/custom/**: 프로젝트별 설정
2. **/CLAUDE.md**: 자동 생성되는 가이드
3. **추가 컨텍스트**: 프로젝트별 특수 가이드

## 🔄 워크플로우 분리

### Clauder 개발 워크플로우
```bash
# 1. 새 기능 개발
cd /.clauder-dev/
# 설계 문서 작성, 원칙 업데이트

# 2. 템플릿 개선
cd /.claude/templates/
# 범용 템플릿 수정

# 3. 테스트
/clauder check
/clauder validate

# 4. 문서화
# learnings/, analysis/ 업데이트
```

### 사용자 워크플로우
```bash
# 1. Clauder 복사
cp -r clauder/.claude my-project/

# 2. 초기화
/clauder start

# 3. 커스터마이징
# .claude/custom/ 수정

# 4. 사용
# CLAUDE.md 참조하여 개발
```

## 💡 개선 제안

### 1. 명확한 분리를 위한 추가 작업
- [ ] `.clauder-dev/README.md`: 개발자 전용 가이드
- [ ] `docs/USER_GUIDE.md`: 사용자 전용 가이드
- [ ] `.claude/README.md` 개선: 템플릿 시스템 설명

### 2. 배포 스크립트
```bash
# release.sh - 사용자용 패키지 생성
#!/bin/bash
mkdir -p dist/clauder
cp -r .claude dist/clauder/
cp -r docs dist/clauder/
cp CLAUDE.base.md dist/clauder/
cp quick-start.md dist/clauder/
# .clauder-dev는 제외
```

### 3. 문서 구분 명확화
- 개발 문서: "이 문서는 Clauder 개발자용입니다" 헤더
- 사용자 문서: "이 문서는 Clauder 사용자용입니다" 헤더

## 📌 핵심 원칙

1. **/.clauder-dev/**: Clauder 개발 전용, 사용자는 불필요
2. **/.claude/**: 범용 템플릿, 모든 프로젝트에서 사용
3. **/docs/**: 사용자 문서, 명령어와 가이드
4. **명확한 구분**: 각 문서의 대상을 명시

이렇게 구분하면 Clauder 개발과 사용자 템플릿이 명확히 분리되어 관리가 쉬워집니다.