---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "87f8148"
  
dependencies:
  - file: ".claude/templates/version-metadata.yaml"
    commit: "78b8a7b"
  - file: ".claude/commands/clauder-track.md"
    commit: "78b8a7b"
---

# 문서 버전 추적 시스템

## 개요
모든 문서는 생성/수정 시점의 Git 커밋 해시를 기록하여 버전을 추적합니다.
이를 통해 문서 간 의존성과 최신성을 명확히 파악할 수 있습니다.

## 메타데이터 구조

### 문서 헤더 (YAML Front Matter)
```yaml
---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "f7db06e"  # 이 문서가 작성된 시점의 커밋
  
dependencies:
  - file: ".claude/core/principles.md"
    commit: "3367e67"  # 참조 당시 principles.md의 커밋
  - file: ".claude/templates/core/01-essentials.template.md"
    commit: "b3c1368"
    
references:  # 이 문서를 참조하는 다른 문서들
  - file: "CLAUDE.md"
    commit: "f7db06e"
  - file: ".claude/README.md"
    commit: "f7db06e"
---
```

## 버전 추적 프로세스

### 1. 문서 생성 시
- 현재 Git 커밋 해시 자동 기록
- 참조하는 문서들의 커밋 해시 기록
- 역참조 관계 설정

### 2. 문서 수정 시
- updated 필드와 commit 필드 갱신
- 참조 문서들의 현재 커밋 확인
- 변경된 의존성 표시

### 3. 버전 확인
```
/clauder check versions
```
- 모든 문서의 버전 상태 확인
- 오래된 참조 탐지
- 업데이트 필요 문서 목록

## 자동화 도구

### 버전 메타데이터 추가
```
/clauder track [file]
```
- 문서에 버전 메타데이터 자동 추가
- 참조 관계 자동 탐지

### 의존성 그래프 생성
```
/clauder dependencies
```
- 문서 간 의존성 시각화
- 순환 참조 탐지
- 영향 범위 분석

### 버전 동기화
```
/clauder sync versions
```
- 모든 참조를 최신 커밋으로 업데이트
- 변경 사항 리포트 생성

## 예시

### project.yaml의 메타데이터
```yaml
---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "f7db06e"
  
dependencies:
  - file: ".claude/templates/core/01-essentials.template.md"
    commit: "b3c1368"
    status: "current"  # current/outdated/missing
    
references:
  - file: ".claude/commands/clauder-initialize.md"
    commit: "f7db06e"
  - file: ".claude/commands/clauder-generate.md"
    commit: "f7db06e"
---

# 실제 project.yaml 내용...
```

## 버전 상태 표시

### 상태 아이콘
- ✅ `current`: 최신 버전 참조
- ⚠️ `outdated`: 구 버전 참조 (업데이트 필요)
- ❌ `missing`: 참조 파일 없음
- 🔄 `modified`: 로컬 수정 있음

### 상태 리포트 예시
```
문서 버전 상태 리포트
====================

✅ CLAUDE.md (f7db06e)
   └─ ⚠️ .claude/core/principles.md (3367e67 → f7db06e)
   └─ ✅ .claude/core/work-principles.md (f7db06e)

⚠️ .claude/README.md (b3c1368)
   └─ ❌ .claude/INITIALIZE.md (삭제됨)
   └─ ✅ .claude/commands/ (f7db06e)

총 문서: 15
최신: 12 (80%)
업데이트 필요: 2 (13%)
누락: 1 (7%)
```

## 통합 전략

### 1. 점진적 적용
- 새로 생성되는 문서부터 메타데이터 추가
- 기존 문서는 수정 시 추가

### 2. CI/CD 통합
- PR 시 버전 체크 자동화
- 오래된 참조 경고

### 3. 문서 생성기 통합
- `/clauder generate` 시 자동으로 메타데이터 포함
- 템플릿에 버전 정보 자동 주입

## 장점
1. **추적성**: 모든 문서의 변경 이력 추적
2. **일관성**: 참조 문서 간 버전 일치 보장
3. **유지보수성**: 업데이트 필요 문서 쉽게 파악
4. **신뢰성**: 문서의 최신성 보장