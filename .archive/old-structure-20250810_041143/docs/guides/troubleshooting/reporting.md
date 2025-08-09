---
doc_id: 831
---

# 문제 보고 가이드

## 필수 정보

### 시스템 정보
```bash
# OS 및 하드웨어
uname -a

# Git 버전
git --version

# Claude Code 버전
# (Claude Code 내에서 확인)
```

### Clauder 상태
```bash
# 디렉토리 구조
ls -la .claude/

# 최근 커밋
git log --oneline -5

# 버전 트리 상태
head -20 .claude/version-tree.yaml
```

### 오류 메시지
```
# 전체 오류 메시지 복사
# 스크린샷 포함
# 실행한 명령어 포함
```

## 보고 형식

### GitHub Issue 템플릿
```markdown
## 문제 설명
[ubb38제에 대한 명확한 설명]

## 재현 단계
1. [1단계]
2. [2단계]
3. [3단계]

## 기대 동작
[uae30대했던 결과]

## 실제 동작
[uc2e4제 발생한 결과]

## 환경
- OS: [macOS/Linux/Windows]
- Git: [version]
- Claude Code: [version]

## 로그
```
[uad00련 로그]
```
```

## 도움이 되는 정보

- 시도해본 해결 방법
- 관련 설정 파일
- 스크린샷 또는 녹화