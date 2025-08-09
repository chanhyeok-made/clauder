---
doc_id: 820
---

# Git 관련 문제

## "Git 저장소가 아닙니다"

### 증상
```
❌ Git 저장소가 아닙니다. 먼저 git init을 실행하세요.
```

### 해결
```bash
git init
git add .
git commit -m "Initial commit"
```

## "커밋 해시를 가져올 수 없음"

### 증상
```
fatal: bad revision 'HEAD'
```

### 원인
저장소에 커밋이 하나도 없음

### 해결
```bash
# 최소 하나의 커밋이 필요합니다
git add .
git commit -m "Initial commit"
```

## 기타 Git 문제

### 브랜치 확인
```bash
git branch
git status
```

### 원격 저장소 연결
```bash
git remote -v
git remote add origin [URL]
```