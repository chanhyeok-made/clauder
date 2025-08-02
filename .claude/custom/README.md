# Custom 디렉토리 가이드

이 디렉토리는 프로젝트별 커스터마이징을 위한 공간입니다.

## 📁 구조

```
custom/
├── README.md           # 이 파일
├── project.base.yaml   # 템플릿 (Git에 포함)
├── project.yaml        # 실제 프로젝트 설정 (gitignore)
├── overrides/          # 템플릿 오버라이드 (gitignore)
└── contexts/           # 추가 컨텍스트 (gitignore)
```

## 🔧 사용 방법

### 새 프로젝트에서 사용

1. **project.base.yaml을 project.yaml로 복사**
   ```bash
   cp .claude/custom/project.base.yaml .claude/custom/project.yaml
   ```

2. **project.yaml 편집**
   - 템플릿 변수 ({{VARIABLE}})를 실제 값으로 대체
   - 프로젝트에 맞게 커스터마이징

3. **필요시 오버라이드 추가**
   ```bash
   mkdir -p .claude/custom/overrides
   cp .claude/templates/core/01-essentials.template.md \
      .claude/custom/overrides/01-essentials.md
   ```

4. **프로젝트별 컨텍스트 추가**
   ```bash
   mkdir -p .claude/custom/contexts
   echo "# 프로젝트별 가이드" > .claude/custom/contexts/my-guide.md
   ```

## 📝 템플릿 변수 설명

project.base.yaml에 포함된 주요 변수:

- `{{PROJECT_NAME}}`: 프로젝트 이름
- `{{PROJECT_DESCRIPTION}}`: 프로젝트 설명
- `{{PROJECT_VERSION}}`: 버전 번호
- `{{PROJECT_TYPE}}`: 프로젝트 유형 (web-app, cli-tool, library 등)
- `{{PRIMARY_LANGUAGE}}`: 주 사용 언어
- `{{FRAMEWORK}}`: 사용 프레임워크
- `{{MAIN_PURPOSE}}`: 프로젝트 주요 목적
- 기타 다수...

## ⚠️ 주의사항

1. **Git 관리**
   - `project.base.yaml`은 Git에 포함됨 (템플릿)
   - `project.yaml`은 .gitignore에 포함됨 (실제 설정)
   - `overrides/`와 `contexts/`도 .gitignore에 포함됨

2. **Clauder 자체 개발**
   - Clauder 프로젝트는 이미 설정된 project.yaml 사용
   - 다른 프로젝트는 project.base.yaml을 템플릿으로 사용

3. **업데이트 시**
   - project.base.yaml이 업데이트되어도 기존 project.yaml은 영향받지 않음
   - 필요시 수동으로 변경사항 반영