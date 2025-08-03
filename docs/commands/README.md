---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "b34f41a"
  
dependencies:
  - file: ".claude/commands/clauder-start.md"
    commit: "b34f41a"
  - file: ".claude/commands/clauder-daily.md"
    commit: "b34f41a"
  - file: ".claude/commands/clauder-initialize.md"
    commit: "b34f41a"
  - file: ".claude/commands/clauder-generate.md"
    commit: "b34f41a"
  - file: ".claude/commands/clauder-check.md"
    commit: "b34f41a"
  - file: ".claude/commands/clauder-track.md"
    commit: "b34f41a"
  - file: ".claude/commands/clauder-hooks.md"
    commit: "b34f41a"
  - file: ".claude/commands/clauder-ref.md"
    commit: "b34f41a"
  - file: ".claude/commands/clauder-add.md"
    commit: "b34f41a"
  - file: ".claude/commands/clauder-update.md"
    commit: "b34f41a"
    
references:
  - file: "CLAUDE.md"
    commit: "b34f41a"
  - file: ".claude/README.md"
    commit: "b34f41a"
---

# 📚 Clauder 명령어 인덱스

모든 Clauder 명령어의 전체 목록과 설명입니다.

## 🚀 통합 명령어

### `/clauder start`
@.claude/commands/clauder-start.md

프로젝트 자동 설정의 시작점. Git 확인부터 모든 설정까지 자동화합니다.

### `/clauder daily`
@.claude/commands/clauder-daily.md

매일 상태 체크 및 동기화. 문서 버전 확인과 업데이트를 수행합니다.

## 🛠️ 기본 명령어

### `/clauder initialize`
@.claude/commands/clauder-initialize.md

프로젝트 초기화. 새 프로젝트나 기존 프로젝트에 Clauder를 설정합니다.

### `/clauder generate`
@.claude/commands/clauder-generate.md

CLAUDE.md 재생성. 템플릿과 커스텀 설정을 병합하여 문서를 생성합니다.

### `/clauder check`
@.claude/commands/clauder-check.md

문서 상태 확인. 참조 무결성, 버전 동기화, 전체 검증을 수행합니다.

## 📊 버전 관리

### `/clauder track`
@.claude/commands/clauder-track.md

버전 추적 관리. 문서 버전 상태 확인 및 동기화를 수행합니다.

### `/clauder ref`
@.claude/commands/clauder-ref.md

참조 관리. 문서 간 참조 관계를 관리하고 검증합니다.

## ➕ 추가/수정

### `/clauder add`
@.claude/commands/clauder-add.md

요소 추가. 새로운 컨텍스트, 가이드, 템플릿을 추가합니다.

### `/clauder update`
@.claude/commands/clauder-update.md

설정 업데이트. 프로젝트 정보, 기술 스택 등을 수정합니다.

## 🪝 자동화

### `/clauder hooks`
@.claude/commands/clauder-hooks.md

훅 관리. Git hooks 설치 및 자동화 설정을 관리합니다.

## 💡 추가 명령어

### 버전 트리 관리
- `/clauder tree` - 버전 트리 관리 @.claude/commands/clauder-tree.md

### 빠른 참조
- 명령어 도움말: `/clauder [command] --help`
- 전체 명령어 목록: `/clauder --list`

## 관련 문서
- 워크플로우: @.claude/docs/guides/WORKFLOWS.md
- 문제 해결: @.claude/docs/guides/TROUBLESHOOTING.md