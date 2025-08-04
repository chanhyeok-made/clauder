---
doc_id: 821
---

# 명령어 오류

## "/clauder: command not found"

### 원인
@ 대신 /clauder를 터미널에서 타이핑

### 해결
Claude Code 내에서만 명령어 사용

```
# ✅ 올바른 사용
Claude Code에서: /clauder start

# ❌ 잘못된 사용
터미널에서: /clauder start
```

## "명령어가 작동하지 않음"

### 확인사항

1. **디렉토리 확인**
   ```bash
   ls -la .claude/
   ```

2. **프로젝트 루트에서 실행**
   ```bash
   pwd  # 현재 위치 확인
   ```

3. **Claude Code 버전**
   - 최신 버전으로 업데이트
   - 재시작 후 시도

## 명령어 도움말

```
/clauder --help
/clauder [command] --help
```