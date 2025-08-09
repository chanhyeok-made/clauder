---
doc_id: 814
---

# 커스터마이징

## 프로젝트 정보 수정

```bash
# project.yaml 편집
edit .claude/custom/project.yaml
```

### project.yaml 구조
```yaml
project:
  name: "My Project"
  description: "Project description"
  tech_stack:
    - TypeScript
    - React
    - Node.js
```

## 템플릿 오버라이드

### 기본 템플릿 수정
```bash
# 템플릿을 custom/overrides로 복사
cp .claude/templates/core/01-essentials.template.md \
   .claude/custom/overrides/01-essentials.md

# 수정 후 재생성
/clauder generate
```

### 오버라이드 우선순위
1. `.claude/custom/personal/` (개인 설정)
2. `.claude/custom/overrides/` (프로젝트 설정)
3. `.claude/templates/` (기본 템플릿)

## 커스텀 가이드 추가

### 새 컨텍스트 생성
```
# Claude Code에서:
/clauder add context deployment
/clauder add context troubleshooting
/clauder add context api-development
```

### 수동으로 추가
```bash
# 직접 파일 생성
touch .claude/custom/contexts/deployment.md
```

## 변수 사용

### 기본 변수
- `{{PROJECT_NAME}}`: 프로젝트 이름
- `{{PROJECT_DESCRIPTION}}`: 프로젝트 설명
- `{{TECH_STACK}}`: 기술 스택
- `{{GENERATED_DATE}}`: 생성 날짜

### 커스텀 변수 추가
```yaml
# project.yaml에 추가
custom_vars:
  API_VERSION: "v2"
  DATABASE: "PostgreSQL"
```

## 고급 설정

- 개인 설정: @docs/guides/personal-settings.md
- 템플릿 가이드: @.claude/docs/TEMPLATE_GUIDE.md