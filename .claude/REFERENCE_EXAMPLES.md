---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "8b8a539"
---

# 참조 사용 예시

## 🔗 기존 방식 vs 새로운 방식

### 기본 참조
```markdown
<!-- 기존 -->
@.claude/templates/core/01-essentials.template.md

<!-- 새로운 방식 -->
@[$essentials]#8b8a539
```

### 조건부 참조
```markdown
<!-- 기존 (5줄) -->
<!-- if:exists custom/overrides/work-principles.md -->
@.claude/custom/overrides/work-principles.md
<!-- else -->
@.claude/templates/core/02-work-principles.template.md
<!-- endif -->

<!-- 새로운 방식 (1줄) -->
@[$custom/overrides/work-principles|$work-principles]#8b8a539
```

### 디렉토리 참조
```markdown
<!-- 기존 -->
@.claude/commands/

<!-- 새로운 방식 -->
@[$commands/]#8b8a539
```

## 📝 실제 사용 예시

### CLAUDE.md에서
```markdown
# 프로젝트 가이드

## 필수 정보
@[$essentials]#8b8a539

## 작업 원칙
@[$custom/overrides/work-principles|$work-principles]#8b8a539

## 개발 원칙
@[$custom/overrides/dev-principles|$dev-principles]#8b8a539

## 명령어 문서
- 초기화: @[$commands/clauder-initialize]#78b8a7b
- 버전 추적: @[$commands/clauder-track]#78b8a7b
- 참조 관리: @[$commands/clauder-ref]#8b8a539
```

### 문서 간 상호 참조
```markdown
## 관련 문서
- 상위 개념: @[$work-principles]#cf4b293
- 하위 구현: @[$dev-principles]#cf4b293
- 실제 예시: @[EXAMPLES.md]#8b8a539
```

### 스마트 참조 (미래 기능)
```markdown
## 도움이 필요하신가요?
- 에러 해결: @[smart:error-handling]
- 설치 가이드: @[smart:setup]
- 버전 관리: @[smart:version]
```

## 🎯 별칭 활용

### 정의된 별칭들
```yaml
# .claude/aliases.yaml
$root: "."
$claude: ".claude"
$core: ".claude/templates/core"
$templates: ".claude/templates"
$custom: ".claude/custom"
$commands: ".claude/commands"
$hooks: ".claude/hooks"

# 파일 별칭
$essentials: ".claude/templates/core/01-essentials.template.md"
$work-principles: ".claude/templates/core/02-work-principles.template.md"
$dev-principles: ".claude/templates/core/03-dev-principles.template.md"
```

### 별칭 사용 예
```markdown
<!-- 긴 경로 -->
@[.claude/templates/core/02-work-principles.template.md]#8b8a539

<!-- 별칭 사용 -->
@[$work-principles]#8b8a539

<!-- 더 짧은 별칭 -->
@[$core/02-work-principles.template.md]#8b8a539
```

## 🔄 마이그레이션 과정

### 1단계: 자동 변환
```bash
# 단일 파일
.claude/scripts/reference-updater.sh README.md

# 전체 프로젝트
.claude/scripts/reference-updater.sh all
```

### 2단계: 수동 최적화
- 자주 사용하는 참조를 별칭으로 변경
- 조건부 참조를 | 연산자로 단순화

### 3단계: 검증
```
/clauder ref check all
```

## ✅ 장점

1. **버전 추적**: 모든 참조에 커밋 해시
2. **짧고 명확**: 별칭으로 가독성 향상
3. **조건부 간소화**: 한 줄로 처리
4. **일관성**: 모든 참조가 동일한 형식
5. **자동화**: Git hook으로 자동 업데이트