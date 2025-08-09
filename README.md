---
doc_id: 1001
---

# Clauder - Claude Code 문서 템플릿 시스템

> 💡 이 문서는 Lazy Loading 방식으로 최적화되었습니다.
> 필요한 정보만 필요할 때 참조하세요.

Claude Code를 위한 범용 문서 템플릿 시스템입니다. 모든 프로젝트에서 재사용 가능한 구조화된 문서화 프레임워크를 제공합니다.

## 🚀 Quick Start

### 가장 빠른 방법: 한 줄 명령

```bash
# Claude Code에서:
/clauder start
```

이 명령 하나로 Git 확인, 프로젝트 분석, 필수 파일 생성이 모두 자동화됩니다.

### 시작하기
- **새 프로젝트**: @docs/readme/new-project.md
- **기존 프로젝트**: @docs/readme/existing-project.md
- **필수 요구사항**: @docs/readme/requirements.md

## 📋 주요 기능

### 핵심 기능
- **자동 초기화**: `/clauder start`로 모든 설정 자동화
- **버전 추적**: Git 기반 문서 버전 관리
- **템플릿 시스템**: 재사용 가능한 문서 구조
- **Lazy Loading**: 토큰 최적화된 문서 로딩

### 명령어
- **기본 명령어**: @docs/readme/commands.md
- **커스터마이징**: @docs/readme/customization.md
- **훅 시스템**: @docs/readme/hooks.md

## 📁 구조

```
your-project/
├── .claude/
│   ├── templates/        # 템플릿 (수정 금지)
│   ├── custom/          # 커스터마이징
│   └── *.md            # 시스템 문서
├── CLAUDE.base.md      # 템플릿 파일
└── CLAUDE.md           # 실제 파일 (gitignore)
```

상세 구조: @docs/readme/structure.md

## 📚 문서

### 가이드
- **사용 예제**: @EXAMPLES.md
- **문제 해결**: @docs/guides/troubleshooting.md
- **워크플로우**: @docs/guides/workflows.md

### 설계
- **아키텍처**: 
- **기능 맵**: 
- **훅 시스템**: 

## 💡 추가 정보

- **팀 협업**: @docs/readme/team-collaboration.md
- **Git 관리**: @docs/readme/git-management.md
- **업데이트**: @docs/readme/updates.md

## 🤝 기여

문제점이나 개선사항이 있다면:
- [이슈 생성](https://github.com/chanhyeok-made/clauder/issues)
- [PR 제출](https://github.com/chanhyeok-made/clauder/pulls)

## 📄 라이선스

MIT License - 자유롭게 사용하세요!