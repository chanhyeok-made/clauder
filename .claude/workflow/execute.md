---
doc_id: 2003
executable: true
---

# 워크플로우 실행 명령

## #analyze - 분석 단계
```execute
1. TodoWrite([
   {"content": "요구사항 정의", "status": "pending", "id": "analyze_1"},
   {"content": "영향 범위 파악", "status": "pending", "id": "analyze_2"},
   {"content": "리스크 평가", "status": "pending", "id": "analyze_3"}
])

2. 관련 파일 검색
   - Grep 도구 사용
   - 패턴 매칭

3. 상태 업데이트
   - current.md 수정
   - CURRENT_STAGE="ANALYSIS"
```

## #implement - 구현 단계
```execute
1. TodoWrite([
   {"content": "코드 작성", "status": "pending", "id": "impl_1"},
   {"content": "테스트 작성", "status": "pending", "id": "impl_2"},
   {"content": "통합 테스트", "status": "pending", "id": "impl_3"}
])

2. 코드 작성
   - Edit/Write 도구 사용
   - 기존 패턴 참조

3. 상태 업데이트
   - CURRENT_STAGE="IMPLEMENTATION"
```

## #review - 검토 단계
```execute
1. TodoWrite([
   {"content": "코드 리뷰", "status": "pending", "id": "review_1"},
   {"content": "테스트 실행", "status": "pending", "id": "review_2"},
   {"content": "버그 수정", "status": "pending", "id": "review_3"}
])

2. 검증 실행
   - validate.sh 실행
   - 테스트 실행

3. 상태 업데이트
   - CURRENT_STAGE="REVIEW"
```

## #document - 문서화 단계
```execute
1. TodoWrite([
   {"content": "변경사항 기록", "status": "pending", "id": "doc_1"},
   {"content": "패턴 추출", "status": "pending", "id": "doc_2"},
   {"content": "학습 내용 저장", "status": "pending", "id": "doc_3"}
])

2. 문서 업데이트
   - patterns.md 업데이트
   - errors.md 업데이트

3. 상태 업데이트
   - CURRENT_STAGE="DOCUMENTATION"
```

## #commit - 커밋 단계
```execute
1. TodoWrite([
   {"content": "Git 커밋", "status": "pending", "id": "commit_1"},
   {"content": "GitHub 푸시", "status": "pending", "id": "commit_2"},
   {"content": "상태 정리", "status": "pending", "id": "commit_3"}
])

2. Git 작업
   - git add .
   - git commit -m "type: description"
   - git push

3. 상태 초기화
   - CURRENT_STAGE="NONE"
   - TODO 정리
```