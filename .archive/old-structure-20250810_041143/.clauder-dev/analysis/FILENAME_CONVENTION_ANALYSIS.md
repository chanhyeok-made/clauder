---
doc_id: 733
---

# 파일명 컨벤션 분석 보고서

## 현재 상황

### 1. 사용되는 컨벤션 종류
1. **UPPER_CASE.md** (28개)
   - README.md, INDEX.md 등 주요 문서
   - troubleshooting.md, capabilities.md 등 가이드
   
2. **kebab-case.md** (35개) 
   - clauder-*.md 명령어 문서
   - 학습 기록, 헬퍼 문서
   
3. **번호-UPPER-CASE.md** (8개)
   - 원칙 문서 (01-REFERENCE-STRUCTURE.md)
   
4. **혼합 형식** (15개)
   - VERSION-TREE.md (하이픈+대문자)
   - temp-*-날짜.md (임시 파일)

### 2. 디렉토리별 일관성

#### ❌ 일관성 없음
- `/docs/guides/`: UPPER와 kebab 혼재
  - capabilities.md vs adding-contexts.md
  
- `/docs/`: README.md(UPPER) + 명령어들(kebab)

#### ✅ 일관성 있음
- `/docs/commands/`: 모두 kebab-case (clauder-*.md)
- `/.clauder-dev/principles/`: 번호 체계 일관됨
- `/.clauder-dev/learnings/`: 모두 kebab-case

## 문제점

1. **명확한 규칙 부재**
   - 언제 UPPER_CASE를 쓸지
   - 언제 kebab-case를 쓸지
   - 혼합은 언제 허용되는지

2. **같은 디렉토리 내 불일치**
   - guides 디렉토리가 가장 심함

3. **특수 케이스 처리**
   - 템플릿 파일: *.template.md
   - 임시 파일: temp-*-날짜.md
   - 베이스 파일: CLAUDE.base.md

## 권장 컨벤션

### 1. 기본 규칙
```
# 인덱스/주요 문서
README.md
INDEX.md
LICENSE.md

# 일반 문서
kebab-case.md

# 템플릿
kebab-case.template.md

# 임시 파일
temp-kebab-case-YYYYMMDD.md
```

### 2. 디렉토리별
```
/docs/
  README.md              # 인덱스는 대문자
  guides/
    *.md                 # 모두 kebab-case로 통일
  commands/
    clauder-*.md         # 현재 잘 되어있음
    
/.clauder-dev/
  principles/
    NN-UPPER-CASE.md     # 번호 체계 유지
  learnings/
    *.md                 # kebab-case 유지
```

### 3. 특수 파일
```
# 프로젝트 루트
CLAUDE.md               # 특별한 의미 - 대문자 유지
README.md               # 표준 - 대문자 유지
EXAMPLES.md             # 주요 문서 - 대문자 유지

# 나머지는 kebab-case
quick-start.md (not quick-start.md)
interactive-setup.md (not interactive-setup.md)
```

## 실행 계획

### Phase 1: guides 디렉토리 통일
```bash
mv capabilities.md capabilities.md
mv troubleshooting.md troubleshooting.md  
mv workflows.md workflows.md
```

### Phase 2: 루트 문서 정리
```bash
mv quick-start.md quick-start.md
mv interactive-setup.md interactive-setup.md
```

### Phase 3: 컨벤션 문서화
`.claude/docs/conventions/FILENAME_CONVENTIONS.md` 생성

## 영향도
- 변경 필요 파일: 약 10-15개
- 참조 업데이트 필요: 약 20-30곳
- 버전 트리 업데이트 필요