---
doc_id: 826
---

# 디버깅 모드

## 상세 로그 확인

### Git hooks 로그
```bash
# 훅 실행 로그
cat /tmp/clauder-hook.log

# 실시간 모니터링
tail -f /tmp/clauder-hook.log
```

### 버전 상태 상세 정보
```
/clauder track check all --verbose
```

## 디버깅 명령어

### 시스템 진단
```
/clauder check --diagnose
```

### 템플릿 검증
```
/clauder generate --dry-run --verbose
```

### 참조 추적
```
/clauder ref trace [file]
```

## 로그 파일 위치

- Hook 로그: `/tmp/clauder-hook.log`
- 오류 로그: `/tmp/clauder-error.log`
- 세션 로그: `.claude/.logs/session.log`

## 환경 변수

```bash
# 디버그 모드 활성화
export CLAUDER_DEBUG=1

# 상세 로그
export CLAUDER_VERBOSE=1
```