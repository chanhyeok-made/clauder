---
doc_id: 100
---

프로젝트 요소 추가

## 고유 기능
```
add context <name>    # 새 컨텍스트 (템플릿 사용)
add override <file>   # 템플릿 오버라이드
add alias <name>      # 경로 별칭
```

## 상세 사용법

### context 추가
```
/clauder add context <name>
```
- `.claude/custom/contexts/<name>.md` 파일 생성
- `.claude/templates/contexts/context-template.md` 템플릿 사용
- 변수를 실제 값으로 채워서 생성

### override 추가
```
/clauder add override <template-name>
```
- `.claude/templates/core/<template-name>.template.md`를
- `.claude/custom/overrides/<template-name>.md`로 복사

### alias 추가
```
/clauder add alias <name> <path>
```
- `.claude/config.yaml`에 새 별칭 추가

## 예시
```
/clauder add context api-design
→ .claude/custom/contexts/api-design.md 생성 (템플릿 기반)

/clauder add override 01-essentials
→ 핵심 설정 템플릿을 커스터마이징할 수 있도록 복사

/clauder add alias $api "src/api"
→ @[$api] 형식으로 참조 가능
```

## 관련 문서
- 맥락 추가 가이드: @docs/guides/adding-contexts.md

@[$commands/common/usage-template.md]
