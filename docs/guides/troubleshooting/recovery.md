---
doc_id: 830
---

# 복구 전략

## 백업에서 복구

### 전체 복구
```bash
# 기존 설정 제거
rm -rf .claude

# 백업 복원
tar -xzf clauder-backup-20250804.tar.gz
```

### 부분 복구
```bash
# 특정 파일만
cp .claude.backup/custom/project.yaml .claude/custom/

# 커스텀 설정만
cp -r .claude.backup/custom/* .claude/custom/
```

## 버전 충돌 해결

### 템플릿 버전 충돌
1. 커스텀 설정 백업
2. 새 템플릿 설치
3. 커스텀 설정 재적용

### 설정 파일 충돌
- 수동 머지
- 차이점 확인
- 필요한 부분만 선택

## 상태 확인

### 복구 후 검증
```
/clauder check --full
```

### 참조 무결성
```
/clauder track check all
```

### 템플릿 확인
```
/clauder generate --dry-run
```

## 비상 복구

### 최소 구성
1. `.claude/templates/` - 기본 템플릿
2. `.claude/custom/project.yaml` - 프로젝트 설정
3. `CLAUDE.md` - 재생성 가능