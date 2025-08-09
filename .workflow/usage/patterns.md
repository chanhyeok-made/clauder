---
doc_id: 805
---

# 자동화 패턴

## 기본 패턴

### 문서 편집 자동화
```python
if tool == "Edit" and file.ends_with(".md"):
    before_edit_hook(file)
    # 실제 편집
    after_edit_hook(file)
```

### 참조 추가 자동화
```python
if "@" in content and ".md" in content:
    validate_reference(referenced_file)
    add_bidirectional_reference()
```

### 버전 확인 자동화
```python
if "version:" not in file_content:
    suggest_add_version_metadata()
```

## 고급 패턴

### 프로젝트 패턴 학습
```
AFTER 각 세션:
- RECORD: 사용된 문서
- UPDATE: .claude/custom/patterns.yaml
- OPTIMIZE: 다음 세션 위해 학습
```

### 컨텍스트 압축
```
IF 파일 크기 > 2000 토큰:
- USE: context-compressor.py
- APPLY: 메타데이터 압축
- APPLY: 별칭 변환
- TRUNCATE: 긴 코드 블록
```

## 명령어

- `git log -1 --format="%h"` - 현재 커밋 해시
- `date -u +"%Y-%m-%d"` - 현재 날짜 (ISO 형식)
- `/clauder track check` - 버전 상태 확인