---
doc_id: 804
---

# 훅 동작 지시사항

## 프로젝트 시작 시

```
WHEN 사용자가 처음 질문:
- CHECK: .claude/ 디렉토리 존재
- IF Git 저장소 THEN
  - 현재 commit 해시 확인
  - 문서 버전 상태 간단히 확인
```

## 자동 실행 패턴

### 패턴 1: 문서 편집
```python
if tool == "Edit" and file.ends_with(".md"):
    before_edit_hook(file)
    # 실제 편집
    after_edit_hook(file)
```

### 패턴 2: 참조 추가
```python
if "@" in content and ".md" in content:
    validate_reference(referenced_file)
    add_bidirectional_reference()
```

### 패턴 3: 버전 확인
```python
if "version:" not in file_content:
    suggest_add_version_metadata()
```

## 훅 타입

1. **before-edit**: 파일 타입 확인, 메타데이터 검증
2. **after-edit**: 버전 업데이트, 참조 확인
3. **pre-commit**: 버전 동기화, 일관성 검증
4. **post-commit**: 새 해시 기록, 관련 문서 제안