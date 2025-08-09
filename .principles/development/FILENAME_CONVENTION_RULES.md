---
doc_id: 734
---

# 📝 Clauder 파일명 컨벤션 규칙

## 기본 원칙
1. **가독성**: 파일명만으로 내용 파악 가능
2. **일관성**: 같은 종류는 같은 규칙
3. **검색성**: 패턴으로 쉽게 찾기

## 파일명 규칙

### 1. 특별 문서 (UPPER_CASE)
```
README.md         # 디렉토리 설명
INDEX.md          # 목록/색인
LICENSE.md        # 라이선스
CHANGELOG.md      # 변경 이력
```

### 2. 프로젝트 핵심 문서 (UPPER_CASE)
```
CLAUDE.md         # Claude Code 가이드
EXAMPLES.md       # 사용 예시
ARCHITECTURE.md   # 아키텍처
```

### 3. 일반 문서 (kebab-case)
```
quick-start.md           # 빠른 시작
interactive-setup.md     # 대화형 설정
troubleshooting.md      # 문제 해결
best-practices.md       # 모범 사례
```

### 4. 명령어 문서 (kebab-case)
```
clauder-start.md        # /clauder start
clauder-daily.md        # /clauder daily
clauder-check.md        # /clauder check
```

### 5. 원칙 문서 (번호-UPPER-CASE)
```
00-CONTINUOUS-LEARNING.md
01-REFERENCE-STRUCTURE.md
02-PROJECT-INDEPENDENCE.md
```

### 6. 템플릿 파일
```
claude.template.md              # 소문자 시작
context-example.template.md     # kebab-case
```

### 7. 임시 파일
```
temp-description-YYYYMMDD.md    # temp 접두사 + 날짜
draft-feature.md                # draft 접두사
```

### 8. 분석/보고서
```
PROJECT_STATUS_YYYYMMDD.md      # 대문자 + 날짜
CONVENTION_REVIEW_YYYYMMDD.md   # 대문자 + 날짜
```

## 디렉토리별 규칙

```
/docs/
  README.md                     # 필수, 대문자
  commands/clauder-*.md         # kebab-case
  guides/*.md                   # kebab-case
  templates/*.md                # kebab-case

/.clauder-dev/
  principles/NN-*.md            # 번호 체계
  learnings/*/*.md              # kebab-case
  analysis/*_YYYYMMDD.md        # 대문자 + 날짜
  temp/temp-*.md                # temp 접두사
```

## 변경 금지 목록
다음 파일들은 역사적/호환성 이유로 변경하지 않음:
- CLAUDE.md (브랜드)
- CLAUDE.base.md (페어링)
- 원칙 파일들의 번호 체계

## 마이그레이션 우선순위
1. guides 디렉토리 통일 (UPPER → kebab)
2. 루트의 일반 문서 (UPPER → kebab)
3. 참조 업데이트
4. 버전 트리 업데이트