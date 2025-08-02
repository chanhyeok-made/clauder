---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "f7db06e"
  
dependencies:
  - file: ".claude/custom/project.yaml"
    commit: "f7db06e"
    status: "current"
  - file: "CLAUDE.md"
    commit: "f7db06e"
    status: "current"
---

# /clauder update

프로젝트 설정의 특정 부분을 업데이트합니다.

## 사용법

```
/clauder update <section> [options]
```

### 섹션

- `project`: 프로젝트 기본 정보
- `tech`: 기술 스택
- `commands`: 개발 명령어
- `structure`: 디렉토리 구조
- `links`: 참조 링크

## 동작

1. 현재 project.yaml 읽기
2. 해당 섹션에 대해 질문
3. 새로운 값으로 업데이트
4. CLAUDE.md 재생성 옵션 제공

## 예시

### 기술 스택 업데이트

```
/clauder update tech
```

새로운 프레임워크나 데이터베이스 추가

### 명령어 업데이트

```
/clauder update commands
```

빌드, 테스트 명령어 변경

### 프로젝트 구조 업데이트

```
/clauder update structure
```

디렉토리 구조 변경사항 반영

## 대화 예시

```
User: /update tech
Claude: 현재 기술 스택: JavaScript, React
        추가하거나 변경할 항목이 있나요?
User: TypeScript 추가, PostgreSQL 추가
Claude: ✓ 기술 스택이 업데이트되었습니다.
        CLAUDE.md를 재생성하시겠습니까? (Y/n)
```
