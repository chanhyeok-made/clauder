---
doc_id: 5
---

## 핵심 규칙

### 역참조는 필수
```yaml
references:  # 이 문서를 참조하는 다른 문서들
  - file: "path/to/referencing-file.md"
    commit: "hash"
    status: "current|outdated"
```

### 역참조의 목적
1. **버전 추적**: 참조하는 문서의 버전 확인
2. **상태 검증**: 이 문서가 최신인지 판별
3. **연쇄 업데이트**: 변경 시 영향받는 문서 파악

## 실천 방법

### 문서 작성 시
1. **참조 추가 시**: 대상 문서의 references에 추가
2. **수정 시**: 역참조 문서들의 상태 확인
3. **삭제 시**: 모든 역참조 제거

### 상태 관리
```yaml
# 역참조하는 문서가 최신일 때
status: "current"

# 역참조하는 문서가 구버전일 때
status: "outdated"  # → 해당 문서 업데이트 필요!
```

## 자동화 지원
- `/clauder track check`: 역참조 상태 확인
- `/clauder track sync`: 역참조 동기화

## 예시
문서 A가 문서 B를 참조하면:
- A의 dependencies에 B 추가
- B의 references에 A 추가
- 양방향 관계 유지

## 관련 문서
- 참조 구조: @.claude/docs/principles/01-REFERENCE-STRUCTURE.md
- 중앙 레지스트리: @.claude/references.yaml
