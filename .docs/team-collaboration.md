---
doc_id: 817
---

# 팀 협업

## 공유 전략

### 템플릿 공유
- `.claude/templates/`는 모든 팀원 동일
- Git에 포함되어 모두가 같은 기반 사용

### 프로젝트 설정
- `.claude/custom/project.yaml`은 공유
- 프로젝트 공통 설정 포함

### 개인 설정
- `.claude/custom/personal/` 사용
- gitignore에 포함되어 개인별 관리

## 설정 구조

```
.claude/custom/
├── project.yaml      # 팀 공통 (공유)
├── overrides/        # 프로젝트 커스텀 (공유)
└── personal/         # 개인 설정 (gitignore)
    ├── preferences.yaml
    └── workflows.md
```

## 협업 워크플로우

### 1. 초기 설정
```bash
# 팀 리더가 설정
git clone [repo]
cd [project]
/clauder start
```

### 2. 팀원 참여
```bash
# 클론 후
git pull
/clauder initialize --personal
```

### 3. 개인 설정
```yaml
# .claude/custom/personal/preferences.yaml
preferred_language: "ko"
code_style: "verbose"
comment_style: "detailed"
```

## 충돌 방지

### CLAUDE.md
- `.gitignore`에 포함
- 각자 로컬에서 생성
- 충돌 없음

### 커스텀 설정
- 개인 설정은 personal/에만
- 프로젝트 설정은 project.yaml에
- 명확한 분리

## 베스트 프랙티스

1. **문서화 규칙 통일**
2. **커밋 메시지 형식 통일**
3. **정기적인 템플릿 업데이트**
4. **개인 설정과 프로젝트 설정 분리**