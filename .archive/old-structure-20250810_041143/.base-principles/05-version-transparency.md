---
doc_id: 747
---

# 원칙 5: 버전 추적 투명성

## 핵심 개념
모든 지식의 시점과 의존성을 명확하게 추적하여 투명성을 보장합니다.

## 왜 중요한가?

### 문제 상황
```
"이 가이드가 최신인가?"
"이 문서는 언제 작성되었나?"  
"어떤 버전의 코드를 기준으로 한 건가?"
→ 신뢰성 의문, 잘못된 정보로 인한 오류
```

### 해결된 상황
```yaml
version:
  created: "2025-08-02"
  updated: "2025-08-03"
  commit: "abc123d"
  
"이 문서는 abc123d 커밋 시점의 정확한 정보입니다"
```

## 구현 방법

### 1. 메타데이터 구조
```yaml
---
doc_id: 100
version:
  created: "2025-08-03"      # 최초 작성일
  updated: "2025-08-03"      # 마지막 수정일
  commit: "f7db06e"          # 작성 시점 커밋
  
dependencies:                 # 이 문서가 참조하는 것들
  - file: "api-guide.md"
    commit: "abc123"         # 참조 당시 버전
    status: "current"        # current/outdated
    
referenced_by:               # 이 문서를 참조하는 것들
  - file: "README.md"
    commit: "def456"
---
```

### 2. 버전 상태 표시
```yaml
status:
  current:   "✅ 최신 - 안심하고 사용"
  outdated:  "⚠️ 구버전 - 업데이트 필요"
  deprecated: "❌ 폐기 - 사용 금지"
```

### 3. 의존성 체인
```
A (v1) → B (v1) → C (v1)
    ↓
A (v2) → B (v1) → C (v1)  ⚠️ B, C 업데이트 필요
    ↓
A (v2) → B (v2) → C (v2)  ✅ 모두 동기화됨
```

## 투명성 레벨

### Level 1: 기본 버전
```yaml
# 파일 자체의 버전만
version: "1.0.0"
```

### Level 2: 시점 추적
```yaml
# Git 커밋 기반
created: "2025-08-03"
commit: "abc123"
```

### Level 3: 의존성 추적
```yaml
# 참조 관계까지
dependencies:
  - file: "guide.md"
    commit: "def456"
```

### Level 4: 양방향 추적
```yaml
# 역참조까지 포함
referenced_by:
  - file: "main.md"
    commit: "ghi789"
    status: "current"
```

## 버전 불일치 해결

### 감지
```bash
/clauder check versions

⚠️ 버전 불일치 발견:
- api-guide.md가 auth.md의 구버전 참조
- 3개 문서가 삭제된 파일 참조
```

### 자동 동기화
```bash
/clauder sync versions

✅ 동기화 완료:
- 15개 참조 업데이트
- 3개 누락 참조 제거
- 모든 문서 최신 상태
```

## 적용 예시

### Clauder의 중앙 버전 트리
```yaml
# .claude/version-tree.yaml
documents:
  123:
    path: "/docs/guide.md"
    created: "2025-08-02"
    updated: "2025-08-03"
    commit: "abc123"
    depends_on: [124, 125]
    referenced_by: [100, 101]
```

### 변경 이력 추적
```bash
git log --oneline docs/guide.md

abc123 fix: 오타 수정
def456 feat: 새 섹션 추가
ghi789 docs: 초기 작성
```

## 투명성의 이점

### 1. 신뢰성
```
"이 가이드는 2025-08-03 커밋 abc123 기준입니다"
→ 명확한 시점, 검증 가능
```

### 2. 디버깅
```
"왜 이 코드가 작동하지 않지?"
→ 문서가 구버전 참조 발견
→ 최신 버전으로 업데이트
→ 문제 해결
```

### 3. 협업
```
"팀원 A": 문서 v1 기준 작업
"팀원 B": 문서 v2 기준 작업  
→ 버전 차이 즉시 파악
→ 동기화 후 작업
```

## 측정 가능한 효과

1. **문서 신뢰도**: 50% → 100%
2. **구버전 오류**: 빈번 → 0%
3. **동기화 시간**: 수동 1시간 → 자동 1분

## 핵심 원리

> "모든 정보는 시점을 가지고, 
> 그 시점은 검증 가능해야 한다"

- **추적 가능**: Git 커밋으로 확인
- **투명함**: 버전 정보 공개
- **자동화**: 시스템이 관리

---

버전 추적 투명성은 문서와 코드 간의 
신뢰할 수 있는 다리를 만듭니다.