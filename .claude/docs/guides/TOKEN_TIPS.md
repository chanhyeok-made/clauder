---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "initial"
---

# 💡 토큰 절약 팁

## 🎯 즉시 적용 가능한 팁

### 1. 별칭 사용
```markdown
❌ @[.claude/docs/design/VERSION_TRACKING.md]
✅ @[$version-design]
```
→ 70% 토큰 절약

### 2. 간단한 명령어 표기
```markdown
❌ 다음 명령어를 실행하세요:
   /clauder initialize
   이 명령어는 프로젝트를 초기화합니다.

✅ `/clauder initialize` - 프로젝트 초기화
```
→ 60% 토큰 절약

### 3. 중복 설명 제거
```markdown
❌ Git 상태를 확인하려면 git status를 사용하세요.
   Git 상태 확인은 중요합니다.

✅ `git status` - Git 상태 확인
```
→ 50% 토큰 절약

## 🚀 Claude 사용 시

### 1. 구체적인 요청
```
❌ "코드를 개선해줘"
✅ "이 함수의 성능을 최적화해줘"
```

### 2. 컨텍스트 제한
```
❌ "전체 프로젝트를 분석해줘"
✅ "src/auth 모듈을 분석해줘"
```

### 3. 필요한 정보만
```
❌ 모든 파일 내용 포함
✅ 관련 파일만 참조
```

## 📊 효과

이러한 최적화로:
- 대화 길이 40% 증가
- 복잡한 작업 처리 가능
- 더 빠른 응답 속도