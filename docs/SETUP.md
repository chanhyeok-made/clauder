# 🚀 Clauder 설치 가이드

## 방법 1: Git Clone (권장)

### 새 프로젝트
```bash
# 프로젝트와 함께 시작
mkdir my-project && cd my-project
git clone https://github.com/chanhyeok-made/clauder.git .claude-temp
mv .claude-temp/.claude .
rm -rf .claude-temp

# Claude에서
@initialize project
```

### 기존 프로젝트
```bash
# 프로젝트 루트에서
git clone https://github.com/chanhyeok-made/clauder.git .claude-temp
cp -r .claude-temp/.claude .
rm -rf .claude-temp

# 기존 CLAUDE.md 백업
mv CLAUDE.md CLAUDE.md.backup 2>/dev/null || true

# Claude에서
@initialize project --migrate
```

## 방법 2: 직접 다운로드

### macOS/Linux
```bash
# 템플릿 다운로드 및 설치 스크립트
curl -fsSL https://raw.githubusercontent.com/chanhyeok-made/clauder/main/install.sh | bash
```

### Windows
```powershell
# PowerShell에서
Invoke-WebRequest -Uri "https://github.com/chanhyeok-made/clauder/archive/main.zip" -OutFile "clauder.zip"
Expand-Archive -Path "clauder.zip" -DestinationPath "."
Move-Item -Path "clauder-main\.claude" -Destination "."
Remove-Item -Path "clauder-main" -Recurse
Remove-Item -Path "clauder.zip"
```

## 방법 3: Git Submodule (고급)

### 템플릿을 서브모듈로 관리
```bash
# 프로젝트 루트에서
git submodule add https://github.com/chanhyeok-made/clauder.git .clauder
ln -s .clauder/.claude .claude

# 업데이트가 필요할 때
git submodule update --remote
```

## 방법 4: NPM/Yarn (계획 중)

```bash
# 향후 지원 예정
npm install -g clauder
clauder init

# 또는
npx clauder init
```

## 🔧 설치 후 설정

### 1. 기본 초기화
```
Claude Code를 열고:
@initialize project quick
```

### 2. 전체 초기화
```
@initialize project full
```

### 3. 기존 프로젝트 마이그레이션
```
@initialize project --migrate
```

## ❓ 문제 해결

### 권한 오류
```bash
# macOS/Linux
chmod -R 755 .claude
```

### 기존 파일 충돌
```bash
# 백업 후 재시도
mv .claude .claude.backup
# 다시 설치
```

### Claude가 명령을 인식하지 못할 때
1. CLAUDE.md 파일이 프로젝트 루트에 있는지 확인
2. `.claude/INITIALIZE.md` 파일이 있는지 확인
3. Claude Code를 재시작

## 📝 설치 확인

성공적으로 설치되었는지 확인:
```
Claude Code에서:
@check documentation
```

정상 응답:
```
✓ 템플릿 시스템이 설치되었습니다
✓ 초기화 준비가 완료되었습니다
○ project.yaml 설정이 필요합니다
```