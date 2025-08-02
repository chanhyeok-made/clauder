---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "f7db06e"
  
dependencies:
  - file: ".claude/templates/contexts/"
    commit: "f7db06e"
  - file: ".claude/custom/"
    commit: "f7db06e"
---

# /clauder add

프로젝트에 새로운 요소를 추가합니다.

## 사용법

```
/clauder add <type> <name> [options]
```

### 타입

- `context`: 새로운 상황별 가이드 추가
- `override`: 템플릿 오버라이드 추가
- `principle`: 프로젝트별 원칙 추가

## 동작

### context 추가

1. 템플릿을 기반으로 새 가이드 생성
2. `.claude/custom/contexts/` 디렉토리에 저장
3. 번호 자동 할당 (01-, 02-, ...)

### override 추가

1. 기존 템플릿을 복사
2. `.claude/custom/overrides/`에 저장
3. 편집 가능한 상태로 준비

## 예시

### 배포 가이드 추가

```
/clauder add context deployment
```

### 작업 원칙 커스터마이징

```
/clauder add override work-principles
```

### 보안 원칙 추가

```
/clauder add principle security
```

## 생성되는 파일

- 컨텍스트: `.claude/custom/contexts/02-deployment.md`
- 오버라이드: `.claude/custom/overrides/02-work-principles.md`
- 원칙: `.claude/custom/principles/security.md`
