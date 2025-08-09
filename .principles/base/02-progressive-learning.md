---
doc_id: 744
---

# 원칙 2: 점진적 학습 시스템

## 핵심 개념
사용하면서 Claude와 함께 성장하는 지식 축적 시스템입니다.

## 왜 중요한가?

### 문제 상황
```
# 월요일
User: TypeScript 에러 TS2339 해결해줘
Claude: [해결 과정]

# 금요일 (같은 에러)
User: TypeScript 에러 TS2339 해결해줘
Claude: [처음부터 다시 같은 과정]
```

### 해결된 상황
```
# 금요일
User: TypeScript 에러 TS2339 해결해줘
Claude: 이전에 학습한 패턴을 확인했습니다.
        [즉시 올바른 해결책 제시]
        이번 케이스도 문서화하여 패턴을 강화했습니다.
```

## 구현 방법

### 1. 학습 기록 구조
```
.clauder-dev/learnings/
├── error-patterns/          # 오류 해결 패턴
│   ├── typescript-errors.md
│   └── api-errors.md
├── optimization/            # 최적화 방법
├── best-practices/          # 발견한 모범 사례
└── user-feedback/           # 사용자 피드백 반영
```

### 2. 학습 프로세스
```yaml
발생 → 해결 → 기록 → 패턴화 → 원칙화 → 자동화
 ↑                                          ↓
 ←←←←←←←←← 다음 발생 시 즉시 적용 ←←←←←←←←←
```

### 3. 패턴 추출
```markdown
## 패턴: TypeScript 프로퍼티 없음 에러

### 증상
- 에러: TS2339: Property 'X' does not exist

### 원인
1. 타입 정의 누락
2. 옵셔널 체이닝 필요
3. 타입 가드 부재

### 해결책
1. 인터페이스 확장
2. 타입 assertion
3. 타입 가드 추가

### 예방
- 엄격한 타입 정의
- 초기 설계 시 인터페이스 완성
```

## 적용 예시

### Clauder 자체에서
```yaml
# 실제 학습 사례
문제: "작업 후 GitHub 커밋 잊음"
학습: "작업 단위 커밋 원칙 수립"
자동화: "Git hooks로 리마인더"
결과: "더 이상 커밋 누락 없음"
```

### 사용자 프로젝트에서
```bash
# 팀 학습 공유
.claude/custom/learnings/
├── api-patterns/
│   └── rate-limiting-solutions.md
├── debugging/
│   └── memory-leak-patterns.md
└── performance/
    └── query-optimization.md
```

## 학습 단계별 진화

### Level 1: 기록
```markdown
## 2025-08-03
로그인 API에서 401 에러 발생
원인: JWT 토큰 만료 체크 누락
해결: 미들웨어에 만료 검증 추가
```

### Level 2: 패턴화
```markdown
## 인증 에러 패턴
- 401: 토큰 없음/만료
- 403: 권한 부족
- 419: 토큰 조작

공통 해결: 통합 인증 미들웨어
```

### Level 3: 원칙화
```markdown
## 인증 원칙
모든 보호된 라우트는 반드시:
1. 토큰 존재 확인
2. 토큰 유효성 검증
3. 권한 레벨 체크
```

### Level 4: 자동화
```javascript
// 자동 생성되는 미들웨어
@RequireAuth(level="user")
@ValidateToken
router.get('/protected', handler)
```

## 측정 가능한 효과

1. **반복 문제 해결 시간**: 30분 → 5분 → 자동
2. **같은 실수 빈도**: 지속 발생 → 점진적 감소 → 0
3. **팀 전체 학습 곡선**: 개인 경험 → 팀 지식

## 핵심 원리

> "모든 경험은 학습이 되고, 모든 학습은 개선이 된다"

- **투명한 기록**: 성공과 실패 모두 문서화
- **패턴 인식**: 반복되는 상황 식별
- **지속적 개선**: 학습이 시스템에 반영

---

점진적 학습 시스템은 Claude를 단순한 도구에서 
함께 성장하는 파트너로 만듭니다.