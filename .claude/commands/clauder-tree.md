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

## 구현 가이드

이 명령어를 실행할 때 Claude는:

1. **add**: 
   - 파일 타입에 따라 적절한 ID 범위 선택
   - 파일에 doc_id 추가
   - 버전 트리 업데이트

2. **update**:
   - 현재 commit hash 가져오기
   - updated 날짜 갱신
   - 참조 관계 동기화

3. **check**:
   - 모든 참조가 유효한지 확인
   - 양방향 참조 일치 확인
   - 누락된 파일 감지

## 관련 파일
- 버전 트리: @.claude/version-tree.yaml
- 헬퍼 가이드: @.claude/scripts/version-tree-helper.md
- 관리 스크립트: @.claude/scripts/version-tree-manager.py