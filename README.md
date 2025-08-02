# Clauder - Claude Code 문서 템플릿 시스템

Claude Code를 위한 범용 문서 템플릿 시스템입니다. 모든 프로젝트에서 재사용 가능한 구조화된 문서화 프레임워크를 제공합니다.

## 🚀 Quick Start

### Case 1: 새 프로젝트와 함께 시작

```bash
# 1. 새 프로젝트 디렉토리 생성
mkdir my-new-project && cd my-new-project

# 2. Clauder 템플릿 가져오기
git clone https://github.com/chanhyeok-made/clauder.git temp
cp -r temp/.claude .
rm -rf temp

# 3. Git 초기화 (선택사항)
git init
echo ".claude/custom/" >> .gitignore  # 커스텀 설정은 별도 관리

# 4. Claude에서 초기화
# Claude Code를 열고 다음 명령 실행:
@initialize project
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

# 4. 기존 설정 마이그레이션
# Claude Code에서:
@initialize project --migrate
```

## 📋 상세 가이드

### 🆕 새 프로젝트 설정

1. **템플릿 복사 후 Claude에서 초기화**
   ```
   User: @initialize project
   Claude: 프로젝트 초기화를 시작합니다...
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
   @initialize project --migrate
   ```
   Claude가 기존 문서를 분석하여 정보 추출

2. **수동 마이그레이션**
   - 기존 내용을 `.claude/custom/overrides/`에 복사
   - 필요한 부분만 커스터마이징

3. **점진적 적용**
   ```
   # 단계별로 적용
   @update project info      # 기본 정보만
   @update project tech      # 기술 스택
   @add context debugging    # 필요한 가이드 추가
   ```

## 🛠 사용 방법

### 기본 명령어
```
@initialize project       # 프로젝트 초기화
@generate claude.md      # CLAUDE.md 재생성
@check documentation     # 문서 상태 확인
@add context [name]      # 새 가이드 추가
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
└── CLAUDE.md           # 자동 생성됨
```

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