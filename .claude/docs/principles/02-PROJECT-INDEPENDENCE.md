---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "11d1061"
  
dependencies:
  - file: ".gitignore"
    commit: "11d1061"
    status: "current"
  - file: ".claude/custom/README.md"
    commit: "11d1061"
    status: "current"
    
references:
  - file: ".claude/docs/principles/README.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/instructions.md"
    commit: "11d1061"
    status: "current"
---

# 원칙 2: 프로젝트 독립성

## 핵심 규칙

### 파일 구조 분리
```
# Git에 포함 (템플릿)
*.base.md
*.base.yaml
.claude/templates/**

# Git에서 제외 (실제 사용)
CLAUDE.md
.claude/custom/project.yaml
.claude/custom/overrides/**
.claude/custom/contexts/**
```

### 설정 우선순위
1. custom/ > templates/
2. 실제 파일 > 템플릿 파일
3. 프로젝트별 설정 > 범용 설정

## 실천 방법

1. **Clauder 개발 시**: 실제 파일 사용
2. **다른 프로젝트**: 템플릿 복사 후 커스터마이징
3. **업데이트 시**: 템플릿만 업데이트, 실제 파일은 보존

## 관련 문서
- gitignore 설정: @.gitignore
- custom 디렉토리 가이드: @.claude/custom/README.md