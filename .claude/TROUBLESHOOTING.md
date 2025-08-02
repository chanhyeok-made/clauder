---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "87f8148"
  
dependencies:
  - file: ".claude/HOOKS.md"
    commit: "87f8148"
    status: "current"
  - file: ".claude/commands/clauder-hooks.md"
    commit: "87f8148"
    status: "current"
---

# Clauder 문제 해결 가이드

## 🚨 일반적인 문제와 해결 방법

### 1. Git 관련 오류

#### 문제: "Git 저장소가 아닙니다"
```
❌ Git 저장소가 아닙니다. 먼저 git init을 실행하세요.
```

**해결:**
```bash
git init
git add .
git commit -m "Initial commit"
```

#### 문제: "커밋 해시를 가져올 수 없음"
```
fatal: bad revision 'HEAD'
```

**해결:**
```bash
# 최소 하나의 커밋이 필요합니다
git add .
git commit -m "Initial commit"
```

### 2. 명령어 오류

#### 문제: "/clauder: command not found"
**원인:** @ 대신 /clauder를 타이핑

**해결:** Claude Code 내에서만 명령어 사용
```
# 올바른 사용
Claude Code에서: /clauder start

# 잘못된 사용
터미널에서: /clauder start  ❌
```

#### 문제: "명령어가 작동하지 않음"
**확인사항:**
1. `.claude/` 디렉토리가 있는지 확인
2. 프로젝트 루트에서 실행하는지 확인
3. Claude Code를 최신 버전으로 업데이트

### 3. 버전 추적 문제

#### 문제: "버전 메타데이터 없음"
```
⚠️ README.md - 버전 메타데이터 없음
```

**해결:**
```
/clauder track add README.md
```

#### 문제: "순환 참조 감지"
**해결:**
1. 순환 참조 확인: `/clauder track check all`
2. 문서 간 의존성 재검토
3. 단방향 참조로 수정

### 4. Hook 관련 문제

#### 문제: "Pre-commit hook이 실행되지 않음"
**확인:**
```bash
ls -la .git/hooks/pre-commit
```

**해결:**
```
/clauder hooks install
# 또는
.claude/hooks/install.sh
```

#### 문제: "Permission denied"
```
-bash: .git/hooks/pre-commit: Permission denied
```

**해결:**
```bash
chmod +x .git/hooks/pre-commit
```

### 5. 파일 수정 문제

#### 문제: "old_string을 찾을 수 없음"
**원인:** 정확한 문자열 매칭 실패

**해결:**
1. 파일을 먼저 읽어서 정확한 내용 확인
2. 들여쓰기와 공백 포함하여 정확히 복사
3. 더 큰 컨텍스트로 고유하게 만들기

### 6. 템플릿 문제

#### 문제: "템플릿 변수가 치환되지 않음"
```
프로젝트 이름: {{PROJECT_NAME}}  # 그대로 출력됨
```

**해결:**
1. `.claude/custom/project.yaml` 확인
2. 변수명이 정확한지 확인
3. `/clauder generate` 재실행

## 🔧 고급 문제 해결

### 디버깅 모드

#### 상세 로그 확인
```
# Git hooks 로그
cat /tmp/clauder-hook.log

# 버전 상태 상세 정보
/clauder track check all --verbose
```

### 수동 복구

#### 버전 메타데이터 수동 추가
```yaml
---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "$(git log -1 --format='%h')"
---
```

#### Hook 수동 제거
```bash
rm .git/hooks/pre-commit
mv .git/hooks/pre-commit.bak .git/hooks/pre-commit
```

### 초기화 문제

#### 완전 재설정
```bash
# 백업
cp -r .claude .claude.backup

# 제거
rm -rf .claude

# 재설치
git clone https://github.com/chanhyeok-made/clauder.git temp
cp -r temp/.claude .
rm -rf temp

# 재초기화
/clauder start
```

## 📊 상태 진단

### 종합 진단 명령
```
User: /clauder check --diagnose
Claude: 🔍 시스템 진단 중...

✅ Git: 정상 (commit: abc123d)
✅ 디렉토리 구조: 정상
⚠️ Hooks: pre-commit 미설치
✅ 버전 추적: 19/22 파일
❌ 템플릿: 2개 변수 미정의

권장 조치:
1. /clauder hooks install
2. /clauder track add [누락된 파일]
3. project.yaml에서 누락된 변수 정의
```

## 💡 예방 조치

### 정기 점검
```
# 매일
/clauder daily

# 주간
/clauder check --full

# 커밋 전
/clauder track check all
```

### 백업 전략
```bash
# 설정 백업
cp -r .claude/custom .claude/custom.backup

# 전체 백업
tar -czf clauder-backup-$(date +%Y%m%d).tar.gz .claude
```

## 🆘 추가 도움

### 로그 수집
문제 보고 시 다음 정보 포함:
```bash
# 시스템 정보
uname -a
git --version

# Clauder 상태
ls -la .claude/
git log --oneline -5

# 오류 메시지
# (전체 오류 메시지 복사)
```

### 지원 채널
- GitHub Issues: https://github.com/chanhyeok-made/clauder/issues
- 문서: `.claude/` 디렉토리 내 *.md 파일들

---

대부분의 문제는 Git 초기화, 올바른 디렉토리 위치, 권한 설정으로 해결됩니다.
문제가 지속되면 위의 진단 명령을 실행하여 상태를 확인하세요.