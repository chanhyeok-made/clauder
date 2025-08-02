---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "initial"
---

# 명령어 공통 템플릿

## 기본 사용법
```
/clauder [command] [options]
```

## 공통 옵션
- `--help` - 도움말 표시
- `--dry-run` - 실행하지 않고 미리보기
- `--verbose` - 자세한 출력

## 오류 처리
명령어 실행 중 문제가 발생하면:
1. 오류 메시지 확인
2. `--verbose` 옵션으로 재실행
3. @[$guides/TROUBLESHOOTING.md] 참조