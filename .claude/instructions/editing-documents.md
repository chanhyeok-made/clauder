---
doc_id: 801
---

# 문서 편집 지시사항

## 편집 전 확인

```
BEFORE Edit 도구 사용:
- IF 파일이 .md 확장자 THEN
  - 버전 메타데이터 확인
  - 없으면 추가 제안
```

## 편집 후 처리

```
AFTER Edit 도구 사용:
- IF 편집한 파일이 .md THEN
  - updated 날짜 변경
  - commit 해시 업데이트 (git log -1 --format="%h")
  - 참조 확인
```

## 참조 추가 시

```python
if "@" in content and ".md" in content:
    validate_reference(referenced_file)
    add_bidirectional_reference()
```

## 체크리스트

- [ ] 파일 타입 확인
- [ ] 버전 메타데이터 존재 확인
- [ ] 메타데이터 업데이트
- [ ] 참조 일관성 확인
- [ ] 양방향 참조 설정