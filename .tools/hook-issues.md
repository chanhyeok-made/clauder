---
doc_id: 823
---

# Hook 관련 문제

## "Pre-commit hook이 실행되지 않음"

### 확인
```bash
ls -la .git/hooks/pre-commit
```

### 해결
```
/clauder hooks install
```

### 수동 설치
```bash
.claude/hooks/install.sh
```

## "Permission denied"

### 증상
```
-bash: .git/hooks/pre-commit: Permission denied
```

### 해결
```bash
chmod +x .git/hooks/pre-commit
```

## Hook 수동 제거

### 임시 비활성화
```bash
git commit --no-verify
```

### 완전 제거
```bash
rm .git/hooks/pre-commit
```

### 백업 복원
```bash
mv .git/hooks/pre-commit.bak .git/hooks/pre-commit
```

## Hook 로그 확인

```bash
# Hook 실행 로그
cat /tmp/clauder-hook.log

# 오류 확인
tail -f /tmp/clauder-hook-error.log
```