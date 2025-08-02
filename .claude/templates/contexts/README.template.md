---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "f7db06e"
  
references:
  - file: ".claude/templates/CLAUDE.template.md"
    commit: "f7db06e"
---

# 상황별 가이드

필요한 상황에만 생성하세요. 모든 가이드가 필요한 것은 아닙니다.

## 📝 가이드 템플릿

새로운 상황별 가이드를 만들 때 이 구조를 사용하세요:

```markdown
# [상황] 가이드

## 언제 필요한가?
[이 가이드가 필요한 구체적 상황]

## 핵심 체크리스트
- [ ] [확인사항 1]
- [ ] [확인사항 2]

## 단계별 접근
1. [단계 1]
2. [단계 2]

## 자주 하는 실수
- [실수 1]: [해결법]
- [실수 2]: [해결법]

## 유용한 명령어/도구
[상황에 맞는 구체적 명령어]
```

## 🎯 권장 가이드 (필요시에만)

### 우선순위 높음
- `quick-fix.md` - 긴급 버그 수정
- `new-feature.md` - 새 기능 개발
- `debugging.md` - 디버깅 방법

### 우선순위 중간
- `refactoring.md` - 코드 개선
- `performance.md` - 성능 최적화
- `testing.md` - 테스트 작성

### 우선순위 낮음
- `documentation.md` - 문서 작성
- `migration.md` - 마이그레이션
- `security.md` - 보안 이슈

**원칙: 실제로 반복되는 상황이 생길 때만 가이드를 만드세요.**