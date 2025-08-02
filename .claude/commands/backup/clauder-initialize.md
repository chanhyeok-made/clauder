---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "f7db06e"
  
dependencies:
  - file: ".claude/custom/project.yaml"
    commit: "f7db06e"
  - file: "CLAUDE.md"
    commit: "f7db06e"
    
references:
  - file: ".claude/README.md"
    commit: "f7db06e"
  - file: ".claude/custom/project.yaml"
    commit: "f7db06e"
---

# /clauder initialize

프로젝트 문서 시스템을 초기화합니다.

## 사용법

```
/clauder initialize [mode]
```

### 옵션
- `quick` (기본값): 필수 정보만 질문
- `full`: 모든 설정 항목 질문
- `--migrate`: 기존 프로젝트 마이그레이션

## 동작

1. **프로젝트 분석**
   - 현재 디렉토리의 파일 스캔
   - 언어/프레임워크 자동 감지
   - 기존 설정 파일 확인

2. **대화형 설정**
   프로젝트에 대해 몇 가지 질문을 드립니다:
   - 프로젝트 이름
   - 주요 목적 (한 문장)
   - 주 사용 언어

3. **파일 생성**
   - `.claude/custom/project.yaml` 생성
   - `CLAUDE.md` 생성 또는 업데이트

## 예시

### 새 프로젝트
```
/clauder initialize
```

### 전체 설정
```
/clauder initialize full
```

### 기존 프로젝트 마이그레이션
```
/clauder initialize --migrate
```

## 구현 로직

이 명령을 실행하면:
1. 프로젝트 파일들을 분석합니다 (package.json, go.mod, requirements.txt 등)
2. 감지된 정보를 바탕으로 기본값을 제안합니다
3. 사용자 입력을 받아 project.yaml을 생성합니다
4. 템플릿을 처리하여 CLAUDE.md를 생성합니다