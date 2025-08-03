---
doc_id: 731
---

# 문서 컨벤션 및 파일 정리 점검 보고서

## 1. 문서 컨벤션 일관성

### ✅ 잘 지켜지고 있는 것
- 대부분의 문서가 doc_id를 포함 (98% 준수)
- README.md 파일명 일관성 유지
- 디렉토리별 README.md 존재

### ❌ 개선 필요
1. **doc_id 누락**
   - `.claude/templates/version-tree-entry.template.md` - 템플릿이라 불필요할 수 있음

2. **대소문자 불일치**
   - guides 디렉토리: `WORKFLOWS.md`, `TROUBLESHOOTING.md`, `CAPABILITIES.md` (대문자)
   - 나머지: `adding-contexts.md`, `best-practices.md` (소문자)
   - 권장: 모두 소문자로 통일

## 2. 불필요한 파일 목록

### 임시 파일 (삭제 필요)
```
.clauder-dev/temp/temp-check-tree-files-20250803.sh
.clauder-dev/temp/temp-fix-remaining-refs-20250803.sh
```

### 완료된 마이그레이션 스크립트 (보관 검토)
```
.clauder-dev/tools/scripts/migrate-to-docid.py
.clauder-dev/tools/scripts/batch-migrate-docid.sh
.clauder-dev/tools/scripts/fix-references.sh
```
→ 로그로 이동 권장

### 사용하지 않는 스크립트
- `reference-parser.py` - Python yaml 모듈 필요
- `tree-sync.py` - Python yaml 모듈 필요
- `version-tree-manager.py` - Python yaml 모듈 필요
→ bash 버전으로 대체하거나 삭제

## 3. 버전 트리 정리

### 문서가 아닌 항목들 (제거 필요)
- 501: config.yaml
- 503: version-tree.yaml
- 504: version-tree-manager.py
- 505: tree-sync.py
- 521: generate-tree-entries.sh
- 529: update-version-tree.sh
- 708: REGISTRY.yaml

## 4. 권장 조치

### 즉시 실행
1. 임시 파일 삭제
2. 완료된 마이그레이션 스크립트를 로그로 이동
3. 버전 트리에서 non-md 파일 제거

### 점진적 개선
1. guides 디렉토리 파일명을 소문자로 통일
2. Python 스크립트를 bash로 재작성 또는 삭제
3. 템플릿 파일의 doc_id 필요성 검토

## 5. 파일 구조 개선안

```
.clauder-dev/
├── temp/              # 정기적으로 비우기
├── logs/              
│   └── migrations/    # 완료된 스크립트 보관
├── tools/
│   ├── scripts/       # 활성 스크립트만
│   └── archived/      # 사용 안 하는 스크립트
```