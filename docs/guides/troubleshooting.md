---
doc_id: 715
---

# Clauder 문제 해결 가이드

> 💡 이 문서는 Lazy Loading 방식으로 최적화되었습니다.
> 문제 유형별로 필요한 정보만 참조하세요.

## 🚨 문제 유형별 가이드

### 일반적인 문제
- **Git 관련**: @docs/guides/troubleshooting/git-issues.md
- **명령어 오류**: @docs/guides/troubleshooting/command-issues.md
- **버전 추적**: @docs/guides/troubleshooting/version-tracking.md
- **Hook 문제**: @docs/guides/troubleshooting/hook-issues.md
- **파일 수정**: @docs/guides/troubleshooting/file-editing.md
- **템플릿 문제**: @docs/guides/troubleshooting/template-issues.md

### 고급 문제 해결
- **디버깅 모드**: @docs/guides/troubleshooting/debugging.md
- **수동 복구**: @docs/guides/troubleshooting/manual-recovery.md
- **초기화 문제**: @docs/guides/troubleshooting/initialization.md

## 📊 빠른 진단

```
/clauder check --diagnose
```

시스템 상태를 종합적으로 점검하고 문제점을 파악합니다.

## 💡 예방 조치

### 정기 점검
```
/clauder daily    # 매일
/clauder check    # 작업 전
```

### 백업
- **설정 백업**: @docs/guides/troubleshooting/backup.md
- **복구 전략**: @docs/guides/troubleshooting/recovery.md

## 🆘 추가 지원

### 문제 보고
- **필수 정보**: @docs/guides/troubleshooting/reporting.md
- **GitHub Issues**: https://github.com/chanhyeok-made/clauder/issues

---

대부분의 문제는 Git 초기화, 올바른 디렉토리 위치, 권한 설정으로 해결됩니다.

