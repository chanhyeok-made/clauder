---
doc_id: 3003
executable: true
---

# 패턴 적용 방법

## #execute - 해결책 실행
```execute
1. 에러 타입 확인
2. errors.md에서 검색
3. 해결책 적용
4. 결과 기록
```

## #record - 새 패턴 기록
```execute
1. 패턴 타입 결정 (성공/실패)
2. patterns.md 업데이트
3. 재사용 가능하게 문서화
```

## #solution - 자동 해결
```execute
# Git 에러 자동 해결
if [error contains "HTTP 400"]; then
  git config http.postBuffer 524288000
  git push
fi

# 참조 에러 자동 수정
if [error contains "broken reference"]; then
  .claude/tools/fix-references.sh
fi

# 타입 에러 자동 수정
if [error contains "TS2339"]; then
  # 인터페이스 자동 생성
  generate_interface()
fi
```

## 적용 우선순위
1. **즉시 적용**: 알려진 에러
2. **분석 후 적용**: 유사 패턴
3. **새로 학습**: 처음 보는 에러

## 학습 사이클
```
에러 발생 → 해결 시도 → 성공/실패 기록 → 패턴화 → 재사용
```