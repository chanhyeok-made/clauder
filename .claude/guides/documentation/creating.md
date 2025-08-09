---
doc_id: 802
---

# 문서 생성 지시사항

## 새 파일 생성 시

```
WHEN Write 도구로 .md 파일 생성:
1. FIRST: @/.clauder-dev/tools/helpers/VERSION-TREE-GUIDE.md 참조
2. THEN: @.claude/templates/version-tree-entry.template.md 사용
3. MUST: 파일에 doc_id 추가 (3줄만)
4. MUST: 버전 트리에 완전한 엔트리 추가
5. MUST: path_to_id 인덱스 업데이트
6. CHECK: 참조 관계 양방향 설정
```

## 버전 트리 업데이트

```
AFTER 새 .md 파일 생성:
1. 파일에 doc_id 추가:
   ---
   doc_id: [다음 사용 가능한 ID]
   ---
   
2. .claude/version-tree.yaml 업데이트:
   - documents 섹션에 새 엔트리 추가
   - path_to_id 인덱스에 추가
   - total_documents 증가
   - metadata의 last_update 업데이트
   - metadata의 last_commit: 실제 커밋 해시 (절대 'current' 금지!)
```

## ALERT: 버전 트리 commit 필드 규칙

```
CRITICAL: commit 필드 작성 규칙
- DONE: 올바른 예: commit: "a1b2c3d"  # 실제 커밋 해시
- FORBIDDEN: 절대 금지: commit: "current"   # 상대 참조 금지!
- FORBIDDEN: 절대 금지: commit: "latest"    # 상대 참조 금지!
- FORBIDDEN: 절대 금지: commit: "HEAD"      # 상대 참조 금지!

올바른 순서:
1. 파일 생성/수정
2. git add && git commit
3. git log -1 --format="%h" 로 해시 확인
4. 확인된 해시를 commit 필드에 입력
```

## 기존 파일 수정 시

```
AFTER 기존 파일 수정:
1. 참조 추가/제거 시:
   - 참조하는 파일의 depends_on 업데이트
   - 참조받는 파일의 referenced_by 업데이트
2. 버전 트리에서 해당 문서의 updated와 commit 업데이트
   - commit: 반드시 실제 커밋 해시 사용
```

## 파일 삭제 시

```
AFTER 파일 삭제:
- 버전 트리에서 해당 엔트리 제거
- 다른 문서들의 depends_on/referenced_by에서 제거
- total_documents 감소
```