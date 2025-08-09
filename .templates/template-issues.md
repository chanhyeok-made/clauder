---
doc_id: 825
---

# 템플릿 문제

## "템플릿 변수가 치환되지 않음"

### 증상
```
프로젝트 이름: {{PROJECT_NAME}}  # 그대로 출력됨
```

### 해결

1. **project.yaml 확인**
   ```yaml
   # .claude/custom/project.yaml
   project:
     name: "My Project"  # 이 값이 있는지 확인
   ```

2. **변수명 확인**
   - PROJECT_NAME (대문자)
   - 언더스코어 사용
   - 중괄호 2개 `{{ }}`

3. **재생성**
   ```
   /clauder generate
   ```

## 커스텀 변수 추가

### project.yaml에 정의
```yaml
custom_vars:
  API_VERSION: "v2"
  DATABASE: "PostgreSQL"
```

### 템플릿에서 사용
```markdown
API 버전: {{API_VERSION}}
데이터베이스: {{DATABASE}}
```

## 템플릿 오버라이드

### 우선순위
1. `.claude/custom/personal/`
2. `.claude/custom/overrides/`
3. `.claude/templates/`

### 오버라이드 확인
```
/clauder check --templates
```