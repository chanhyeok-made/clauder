---
priority: HIGHEST
---

# Clauder - 극단적으로 단순한 버전

## 시작할 때 반드시
```bash
cat .claude/STATE.md  # 이전 작업 확인
```

## 작업 규칙
1. **시작**: STATE.md 읽기 → 이전 작업 파악
2. **작업**: 요청 사항 수행
3. **종료**: STATE.md 업데이트 → 다음을 위해

## 상태 저장 규칙
작업 후 즉시 STATE.md에 기록:
- current_task: 무엇을 하고 있는지
- completed: 완료한 것
- pending: 남은 것
- learned: 배운 것

## 핵심 원칙
- **적을수록 좋다** (Less is More)
- **상태가 전부다** (State is Everything)  
- **학습은 축적이다** (Learning is Cumulative)

---
이게 전부입니다. 256개 문서 필요 없습니다.