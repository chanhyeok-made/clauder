---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "initial"
---

# /clauder optimize

프로젝트별 토큰 사용을 최적화합니다.

## 사용법

```
/clauder optimize [command] [options]
```

### 명령어
- `analyze` - 현재 토큰 사용 분석
- `compress` - 문서 압축 실행
- `suggest` - 최적화 제안
- `apply` - 최적화 적용
- `learn` - 사용 패턴 학습

## 예시

### 토큰 사용 분석
```
/clauder optimize analyze

📊 토큰 사용 분석 결과:
- 총 문서: 28개
- 총 토큰: ~15,000
- 평균 로드: ~8,000 토큰/세션
- 가장 큰 파일: dev-principles.md (1,200 토큰)
```

### 압축 실행
```
/clauder optimize compress

🗜️ 압축 결과:
- 메타데이터: 60% 압축
- 참조: 70% 단축
- 내용: 40% 압축
- 총 절약: 6,000 토큰
```

### 최적화 제안
```
/clauder optimize suggest

💡 최적화 제안:
1. 별칭 추가 가능: 15개 긴 경로
2. 중복 내용: 3개 섹션
3. 미사용 문서: 5개
4. 압축 가능: 12개 파일
```

### 패턴 학습
```
/clauder optimize learn

🧠 학습 결과:
- 자주 사용: commands/, guides/
- 거의 미사용: reference/
- 평균 세션 길이: 15회 대화
- 추천: essential 목록 조정
```

## 자동 최적화

### 설정
```yaml
# .claude/custom/optimization.yaml
auto_optimize:
  enabled: true
  threshold: 10000  # 토큰
  frequency: daily
```

### 동작
- 세션 시작 시 토큰 체크
- 임계값 초과 시 자동 압축
- 사용 패턴 기록
- 주기적 최적화

## 출력 예시

```
🎯 최적화 완료!

변경사항:
✅ 메타데이터 압축 (28개 파일)
✅ 별칭 적용 (45개 참조)
✅ 중복 제거 (3개 섹션)
✅ 코드 블록 축약 (8개)

효과:
- 이전: 15,000 토큰
- 이후: 8,500 토큰
- 절약: 43%

💡 추가 제안:
- TOKEN_TIPS.md 참조
- 선택적 로딩 활성화
- 캐싱 설정 조정
```