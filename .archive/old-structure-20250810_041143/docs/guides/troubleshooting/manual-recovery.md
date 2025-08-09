---
doc_id: 827
---

# 수동 복구

## 버전 메타데이터 수동 추가

### 기본 형식
```yaml
---
doc_id: 999
---
```

### 전체 형식
```yaml
---
version:
  created: "2025-08-04"
  updated: "2025-08-04"
  commit: "$(git log -1 --format='%h')"
dependencies:
  - file: "path/to/dependency.md"
    commit: "abc123d"
references:
  - file: "path/to/referencing.md"
    commit: "def456e"
---
```

## Hook 수동 관리

### Hook 제거
```bash
rm .git/hooks/pre-commit
```

### 백업 복원
```bash
mv .git/hooks/pre-commit.bak .git/hooks/pre-commit
```

### 권한 설정
```bash
chmod +x .git/hooks/pre-commit
```

## 버전 트리 수동 편집

### 위치
`.claude/version-tree.yaml`

### 주의사항
- 중복 ID 확인
- path_to_id 인덱스 동기화
- total_documents 업데이트