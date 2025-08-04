---
doc_id: 812
---

# 필수 요구사항

## 필수 도구

### Git
- **이유**: 버전 추적 시스템이 Git 커밋 해시를 기반으로 작동
- **확인**: `git --version`
- **설치**: 
  - macOS: `brew install git`
  - Ubuntu: `sudo apt install git`
  - Windows: https://git-scm.com/downloads

### Claude Code
- **이유**: AI 어시스턴트와의 상호작용을 위해 필요
- **설치**: https://claude.ai/code

## 권장 사항

### 프로젝트 구조
- Git 저장소로 초기화된 상태
- 루트 디렉토리에 `.gitignore` 파일

### 환경
- Unix 기반 시스템 (macOS, Linux) 권장
- Windows에서는 WSL 사용 권장

## 검증

```bash
# Git 확인
git status
# 결과: "fatal: not a git repository" 오류가 없어야 함

# Claude Code 확인
# Claude Code에서:
/clauder
# 결과: 명령어 도움말이 표시되어야 함
```