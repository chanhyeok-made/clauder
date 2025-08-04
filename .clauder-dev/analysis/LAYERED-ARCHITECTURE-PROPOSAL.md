---
doc_id: 867
---

# 계층적 아키텍처 제안

## 현재 문제점
1. `.claude/`와 `.clauder-dev/` 간 참조로 인한 의존성
2. 단순 복사로 인한 내용 중복
3. 유지보수 어려움

## 제안하는 3계층 구조

```
.base-principles/          # 1층: 범용 베이스 원칙
├── code-quality/         # 코드 품질 관련
├── documentation/        # 문서화 관련
├── workflow/            # 워크플로우 관련
└── structure/           # 구조 관련

.clauder-dev/            # 2층: Clauder 개발 전용
├── principles/          # Clauder 특화 원칙
│   └── (베이스 원칙 참조 + 확장)
└── ...

.claude/                 # 3층: 사용자 템플릿
├── principles/          # 프로젝트 원칙
│   └── README.md        # 베이스 원칙 참조 인덱스
└── ...
```

## 참조 규칙
1. **상향 참조 허용**: 하위 계층 → 상위 계층
   - `.claude/` → `.base-principles/` ✅
   - `.clauder-dev/` → `.base-principles/` ✅
   
2. **하향/횡단 참조 금지**:
   - `.claude/` → `.clauder-dev/` ❌
   - `.base-principles/` → `.claude/` ❌

## 장점
1. **DRY 원칙 준수**: 중복 없음
2. **명확한 계층**: 의존성 방향 명확
3. **확장성**: 각 계층에서 필요한 부분만 확장
4. **유지보수성**: 베이스 수정 시 모든 곳에 반영

## 구현 방법

### 1단계: 베이스 원칙 추출
```
기존: .clauder-dev/principles/06-WORK-UNIT-COMMITS.md
분리:
- .base-principles/workflow/work-unit-commits.md (핵심)
- .clauder-dev/principles/06-WORK-UNIT-COMMITS.md (Clauder 특화)
```

### 2단계: 참조 구조 변경
```markdown
# .claude/workflow/05-commit.md
## 원칙
상세 내용: @.base-principles/workflow/work-unit-commits.md

# .clauder-dev/principles/06-WORK-UNIT-COMMITS.md  
## 베이스 원칙
@.base-principles/workflow/work-unit-commits.md

## Clauder 특화 규칙
[추가 규칙들...]
```

### 3단계: 인덱스 파일
```markdown
# .claude/principles/README.md
## 이 프로젝트가 따르는 원칙들

### 베이스 원칙 (모든 프로젝트 공통)
- @.base-principles/workflow/
- @.base-principles/code-quality/
- @.base-principles/documentation/

### 프로젝트 특화 원칙
- [프로젝트별 추가 원칙...]
```

## 예시: 코드 정확성 원칙

### Before (중복)
```
.clauder-dev/principles/11-CODE-CORRECTNESS.md (전체 내용)
.claude/principles/11-CODE-CORRECTNESS.md (복사본)
```

### After (계층화)
```
.base-principles/code-quality/code-correctness.md (핵심 원칙)
├── 참조: .clauder-dev/principles/11-CODE-CORRECTNESS.md
└── 참조: .claude/workflow/02-implementation.md
```

이렇게 하면 중복 없이 깔끔한 구조가 됩니다.