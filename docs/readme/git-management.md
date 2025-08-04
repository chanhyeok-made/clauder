---
doc_id: 818
---

# Git 관리

## .gitignore 권장 설정

```gitignore
# Clauder 관련
.claude/custom/project.yaml    # 민감 정보 포함 가능
.claude/custom/personal/       # 개인 설정
.claude/.generated/            # 생성된 파일
CLAUDE.md                      # 자동 생성되므로
```

## 서브모듈 관리

### 템플릿을 서브모듈로
```bash
# 서브모듈 추가
git submodule add https://github.com/chanhyeok-made/clauder.git .claude-template

# 서브모듈 업데이트
git submodule update --remote
```

### 장점
- 템플릿 업데이트 용이
- 버전 관리 명확
- 주 프로젝트와 분리

## 커밋 전략

### Clauder 관련 커밋
```bash
# 초기 설정
git commit -m "chore: Add Clauder documentation system"

# 커스텀 가이드 추가
git commit -m "docs: Add deployment context guide"

# 템플릿 업데이트
git commit -m "chore: Update Clauder templates"
```

## 브랜치 전략

### 개발 브랜치에서
- CLAUDE.md는 각자 로컬에서 생성
- custom/personal/은 공유하지 않음

### 머지 시
- 템플릿 변경사항 확인
- 커스텀 설정 충돌 확인

## 태그 및 릴리스

### 버전 태그
```bash
# Clauder 버전 태그
git tag -a clauder-v1.0.0 -m "Clauder template v1.0.0"
```

### 릴리스 노트
- 템플릿 변경사항
- 새 기능
- 버그 수정