---
doc_id: 761
---

# 커밋 단계

## 목적
작업을 완료하고 GitHub에 안전하게 저장합니다.

## 필수 체크리스트
- [ ] 모든 변경사항 확인: `git status`
- [ ] 테스트 통과
- [ ] 문서 업데이트 완료
- [ ] TODO 항목 완료

## 커밋 프로세스

### 1. 변경사항 확인
```bash
git status
git diff
```

### 2. 스테이징
```bash
git add .
# 또는 선택적으로
git add [파일명]
```

### 3. 커밋 메시지
```bash
git commit -m "type: 간단명료한 설명"
```

#### 타입 종류
- `feat`: 새 기능
- `fix`: 버그 수정
- `docs`: 문서 수정
- `refactor`: 리팩토링
- `test`: 테스트 추가/수정
- `chore`: 기타 작업

### 4. 푸시
```bash
git push origin main
```

## 커밋 후
- 작업 완료 확인
- 다음 작업 준비
- 필요시 배포 진행

## 🎯 Sub-TODO 템플릿

이 단계 시작 시 TodoWrite로 생성:
```
5.1. 변경사항 최종 확인
5.2. 의미 있는 커밋 메시지 작성
5.3. 푸시 및 작업 완료
```

## 원칙
상세 내용: @.base-principles/workflow/work-unit-commits.md