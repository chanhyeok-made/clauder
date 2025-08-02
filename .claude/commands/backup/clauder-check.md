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

# /clauder check

문서 시스템의 상태를 확인합니다.

## 사용법

```
/clauder check [what]
```

### 옵션

- `documentation` (기본값): 전체 문서 상태
- `setup`: 설치 상태 확인
- `templates`: 템플릿 버전 확인
- `custom`: 커스텀 설정 확인

## 동작

체크 항목:

- ✓ 필수 파일 존재 여부
- ✓ project.yaml 유효성
- ✓ 템플릿 버전
- ✓ 커스텀 파일 목록
- ⚠️ 누락된 설정
- ❌ 오류 사항

## 예시

### 전체 상태 확인

```
/clauder check
```

### 설치 확인

```
/clauder check setup
```

## 출력 예시

```
✓ 템플릿 시스템이 설치되었습니다 (v1.0)
✓ project.yaml이 존재합니다
⚠️ CLAUDE.md 재생성 필요
○ 커스텀 컨텍스트: 2개
  - deployment.md
  - debugging.md
```
