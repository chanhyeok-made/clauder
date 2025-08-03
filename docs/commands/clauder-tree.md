---
doc_id: 113
---

# /clauder tree

## 설명
버전 트리 관리 명령어. 문서의 버전과 참조 관계를 중앙에서 관리합니다.

## 사용법
```
/clauder tree [subcommand] [options]
```

## 하위 명령어

### `add`
새 문서를 버전 트리에 추가
```
/clauder tree add <file_path>
```

### `update`
기존 문서의 정보 업데이트
```
/clauder tree update <doc_id>
```

### `remove`
문서를 버전 트리에서 제거
```
/clauder tree remove <doc_id>
```

### `check`
버전 트리 일관성 검사
```
/clauder tree check
```

### `show`
특정 문서의 트리 정보 표시
```
/clauder tree show <doc_id>
```

## 구현 가이드 (문서 기반)

이 명령어를 실행할 때 Claude는 문서를 참조하여 작업합니다:

1. **add**: 
   - @/.clauder-dev/tools/helpers/VERSION-TREE-GUIDE.md의 "새 문서 생성 시" 섹션 따르기
   - @.claude/templates/version-tree-entry.template.md 템플릿 사용
   - 수동으로 버전 트리 편집

2. **update**:
   - VERSION-TREE-GUIDE.md의 "기존 문서 수정 시" 섹션 따르기
   - git log -1 --format="%h"로 커밋 해시 확인
   - date 명령으로 현재 날짜 확인

3. **check**:
   - VERSION-TREE-GUIDE.md의 "일관성 검증" 섹션 따르기
   - 수동으로 각 항목 확인
   - 불일치 발견 시 보고

4. **show**:
   - 버전 트리에서 해당 ID 검색
   - 관련 정보 표시

**중요**: 모든 작업은 스크립트 실행이 아닌 문서 참조와 수동 편집으로 수행됩니다.

## 관련 파일
- 버전 트리: @.claude/version-tree.yaml
- 헬퍼 가이드: @/.clauder-dev/tools/helpers/version-tree-helper.md
- 관리 스크립트: @.clauder-dev/tools/scripts/version-tree-manager.py