---
doc_id: 760
created: 2025-08-04
category: error-pattern
severity: critical
---

# 버전 트리 'current' 커밋 안티패턴

## 🚨 문제
버전 트리에 실제 커밋 해시 대신 'current'를 입력

## ❌ 잘못된 예
```yaml
commit: "current"  # 절대 금지!
```

## ✅ 올바른 예
```yaml
commit: "2aa05c6"  # 실제 커밋 해시
```

## 📋 올바른 프로세스
1. 파일 생성/수정
2. `git add .`
3. `git commit -m "..."`
4. `git log -1 --format="%h"` 로 커밋 해시 확인
5. 버전 트리에 실제 해시 입력

## 🛡️ 예방 조치
1. 커밋 전에는 버전 트리 업데이트 금지
2. 커밋 후 즉시 해시 확인하여 입력
3. check-documentation.sh 스크립트에 검증 로직 추가

## 💡 교훈
- 버전 트리의 commit 필드는 **불변의 역사 기록**
- 'current', 'latest', 'HEAD' 등 상대적 참조 금지
- 항상 실제 커밋 해시 사용