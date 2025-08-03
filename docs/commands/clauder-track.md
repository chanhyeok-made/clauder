---
doc_id: 110
---

문서 버전 추적 관리

## 고유 기능
```
track add <file>      # 버전 메타데이터 추가
track update <file>   # 버전 업데이트
track check [file]    # 상태 확인
track sync            # 전체 동기화
```

## 핵심 동작
- Git 커밋 해시 자동 기록
- 의존성 추적
- 참조 일관성 유지

## 예시
```
/clauder track check
→ 5개 파일 오래됨
→ 2개 참조 깨짐

/clauder track sync
→ 모든 버전 동기화 완료
```

@TODO-ALIAS
