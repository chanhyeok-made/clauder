---
doc_id: 516
---

## 🎯 핵심 원칙

### 1. 완벽한 참조 구조
모든 문서는 **반드시** 다음 요소를 포함해야 합니다:

#### YAML Front Matter
```yaml
```

#### 참조 방식
- **직접 참조**: `@path/to/file.md`
- **별칭 참조**: `@[$alias]`
- **버전 포함**: `@path/to/file.md#commit`

### 2. 프로젝트 독립성
모든 설정은 다른 프로젝트에 영향을 주지 않도록:

#### 파일 구조
```
# Git에 포함 (템플릿)
CLAUDE.base.md
.claude/custom/project.base.yaml
.claude/templates/**

# Git에서 제외 (실제 사용)
CLAUDE.md
.claude/custom/project.yaml
.claude/custom/overrides/**
.claude/custom/contexts/**
```

#### 원칙
1. **템플릿과 실제 분리**: `.base` 파일은 템플릿, 실제 파일은 gitignore
2. **Custom 우선**: custom/ 설정이 templates/보다 우선
3. **명시적 확장**: 모든 수정은 custom/에서만

### 3. 버전 추적
모든 문서는 Git 커밋 해시로 버전 관리:

```yaml
# 문서 생성/수정 시
version:
  created: "2025-08-02"      # 최초 생성일
  updated: "2025-08-02"      # 마지막 수정일
  commit: "abc123"           # Git 커밋 해시
```

### 4. 의존성 명시
문서가 참조하는 모든 파일을 dependencies에 명시:

```yaml
dependencies:
  - file: "README.md"
    commit: "def456"
    status: "current"        # current 또는 outdated
```

### 5. 경로 별칭 사용
자주 사용하는 경로는 별칭으로 정의 (@.claude/aliases.yaml):

```yaml
# aliases.yaml
essentials: ".claude/templates/core/01-essentials.template.md"
principles: ".claude/docs/principles/"
```

## 🛠️ 실천 방법

### 문서 작성 시
1. **템플릿 사용**: 새 문서는 기존 문서의 front matter 복사
2. **참조 확인**: 모든 @참조가 유효한지 확인
3. **버전 업데이트**: 수정 시 updated 날짜와 commit 업데이트

### 문서 검증
```bash
# 참조 검증
/clauder check references

# 버전 동기화
/clauder track sync

# 전체 검증
/clauder check
```

### 자동화
Git hooks와 Claude instructions로 자동화:
- pre-commit: 버전 메타데이터 업데이트
- Claude 작업: 참조 자동 추가

## 📚 관련 문서

- 참조 전략: @.claude/docs/design/REFERENCE_STRATEGY.md
- 버전 추적: @.claude/docs/design/VERSION_TRACKING.md
- 훅 시스템: @.claude/docs/design/HOOKS.md
- 별칭 정의: @.claude/aliases.yaml

## ✅ 체크리스트

문서 작성/수정 시 확인:
- [ ] YAML front matter 포함
- [ ] version 정보 업데이트
- [ ] dependencies 명시
- [ ] 모든 참조 (@) 유효성 확인
- [ ] 별칭 사용 가능 여부 확인
- [ ] 프로젝트 독립성 유지
- [ ] Git 커밋 해시 포함

