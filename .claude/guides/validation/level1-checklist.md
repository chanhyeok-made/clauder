---
doc_id: 857
---

# Level 1: 경량 검증 체크리스트

> 1-2분 내 완료 가능한 빠른 체크

## 필수 확인 (30초)
- [ ] 새 파일에 doc_id 있나?
- [ ] 테스트 있다면 통과하나?
- [ ] 커밋 메시지 형식 맞나? (type: description)

## 선택 확인 (추가 1분)
- [ ] 관련 문서 업데이트 필요한가?
- [ ] 큰 변경이면 Level 2 검증 필요한가?

## 자동화 가능
```bash
# 빠른 체크 스크립트
git status --porcelain | grep "^A.*\.md$" | while read file; do
    echo "Checking $file for doc_id..."
    grep -q "^doc_id:" "$file" || echo "⚠️  Missing doc_id!"
done
```

끝! 이 정도면 충분합니다.