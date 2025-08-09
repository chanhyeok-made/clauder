# 버전 트리 엔트리 템플릿

새 문서를 버전 트리에 추가할 때 사용하는 템플릿입니다.

## 1. 파일에 추가할 내용
```yaml
---
doc_id: {{DOC_ID}}
---
```

## 2. 버전 트리에 추가할 엔트리
```yaml
  {{DOC_ID}}:
    path: "{{FILE_PATH}}"
    created: "{{TODAY_DATE}}"
    updated: "{{TODAY_DATE}}"
    commit: "{{CURRENT_COMMIT}}"
    depends_on: [{{DEPENDENCIES}}]
    referenced_by: []
```

## 3. path_to_id 인덱스에 추가
```yaml
  "{{FILE_PATH}}": {{DOC_ID}}
```

## 4. 체크리스트
- [ ] 적절한 ID 범위 선택 (원칙: 1-99, 명령어: 100-199, 설계: 200-299...)
- [ ] 파일에 doc_id 추가
- [ ] documents 섹션에 엔트리 추가
- [ ] path_to_id에 추가
- [ ] total_documents +1
- [ ] 참조하는 문서들의 ID를 depends_on에 추가
- [ ] 참조받는 문서들의 referenced_by에 이 ID 추가