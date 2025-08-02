---
# Claude Code 프로젝트 가이드 - 템플릿

> 🚨 **이것은 템플릿 파일입니다**
> 
> 실제 사용 시:
> 1. 이 파일을 CLAUDE.md로 복사
> 2. 프로젝트 정보로 커스터마이징
> 3. CLAUDE.md는 .gitignore에 추가

## 🆘 작업 완료 시 즉시 커밋!

> **경고**: 모든 작업은 완료 즉시 GitHub에 커밋해야 합니다!
> 
> ```bash
> git add .
> git commit -m "작업 설명"
> git push
> ```
> 
> 원칙: @.claude/docs/principles/06-WORK-UNIT-COMMITS.md

## 🚨 핵심 원칙 (필수 준수)

모든 작업은 다음 원칙을 따라야 합니다:

1. **완벽한 참조 구조**: @.claude/docs/principles/01-REFERENCE-STRUCTURE.md
2. **프로젝트 독립성**: @.claude/docs/principles/02-PROJECT-INDEPENDENCE.md
3. **문서 모듈화**: @.claude/docs/principles/03-DOCUMENT-MODULARITY.md
4. **즉시 인지 가능**: @.claude/docs/principles/04-IMMEDIATE-RECOGNITION.md
5. **필수 역참조**: @.claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md
6. **작업 단위 커밋**: @.claude/docs/principles/06-WORK-UNIT-COMMITS.md

전체 원칙 목록: @.claude/docs/principles/README.md

## 템플릿 사용 방법

1. 이 파일을 CLAUDE.md로 복사:
   ```bash
   cp CLAUDE.base.md CLAUDE.md
   ```

2. CLAUDE.md를 .gitignore에 추가:
   ```bash
   echo "CLAUDE.md" >> .gitignore
   ```

3. CLAUDE.md를 프로젝트에 맞게 수정

## 📋 프로젝트 정보 (수정 필요)

### 프로젝트 개요
- **이름**: {{PROJECT_NAME}}
- **설명**: {{PROJECT_DESCRIPTION}}
- **기술 스택**: {{TECH_STACK}}
- **주요 목적**: {{MAIN_PURPOSE}}

### 빠른 시작 가이드
{{QUICK_START_GUIDE}}

### 프로젝트 구조
{{PROJECT_STRUCTURE}}

## 🔧 개발 가이드

### 작업 원칙
{{WORK_PRINCIPLES}}

### 코딩 컨벤션
{{CODING_CONVENTIONS}}

### 테스트 및 빌드
{{TEST_BUILD_COMMANDS}}

---

## 📌 템플릿 변수 설명

- `{{PROJECT_NAME}}`: 프로젝트 이름
- `{{PROJECT_DESCRIPTION}}`: 프로젝트 간단 설명
- `{{TECH_STACK}}`: 사용 기술 목록
- `{{MAIN_PURPOSE}}`: 프로젝트 주요 목적
- `{{QUICK_START_GUIDE}}`: 빠른 시작 가이드
- `{{PROJECT_STRUCTURE}}`: 디렉토리 구조
- `{{WORK_PRINCIPLES}}`: 작업 원칙
- `{{CODING_CONVENTIONS}}`: 코딩 규칙
- `{{TEST_BUILD_COMMANDS}}`: 테스트/빌드 명령어

이 변수들을 실제 프로젝트 정보로 대체하세요.