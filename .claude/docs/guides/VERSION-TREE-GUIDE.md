---
doc_id: 308
---

# 버전 트리 가이드

모든 문서 작업은 이 가이드를 따라 버전 트리를 업데이트합니다.

## 📋 작업별 가이드

### 새 문서 생성 시

1. **ID 할당 규칙 확인**
   ```
   1-99: 원칙 문서
   100-199: 명령어 문서  
   200-299: 설계 문서
   300-399: 가이드 문서
   400-499: 템플릿 문서
   500-599: 기타 문서
   1000+: 루트 문서
   ```

2. **다음 사용 가능한 ID 찾기**
   - 버전 트리에서 해당 범위의 마지막 ID 확인
   - 예: 마지막 가이드가 307이면 다음은 308

3. **템플릿 사용**
   - @.claude/templates/version-tree-entry.template.md 참조
   - 변수 치환:
     - {{DOC_ID}}: 할당한 ID
     - {{FILE_PATH}}: 파일 경로 (/ 시작)
     - {{TODAY_DATE}}: YYYY-MM-DD
     - {{CURRENT_COMMIT}}: git log -1 --format="%h"
     - {{DEPENDENCIES}}: 참조하는 문서들의 ID

### 기존 문서 수정 시

1. **참조 추가**
   - 이 문서가 다른 문서를 참조하면:
     - 이 문서의 depends_on에 추가
     - 대상 문서의 referenced_by에 이 문서 ID 추가

2. **참조 제거**
   - 참조를 제거하면:
     - 이 문서의 depends_on에서 제거
     - 대상 문서의 referenced_by에서 이 문서 ID 제거

3. **버전 업데이트**
   - updated: 오늘 날짜로
   - commit: 현재 커밋 해시로

### 문서 삭제 시

1. **버전 트리에서 제거**
   - documents 섹션에서 엔트리 삭제
   - path_to_id에서 제거
   - total_documents -1

2. **참조 정리**
   - 다른 문서들의 depends_on에서 이 ID 제거
   - 다른 문서들의 referenced_by에서 이 ID 제거

## 🔍 빠른 참조

### 현재 상태 확인
```
# 특정 ID의 정보 보기
버전 트리에서 "ID:" 검색

# 특정 파일의 ID 찾기
path_to_id에서 파일 경로 검색

# ID를 참조하는 문서 찾기
"referenced_by:.*ID" 패턴 검색
```

### 일관성 검증
- 모든 depends_on의 ID가 실제로 존재하는가?
- 양방향 참조가 일치하는가?
- total_documents가 실제 개수와 일치하는가?

## 📝 예시

### 새 가이드 문서 추가
```yaml
# 1. 파일에 추가
---
doc_id: 309
---

# 2. documents에 추가
  309:
    path: "/.claude/docs/guides/NEW-GUIDE.md"
    created: "2025-08-03"
    updated: "2025-08-03"
    commit: "abc123"
    depends_on: [1, 5]  # 원칙 1, 5 참조
    referenced_by: []

# 3. path_to_id에 추가
  "/.claude/docs/guides/NEW-GUIDE.md": 309

# 4. 원칙 1, 5의 referenced_by에 309 추가
```

## 관련 문서
- 템플릿: @.claude/templates/version-tree-entry.template.md
- 버전 트리: @.claude/version-tree.yaml
- 설계 문서: @.claude/docs/design/VERSION-TREE.md