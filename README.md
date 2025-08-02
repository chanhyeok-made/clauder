# Clauder - Claude Code 문서 템플릿 시스템

Claude Code를 위한 범용 문서 템플릿 시스템입니다. 모든 프로젝트에서 재사용 가능한 구조화된 문서화 프레임워크를 제공합니다.

## 📋 필수 요구사항

- **Git**: 버전 추적 시스템이 Git 커밋 해시를 기반으로 작동하므로 Git이 필수입니다.
- **Claude Code**: AI 어시스턴트와의 상호작용을 위해 필요합니다.

## 🚀 Quick Start

### 가장 빠른 방법: 한 줄 명령

```bash
# Claude Code에서:
/clauder start
```

이 명령 하나로 Git 확인, 프로젝트 분석, 필수 파일 생성이 모두 자동화됩니다.

### Case 1: 새 프로젝트와 함께 시작

```bash
# 1. 새 프로젝트 디렉토리 생성
mkdir my-new-project && cd my-new-project

# 2. Clauder 템플릿 가져오기
git clone https://github.com/chanhyeok-made/clauder.git temp
cp -r temp/.claude .
rm -rf temp

# 3. Git 초기화 (필수!)
git init
git add .
git commit -m "Initial commit with Clauder"
echo ".claude/custom/" >> .gitignore  # 커스텀 설정은 별도 관리

# 4. Claude에서 자동 초기화
# Claude Code를 열고:
/clauder start  # 모든 것을 자동으로!
```

### Case 2: 기존 프로젝트에 적용

```bash
# 1. 프로젝트 루트로 이동
cd /path/to/existing-project

# 2. 백업 (중요!)
cp CLAUDE.md CLAUDE.md.backup 2>/dev/null || true

# 3. Clauder 템플릿 가져오기
curl -L https://github.com/chanhyeok-made/clauder/archive/main.zip -o clauder.zip
unzip clauder.zip "clauder-main/.claude/*" -d .
mv clauder-main/.claude .
rm -rf clauder-main clauder.zip

# 4. Git 설정 확인 (필수!)
git add .
git commit -m "Add Clauder documentation system"

# 5. Claude Code에서 마이그레이션:
/clauder initialize --migrate
```

## 📋 상세 가이드

### 🆕 새 프로젝트 설정

1. **템플릿 복사 후 Claude에서 초기화**
   ```
   User: /clauder start
   Claude: 🚀 Clauder 초기화를 시작합니다...
   ```

2. **질문에 답변**
   - 프로젝트 이름
   - 주요 목적
   - 사용 언어/프레임워크

3. **자동 생성**
   - `.claude/custom/project.yaml`
   - `CLAUDE.md`

### 🔄 기존 프로젝트 마이그레이션

1. **기존 CLAUDE.md가 있는 경우**
   ```
   /clauder start --from-existing
   ```
   Claude가 기존 문서를 분석하여 정보 추출

2. **수동 마이그레이션**
   - 기존 내용을 `.claude/custom/overrides/`에 복사
   - 필요한 부분만 커스터마이징

3. **점진적 적용**
   ```
   # 단계별로 적용
   /clauder update project info      # 기본 정보만
   /clauder update project tech      # 기술 스택
   /clauder add context debugging    # 필요한 가이드 추가
   ```

## 📦 프로젝트 구조 및 CLAUDE.md 관리

### CLAUDE.md 처리 방식

#### 🔄 새로운 구조
- **CLAUDE.base.md**: Git에 포함되는 템플릿 파일
- **CLAUDE.md**: 실제 프로젝트에서 사용하는 파일 (.gitignore에 포함)

#### 🎯 장점
1. **Git 친화적**: CLAUDE.md는 .gitignore에 포함되어 프로젝트별 설정이 저장소에 노출되지 않음
2. **자기 참조 가능**: Clauder 프로젝트 자체도 CLAUDE.md를 사용하여 개발 가능
3. **커스터마이징 용이**: 각 프로젝트마다 CLAUDE.base.md를 기반으로 자유롭게 수정

#### 🔧 설정 방법
```bash
# 1. CLAUDE.base.md를 CLAUDE.md로 복사
cp CLAUDE.base.md CLAUDE.md

# 2. CLAUDE.md를 프로젝트에 맞게 수정
# (템플릿 변수들을 실제 값으로 대체)

# 3. .gitignore는 이미 CLAUDE.md를 포함하고 있음
```

## 🛠 사용 방법

### 기본 명령어
```
/clauder initialize       # 프로젝트 초기화
/clauder generate        # CLAUDE.md 재생성
/clauder check          # 문서 상태 확인
/clauder add context [name]  # 새 가이드 추가
/clauder track          # 버전 추적 관리
```

### 커스터마이징
1. **프로젝트 정보 수정**
   ```
   edit .claude/custom/project.yaml
   ```

2. **템플릿 오버라이드**
   ```
   cp .claude/templates/core/01-essentials.template.md \
      .claude/custom/overrides/01-essentials.md
   ```

3. **커스텀 가이드 추가**
   ```
   @add context deployment
   @add context troubleshooting
   ```

## 📁 디렉토리 구조

```
your-project/
├── .claude/
│   ├── templates/        # 건드리지 마세요 (업데이트 가능)
│   ├── custom/          # 여기서 커스터마이징
│   │   ├── project.yaml # 프로젝트 설정
│   │   ├── overrides/   # 템플릿 오버라이드
│   │   └── contexts/    # 추가 가이드
│   └── *.md            # 시스템 문서
├── CLAUDE.base.md      # 템플릿 파일 (Git에 포함)
└── CLAUDE.md           # 실제 사용 파일 (gitignore)
```

## 📚 문서

- **실제 사용 예제**: [EXAMPLES.md](EXAMPLES.md)
- **문제 해결 가이드**: [.claude/docs/guides/TROUBLESHOOTING.md](.claude/docs/guides/TROUBLESHOOTING.md)
- **훅 시스템**: [.claude/docs/design/HOOKS.md](.claude/docs/design/HOOKS.md)
- **워크플로우**: [.claude/docs/guides/WORKFLOWS.md](.claude/docs/guides/WORKFLOWS.md)
- **전체 문서**: [.claude/docs/](.claude/docs/)

## 🪝 훅 기반 자동화

### 훅 설치
```bash
# Git hooks 자동 설치
/clauder hooks install
```

### 자동화되는 작업
1. **문서 편집 시**: 버전 자동 업데이트
2. **Git 커밋 시**: 메타데이터 동기화
3. **Claude 작업 시**: 지시사항 자동 적용

자세한 내용:
- 훅 설계: `.claude/docs/design/HOOKS.md`
- Claude 지시사항: `.claude/instructions.md`

## 💡 팁

### Git 관리
```bash
# .gitignore 권장 설정
.claude/custom/project.yaml    # 민감 정보 포함 가능
.claude/.generated/            # 생성된 파일
CLAUDE.md                      # 자동 생성되므로

# 템플릿은 서브모듈로 관리 가능
git submodule add https://github.com/chanhyeok-made/clauder.git .claude-template
```

### 팀 협업
1. **템플릿 공유**: `.claude/templates/`는 모든 팀원 동일
2. **프로젝트 설정**: `.claude/custom/project.yaml`은 공유
3. **개인 설정**: `.claude/custom/personal/` 사용 (gitignore)

### 업데이트
```bash
# 최신 템플릿 가져오기
cd .claude/templates
git pull origin main
```

## 🤝 기여

문제점이나 개선사항이 있다면:
- [이슈 생성](https://github.com/chanhyeok-made/clauder/issues)
- [PR 제출](https://github.com/chanhyeok-made/clauder/pulls)

## 📄 라이선스

MIT License - 자유롭게 사용하세요!