---
doc_id: 829
---

# 백업 전략

## 설정 백업

### 커스텀 설정
```bash
# 단순 백업
cp -r .claude/custom .claude/custom.backup

# 타임스탬프 백업
cp -r .claude/custom .claude/custom.backup-$(date +%Y%m%d)
```

### 전체 시스템
```bash
# 압축 백업
tar -czf clauder-backup-$(date +%Y%m%d).tar.gz .claude

# 특정 파일 제외
tar -czf clauder-backup.tar.gz \
  --exclude='.claude/.logs' \
  --exclude='.claude/.generated' \
  .claude
```

## 자동 백업

### Git 훅 활용
```bash
# .git/hooks/pre-commit에 추가
cp -r .claude/custom .claude/.backup/custom-$(date +%Y%m%d-%H%M%S)
```

### 크론 작업
```bash
# crontab -e
0 3 * * * tar -czf ~/backup/clauder-$(date +\%Y\%m\%d).tar.gz /path/to/.claude
```

## 백업 관리

### 오래된 백업 삭제
```bash
# 30일 이상 된 백업 삭제
find .claude/.backup -mtime +30 -delete
```

### 백업 목록
```bash
ls -la .claude/.backup/
```