---
doc_id: 522
---

# 버전 트리 헬퍼 가이드

Claude Code가 문서 작업 시 참조해야 하는 버전 트리 작업 가이드입니다.

**중요**: 이 문서는 스크립트가 아닌 참조 가이드입니다. 
더 상세한 가이드는 @/.clauder-dev/tools/helpers/VERSION-TREE-GUIDE.md를 참조하세요.

## ID 할당 규칙
- 1-99: 핵심 원칙 문서
- 100-199: 명령어 문서  
- 200-299: 설계 문서
- 300-399: 가이드 문서
- 400-499: 템플릿 문서
- 500-599: 기타 문서
- 1000+: 프로젝트 루트 문서

## 작업 단계별 체크리스트

### ✅ 새 문서 생성 시
1. [ ] 적절한 ID 범위에서 다음 번호 선택
2. [ ] 파일에 doc_id 추가
3. [ ] version-tree.yaml의 documents에 추가
4. [ ] path_to_id 인덱스에 추가
5. [ ] total_documents +1
6. [ ] 다른 문서를 참조하면 depends_on 설정
7. [ ] 참조받는 문서의 referenced_by에 추가

### ✅ 문서 수정 시
1. [ ] 참조 추가 시:
   - [ ] 이 문서의 depends_on에 추가
   - [ ] 대상 문서의 referenced_by에 추가
2. [ ] 참조 제거 시:
   - [ ] 이 문서의 depends_on에서 제거
   - [ ] 대상 문서의 referenced_by에서 제거
3. [ ] 버전 트리에서 updated와 commit 업데이트

### ✅ 문서 삭제 시
1. [ ] 버전 트리에서 해당 엔트리 제거
2. [ ] path_to_id에서 제거
3. [ ] 다른 문서들의 depends_on에서 이 ID 제거
4. [ ] 다른 문서들의 referenced_by에서 이 ID 제거
5. [ ] total_documents -1

## 예시 코드

### 다음 사용 가능한 ID 찾기
```bash
# 명령어 문서의 다음 ID
grep -E "^  1[0-9]{2}:" .claude/version-tree.yaml | tail -1
# 결과가 112면 다음은 113

# 가이드 문서의 다음 ID  
grep -E "^  3[0-9]{2}:" .claude/version-tree.yaml | tail -1
# 결과가 307이면 다음은 308
```

### 참조 관계 확인
```bash
# 특정 문서를 참조하는 모든 문서 찾기
grep -B2 "referenced_by:.*510" .claude/version-tree.yaml

# 특정 문서가 참조하는 모든 문서 찾기
grep -A2 "depends_on:.*510" .claude/version-tree.yaml
```