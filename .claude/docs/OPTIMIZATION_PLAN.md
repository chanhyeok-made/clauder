---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "initial"
---

# 📋 문서 최적화 계획 (모듈화 접근)

## 🎯 원칙: 통합이 아닌 분리와 참조

### 1. 중복 제거 대상

#### ❌ 삭제할 문서
1. `.claude/docs/README.md` - 단순 목차, 각 디렉토리에 분산
2. `.claude/docs/ASSESSMENT.md` - 일회성 평가, 필요시 재생성

#### ✂️ 중복 내용 제거
1. **명령어 문서들의 공통 부분**
   - 현재: 각 명령어마다 반복되는 설명
   - 개선: 공통 템플릿 참조
   ```markdown
   @[$command-common]  # 공통 사용법
   ## 이 명령어만의 기능
   ...
   ```

2. **예시의 중복**
   - EXAMPLES.md: 각 시나리오별 핵심만 유지
   - 상세 예시는 해당 기능 문서에서

### 2. 참조 구조 개선

#### 현재 문제
```markdown
# 긴 경로 반복
@[.claude/docs/design/VERSION_TRACKING.md]
@[.claude/docs/design/HOOKS.md]
@[.claude/docs/design/REFERENCE_STRATEGY.md]
```

#### 개선안
```yaml
# .claude/aliases-extended.yaml 추가
$design: ".claude/docs/design"
$guides: ".claude/docs/guides"

# 사용
@[$design/VERSION_TRACKING.md]
```

### 3. 선택적 로딩 최적화

#### 로딩 우선순위
```yaml
# config.yaml 개선
load_priority:
  1_always:  # 항상 (1,000 토큰)
    - instructions.md
    - LOADING_STRATEGY.md
    
  2_context:  # 컨텍스트별 (2,000 토큰)
    - "작업 중인 파일 관련 문서"
    
  3_command:  # 명령어 사용 시 (500 토큰/명령)
    - "해당 명령어 문서만"
    
  4_reference:  # 참조 시에만 (필요한 만큼)
    - design/*
    - guides/*
    - examples/*
```

### 4. 내용 최적화 (중복 제거)

#### TROUBLESHOOTING.md (246줄 → 100줄)
```markdown
# 변경 전
## Git 오류 상세 설명... (50줄)
## 해결 방법 상세... (50줄)

# 변경 후
## Git 오류
- 증상: `error: Git not found`
- 해결: `git init` 실행
- 참조: @[$guides/git-setup] (필요시만)
```

#### 명령어 문서 (각 100줄 → 30줄)
```markdown
# 공통 부분 추출
@[$commands/common/usage.md]
@[$commands/common/options.md]

# 고유 내용만
## 이 명령어의 특별한 기능
...
```

### 5. 새로운 구조

```
.claude/
├── core/              # 항상 로드 (최소)
│   ├── instructions.md
│   └── loading.md
├── commands/          # 명령어별 로드
│   ├── common/        # 공통 템플릿
│   └── *.md          # 각 명령어 (간소화)
├── docs/
│   ├── design/       # 필요시 로드
│   ├── guides/       # 필요시 로드
│   └── examples/     # 필요시 로드
└── templates/        # 생성 시에만
```

## 📊 예상 효과

### 현재
- 초기 로드: 15,000 토큰
- 모든 문서 포함
- 중복 내용 30%

### 최적화 후
- 초기 로드: 1,000 토큰 (핵심만)
- 필요시 추가: +500-1,000 토큰
- 중복 제거: 0%
- 총 절약: 85%

## 🔧 실행 순서 (안전하게)

1. **Phase 1: 준비**
   - 공통 템플릿 생성
   - 별칭 확장
   - 참조 구조 정리

2. **Phase 2: 내용 정리**
   - 중복 내용을 참조로 변경
   - 각 문서 역할 명확화
   - 예시 최소화

3. **Phase 3: 구조 조정**
   - 선택적 로딩 구현
   - 우선순위 설정

4. **Phase 4: 검증 후 정리**
   - 모든 참조 작동 확인
   - 불필요한 파일만 삭제

이렇게 하면 통합이 아닌 **모듈화**로 더 효율적인 구조가 됩니다!