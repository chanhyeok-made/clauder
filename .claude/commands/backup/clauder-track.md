# /clauder track

문서에 버전 추적 메타데이터를 추가하고 관리합니다.

## 사용법

```
/clauder track [action] [file]
```

### 액션
- `add`: 문서에 버전 메타데이터 추가
- `update`: 메타데이터 업데이트
- `check`: 버전 상태 확인
- `sync`: 참조 동기화

## 동작

### 1. 메타데이터 추가 (`add`)
```
/clauder track add [file]
```
- 현재 Git 커밋 해시 추가
- 파일 내 참조(@로 시작하는 경로) 자동 탐지
- YAML front matter 생성

### 2. 메타데이터 업데이트 (`update`)
```
/clauder track update [file]
```
- updated 날짜와 커밋 해시 갱신
- 새로운 참조 추가
- 삭제된 참조 제거

### 3. 버전 확인 (`check`)
```
/clauder track check [file|all]
```
- 특정 파일 또는 전체 문서의 버전 상태
- 오래된 참조 표시
- 역참조 관계 표시

### 4. 동기화 (`sync`)
```
/clauder track sync [file|all]
```
- 모든 참조를 최신 커밋으로 업데이트
- 변경 사항 요약

## 예시

### 새 문서에 추적 추가
```
User: /clauder track add .claude/custom/deployment.md
Claude: 
✓ 버전 메타데이터가 추가되었습니다.
  - 커밋: a1b2c3d
  - 참조 발견: 2개
    - @.claude/core/principles.md (f7db06e)
    - @.claude/templates/contexts/README.template.md (b3c1368)
```

### 버전 상태 확인
```
User: /clauder track check all
Claude:
문서 버전 상태 리포트
====================

✅ CLAUDE.md (최신)
   ├─ ⚠️ .claude/core/principles.md (3커밋 뒤처짐)
   └─ ✅ .claude/core/work-principles.md (최신)

⚠️ README.md (5커밋 뒤처짐)
   └─ ❌ .claude/INITIALIZE.md (파일 없음)

요약: 15개 문서 중 12개 최신, 2개 업데이트 필요, 1개 누락
```

### 참조 동기화
```
User: /clauder track sync CLAUDE.md
Claude:
다음 참조가 업데이트됩니다:
- .claude/core/principles.md: 3367e67 → f7db06e

계속하시겠습니까? (Y/n)
```

## 메타데이터 형식

```yaml
---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "f7db06e"
  
dependencies:
  - file: ".claude/core/principles.md"
    commit: "3367e67"
    status: "outdated"  # current/outdated/missing
    
references:
  - file: "CLAUDE.md"
    commit: "f7db06e"
---
```

## 자동화

### Git Hook 통합
```bash
# .git/hooks/pre-commit
/clauder track update --staged
```

### CI/CD 통합
```yaml
# .github/workflows/docs.yml
- name: Check documentation versions
  run: /clauder track check all --fail-on-outdated
```