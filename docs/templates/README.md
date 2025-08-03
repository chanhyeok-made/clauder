---
doc_id: 511
---

Clauder의 템플릿 시스템과 사용 방법을 설명합니다.

## 🏗️ 템플릿 구조

### 메인 템플릿
@.claude/templates/CLAUDE.template.md

전체 CLAUDE.md의 기본 구조를 정의합니다.

### 핵심 템플릿

#### 1. 필수 정보
@.claude/templates/core/01-essentials.template.md

프로젝트 기본 정보, 기술 스택, 주요 기능을 포함합니다.

#### 2. 작업 원칙
@.claude/templates/core/02-work-principles.template.md

개발 워크플로우, 브랜치 전략, 커밋 규칙을 정의합니다.

#### 3. 개발 원칙
@.claude/templates/core/03-dev-principles.template.md

코딩 컨벤션, 테스트 전략, 보안 고려사항을 포함합니다.

### 컨텍스트 템플릿

#### README 템플릿
@.claude/templates/contexts/README.template.md

컨텍스트별 가이드의 기본 구조입니다.

#### 빠른 수정 가이드
@/.claude/templates/contexts/context-template.md

긴급 수정이나 핫픽스를 위한 가이드 템플릿입니다.

## 🔧 템플릿 사용법

### 1. 변수 치환
```yaml
{{PROJECT_NAME}}      # 프로젝트명
{{PROJECT_DESC}}      # 프로젝트 설명
{{TECH_STACK}}        # 기술 스택
{{CUSTOM_SECTION}}    # 사용자 정의 섹션
```

### 2. 조건부 포함
```markdown
<!-- if:exists custom/overrides/work-principles.md -->
# 커스텀 work-principles 파일 (선택적)
<!-- else -->
@.claude/templates/core/02-work-principles.template.md
<!-- endif -->
```

### 3. 확장 포인트
```markdown
<!-- extend:before -->
[템플릿 내용 앞에 추가할 내용]
<!-- extend:after -->
[템플릿 내용 뒤에 추가할 내용]
```

## 📋 커스터마이징

### 템플릿 오버라이드
1. 원본 템플릿을 custom/overrides/로 복사
2. 필요한 부분만 수정
3. generate 명령 실행 시 자동 적용

### 새 컨텍스트 추가
1. templates/contexts/에 새 템플릿 생성
2. 변수와 구조 정의
3. `/clauder add context` 명령으로 추가

## 🚀 템플릿 개발

### 템플릿 작성 원칙
1. **재사용성**: 범용적으로 사용 가능하게 작성
2. **확장성**: 커스터마이징 포인트 제공
3. **명확성**: 변수명과 구조를 명확하게
4. **문서화**: 템플릿 내 주석으로 사용법 설명

### 템플릿 테스트
```bash
# 템플릿 검증
/clauder check templates

# 드라이런
/clauder generate --dry-run

# 특정 템플릿만 테스트
/clauder test template <name>
```

## 관련 문서
- 시스템 개요: @.claude/README.md
- 프로젝트 독립성: @/.clauder-dev/principles/02-PROJECT-INDEPENDENCE.md
