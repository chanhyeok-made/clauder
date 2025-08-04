---
doc_id: 861
---

# 검증 레벨 사용 가이드

## 언제 어떤 레벨을?

### Level 0: 자동 (매번)
- Git hooks로 자동 실행
- 파일 저장 시 자동 실행
- 걱정할 필요 없음

### Level 1: 경량 (작업 후)
```bash
# 작업 완료 후 실행
./.clauder-dev/tools/scripts/check-level1.sh
```
- 작은 수정 후
- 일반적인 작업 후
- 커밋 전 기본 체크

### Level 2: 표준 (중요 작업 후)
```bash
# 중요한 변경 후 실행
./.clauder-dev/tools/scripts/check-documentation.sh
```
- 새 문서 추가
- 구조 변경
- 여러 파일 수정

### Level 3: 심층 (주기적)
- 주 1회 또는 월 1회
- 대규모 리팩토링 후
- 릴리즈 전

## 실용적 접근

1. **일상 작업**: Level 1만으로 충분
2. **문서 작업**: Level 2 권장
3. **구조 변경**: Level 3 필수

## 자동화 팁

```bash
# Git pre-commit hook 예시
#!/bin/bash
./.clauder-dev/tools/scripts/check-level1.sh || exit 1
```

간단하고 실용적으로!