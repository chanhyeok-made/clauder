---
doc_id: 1004
---

# Clauder 토큰 최적화 및 구조 개선 제안

## 핵심 전략 관점에서 현재 문제점

### 1. 재사용성 저해 요인
```
문제: 같은 내용이 여러 파일에 중복
예시:
- .claude/guides/documentation/
- .base-principles/documentation/  
- .clauder-dev/principles/08-DOCUMENTATION-STANDARDS.md
→ 3곳에 분산된 문서화 원칙

영향: 수정 시 3곳 모두 업데이트 필요
```

### 2. 모듈화 실패
```
문제: 하나의 문서가 너무 많은 책임
예시: CLAUDE.md (50줄 → 모든 것을 포함)
- 워크플로우 전체
- 원칙 참조
- 프로젝트 정보
- 개발 가이드

영향: 간단한 작업도 전체 문서 로드
```

### 3. 토큰 낭비 원인
```
1. version-tree.yaml: 1,473줄 (40KB)
   → 매번 전체 로드
2. @ 참조: 212개
   → 각 참조마다 파일 읽기
3. 중복 내용: 30% 이상
   → 같은 내용 반복 로드
```

### 4. 버전 관리 비효율
```
문제: 중앙집중식 거대 파일
- 모든 문서 정보가 한 파일에
- 실제 git 커밋과 동기화 안 됨
- 수동 업데이트 필요
```

## 제안하는 개선안

### 1. 극단적 모듈화 - "One Concept, One File"

```
AS-IS: CLAUDE.md (모든 것 포함)
TO-BE: 
CLAUDE.md (10줄) → 
  - workflow.md (실행 명령만)
  - principles.md (우선순위만)
  - context.md (현재 작업만)
```

#### 새로운 CLAUDE.md 구조
```markdown
---
doc_id: 1000
---

# Clauder

## 현재 작업
@.claude/context/current.md

## 필수 실행
@.workflow/core/execute.md

## 원칙 우선순위
@.principles/usage/priority.md
```

### 2. 참조 최적화 - "Load on Demand"

#### 참조 레벨 시스템
```
Level 0: 즉시 필요 (CLAUDE.md에만)
Level 1: 작업 시작 시 (workflow)
Level 2: 특정 작업 시 (guides)
Level 3: 문제 발생 시 (troubleshooting)
```

#### 참조 메타데이터
```markdown
---
doc_id: 100
load_priority: 0  # 0=즉시, 1=작업시, 2=필요시, 3=문제시
dependencies: [101, 102]  # 함께 로드할 문서
cache_ttl: 3600  # 캐시 유지 시간(초)
---
```

### 3. 버전 트리 분산화

#### AS-IS: 단일 version-tree.yaml
```yaml
# 1,473줄의 거대 파일
documents:
  - id: 1
    path: ...
    version: ...
  # ... 150개 문서
```

#### TO-BE: 디렉토리별 .tree.yaml
```
.claude/
  .tree.yaml     # .claude/ 문서만
.clauder-dev/
  .tree.yaml     # .clauder-dev/ 문서만
.base-principles/
  .tree.yaml     # 원칙 문서만
```

각 트리 파일:
```yaml
# 20-30줄
parent: root
documents:
  - id: 100
    file: README.md
    hash: abc123  # git hash-object
```

### 4. 자동 참조 압축

#### 참조 번들링
```markdown
AS-IS:
@.workflow/core/01-analysis.md
@.workflow/core/02-implementation.md
@.workflow/core/03-retrospective.md
@.workflow/core/04-documentation.md
@.workflow/core/05-commit.md

TO-BE:
@.workflow/core/*  # 자동 번들 로드
```

### 5. 컨텍스트 압축 시스템

```python
# context-optimizer.py
def optimize_context(files):
    """필요한 부분만 추출"""
    context = {}
    for file in files:
        # 1. 메타데이터만 추출
        context[file] = extract_metadata(file)
        # 2. 현재 작업 관련 섹션만
        if is_relevant(file):
            context[file] += extract_relevant_sections(file)
    return compress(context)
```

### 6. 실행 가능한 최소 단위

```markdown
# .claude/workflow/execute.md
---
doc_id: 800
load_priority: 0
---

## 즉시 실행
```bash
TodoWrite << EOF
1. 분석: 명확한가?
2. 구현: 시작
3. 회고: 문제?
4. 문서화: 필요?
5. 커밋: 저장
EOF
```
```

## 구현 우선순위

### Phase 1 (즉시)
1. CLAUDE.md를 10줄로 축소
2. 워크플로우를 실행 명령으로 변경
3. 중복 문서 통합

### Phase 2 (단기)
1. 분산 버전 트리 구현
2. 참조 레벨 시스템 도입
3. 자동 번들링 스크립트

### Phase 3 (중기)
1. 컨텍스트 압축기 개발
2. 캐싱 시스템 구현
3. 의존성 자동 관리

## 기대 효과

### 토큰 절감
- CLAUDE.md: 50줄 → 10줄 (80% 감소)
- version-tree: 1,473줄 → 100줄 (93% 감소)
- 전체 컨텍스트: 60-70% 감소

### 성능 향상
- 필요한 것만 로드
- 캐싱으로 반복 로드 방지
- 병렬 로드 가능

### 유지보수성
- 각 파일이 단일 책임
- 자동 동기화
- 명확한 의존성

## 측정 지표

```bash
# 토큰 사용량 측정
before=$(wc -w < CLAUDE.md)
after=$(wc -w < CLAUDE.md.new)
reduction=$((100 * (before - after) / before))
echo "토큰 감소율: ${reduction}%"
```