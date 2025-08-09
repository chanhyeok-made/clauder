# Clauder 문서 마이그레이션 분석

## 🎯 목표: 삭제 없이 재구조화
유의미한 내용을 보존하면서 체계적으로 재편성

## 📊 현재 구조 분석 (256개 문서)

### 1. 디렉토리별 분포
```
.clauder-dev/    112개  (개발 관련)
.claude/          63개  (사용자 설정)
docs/             46개  (문서화)
.base-principles/ 23개  (기반 원칙)
core/              3개  (핵심 시스템)
modules/           2개  (모듈)
templates/         1개  (템플릿)
---
빈 디렉토리:      7개
```

## 🔍 내용별 분류

### A. 원칙/철학 (Principles)
- `.base-principles/` - 기반 원칙
- `.clauder-dev/principles/` - 개발 원칙
- `.claude/principles/` - 사용 원칙
→ **통합 필요**: 3곳에 분산된 원칙들

### B. 워크플로우 (Workflow)
- `.claude/workflow/` - 5단계 프로세스
- `.clauder-dev/workflow/` - 개발 워크플로우
- `docs/guides/workflows.md` - 워크플로우 가이드
→ **통합 필요**: 중복된 워크플로우 설명

### C. 학습/기록 (Learning)
- `.clauder-dev/learnings/` - 학습 기록
- `.clauder-dev/analysis/` - 분석 문서
- `insights/` - 인사이트 (빈 디렉토리)
- `patterns/` - 패턴 (빈 디렉토리)
→ **병합 가능**: 학습 관련 모두 한 곳으로

### D. 도구/자동화 (Tools)
- `.claude/tools/` - 도구 설정
- `.claude/validators/` - 검증 도구
- `.claude/hooks/` - 자동화 훅
- `.clauder-dev/tools/` - 개발 도구
→ **재구성 필요**: 용도별로 분류

### E. 템플릿 (Templates)
- `.claude/templates/` - Claude 템플릿
- `templates/` - 프로젝트 템플릿
- `core/templates/` - 코어 템플릿
→ **통합 필요**: 한 곳으로 모으기

### F. 문서화 (Documentation)
- `docs/` - 사용자 문서
- `README.md` 파일들 - 각 디렉토리 설명
→ **정리 필요**: 중복 제거, 체계화

## 🏗️ 제안하는 새 구조

```
clauder/
├── CLAUDE.md              # 메인 진입점
├── STATE.md               # 현재 상태
│
├── .principles/           # 모든 원칙 통합
│   ├── INDEX.md
│   ├── base/             # 기반 원칙
│   ├── development/      # 개발 원칙
│   └── usage/            # 사용 원칙
│
├── .workflow/            # 워크플로우 통합
│   ├── INDEX.md
│   ├── core/            # 5단계 프로세스
│   ├── automation/      # 자동화
│   └── patterns/        # 패턴
│
├── .learning/           # 학습 시스템 통합
│   ├── INDEX.md
│   ├── lessons/        # 배운 것들
│   ├── analysis/       # 분석 문서
│   └── patterns/       # 발견한 패턴
│
├── .tools/             # 도구 통합
│   ├── INDEX.md
│   ├── validators/     # 검증
│   ├── hooks/         # 자동화
│   └── scripts/       # 스크립트
│
├── .templates/        # 템플릿 통합
│   ├── INDEX.md
│   ├── project/      # 프로젝트 초기화
│   ├── document/     # 문서 템플릿
│   └── code/         # 코드 템플릿
│
└── .archive/         # 오래된/미사용 (but 보존)
    ├── legacy/
    └── deprecated/
```

## 📋 마이그레이션 매핑

### Phase 1: 원칙 통합
```
.base-principles/*        → .principles/base/
.clauder-dev/principles/* → .principles/development/
.claude/principles/*      → .principles/usage/
```

### Phase 2: 워크플로우 통합
```
.claude/workflow/*        → .workflow/core/
.clauder-dev/workflow/*   → .workflow/development/
docs/guides/workflows.md  → .workflow/guides/
```

### Phase 3: 학습 시스템 통합
```
.clauder-dev/learnings/*  → .learning/lessons/
.clauder-dev/analysis/*   → .learning/analysis/
insights/* patterns/*     → .learning/patterns/
```

### Phase 4: 도구 통합
```
.claude/tools/*          → .tools/core/
.claude/validators/*     → .tools/validators/
.claude/hooks/*          → .tools/hooks/
.clauder-dev/tools/*     → .tools/development/
```

### Phase 5: 템플릿 통합
```
.claude/templates/*      → .templates/claude/
templates/*              → .templates/project/
core/templates/*         → .templates/core/
```

## 🔄 마이그레이션 프로세스

### 1. 콘텐츠 분석 (자동화)
```python
# analyze_content.py
for file in all_markdown_files:
    - 내용 해시 생성
    - 유사도 측정
    - 카테고리 자동 분류
    - 중복 감지
```

### 2. 병합 규칙
- **동일 내용**: 하나만 유지, 나머지는 참조로 대체
- **유사 내용**: 병합 후 섹션으로 구분
- **보완 관계**: 하나의 문서로 통합
- **독립 내용**: 그대로 마이그레이션

### 3. 참조 자동 업데이트
```bash
# update_references.sh
OLD_PATH="@.principles/development/"
NEW_PATH="@.principles/development/"
find . -name "*.md" -exec sed -i "s|$OLD_PATH|$NEW_PATH|g" {} \;
```

### 4. 검증
```bash
# validate_migration.sh
- 모든 파일이 이동되었는지 확인
- 참조가 올바른지 검증
- 내용 손실이 없는지 체크
```

## ✅ 장점
1. **내용 보존**: 삭제 없이 재구성
2. **체계화**: 명확한 카테고리
3. **중복 제거**: 자동 병합
4. **참조 유지**: 자동 업데이트
5. **되돌리기 가능**: .archive에 백업

## 🚀 실행 계획

### Step 1: 분석 스크립트 실행 (10분)
```bash
python3 analyze_documents.py > migration_map.json
```

### Step 2: 마이그레이션 검토 (10분)
- migration_map.json 검토
- 병합 대상 확인
- 특별 처리 필요한 문서 식별

### Step 3: 마이그레이션 실행 (20분)
```bash
./execute_migration.sh migration_map.json
```

### Step 4: 검증 (10분)
```bash
./validate_migration.sh
```

## 📝 특별 고려사항

### 보존해야 할 중요 문서
- 모든 learning/analysis 문서 (경험과 인사이트)
- 커스터마이징된 설정 파일
- 프로젝트별 특화 내용

### 병합 시 주의사항
- 작성자 정보 보존
- 날짜 정보 유지
- 버전 히스토리 기록

이 방식으로 진행하면 **내용은 보존하면서 구조는 개선**됩니다.