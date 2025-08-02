---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "8b8a539"
---

# 문서 참조 개선 전략

## 🎯 목표
- 참조 방식 통일
- 버전 추적 일관성
- 유지보수 용이성

## 📐 제안하는 새로운 참조 시스템

### 1. 통합 참조 문법
```markdown
<!-- 기본 참조 -->
@[경로]

<!-- 버전 명시 참조 -->
@[경로]#[커밋해시]

<!-- 조건부 참조 -->
@[경로1|경로2]  <!-- 첫 번째 존재하는 파일 사용 -->
```

### 2. 경로 별칭 시스템
`.claude/aliases.yaml`:
```yaml
aliases:
  $core: ".claude/templates/core"
  $custom: ".claude/custom"
  $commands: ".claude/commands"
  $hooks: ".claude/hooks"
```

사용 예:
```markdown
@[$core/work-principles.template.md]
@[$custom/overrides/work-principles.md|$core/work-principles.template.md]
```

### 3. 자동 버전 추적
```markdown
<!-- 작성 시 -->
@[.claude/core/principles.md]

<!-- 자동 변환 후 -->
@[.claude/core/principles.md]#abc123d
```

### 4. 중앙 참조 레지스트리
`.claude/references.yaml`:
```yaml
references:
  work-principles:
    default: "$core/02-work-principles.template.md"
    override: "$custom/overrides/02-work-principles.md"
    version: "f7db06e"
    
  dev-principles:
    default: "$core/03-dev-principles.template.md"
    override: "$custom/overrides/03-dev-principles.md"
    version: "f7db06e"
```

사용:
```markdown
@[ref:work-principles]  <!-- 자동으로 override 확인 -->
```

## 🔧 구현 방법

### Phase 1: 참조 파서
```python
class ReferenceParser:
    def parse(self, content):
        # @[경로] 패턴 찾기
        # 별칭 해석
        # 버전 정보 추가
        # 조건부 처리
```

### Phase 2: 훅 통합
```bash
# pre-commit hook에 추가
update_references() {
    # 모든 @[] 참조 찾기
    # 현재 커밋 해시 추가
    # references.yaml 업데이트
}
```

### Phase 3: 명령어 지원
```
/clauder ref check    # 참조 일관성 확인
/clauder ref update   # 참조 업데이트
/clauder ref graph    # 참조 그래프 생성
```

## 📊 장점 비교

| 항목 | 현재 방식 | 개선된 방식 |
|------|----------|------------|
| 버전 추적 | 일부만 | 모든 참조 |
| 경로 관리 | 중복/불일치 | 별칭으로 통일 |
| 조건부 참조 | 복잡한 문법 | 간단한 OR 연산자 |
| 유지보수 | 수동 | 자동화 |
| 가독성 | 보통 | 높음 |

## 🚀 마이그레이션 계획

### 1단계: 호환성 모드
- 기존 @ 참조와 새 @[] 참조 동시 지원
- 점진적 변환

### 2단계: 자동 변환
```
/clauder migrate references
```
- 모든 @ 참조를 @[] 형식으로 변환
- 별칭 적용
- 버전 정보 추가

### 3단계: 검증
- 모든 참조 작동 확인
- 순환 참조 검사
- 누락된 파일 확인

## 💡 추가 개선 아이디어

### 1. 참조 캐싱
```yaml
.claude/.cache/references/
├── work-principles.md.cache
└── work-principles.md.meta
```

### 2. 참조 통계
```
/clauder ref stats

가장 많이 참조된 문서:
1. work-principles.md (15회)
2. dev-principles.md (12회)
3. essentials.md (10회)
```

### 3. 스마트 참조
```markdown
@[smart:error-handling]  <!-- 컨텍스트에 따라 최적 문서 선택 -->
```

## 🎯 기대 효과

1. **일관성**: 모든 참조가 동일한 형식
2. **추적성**: 모든 참조에 버전 정보
3. **유연성**: 조건부/스마트 참조
4. **자동화**: 수동 관리 최소화
5. **확장성**: 새로운 참조 타입 쉽게 추가

---

이 전략을 통해 Clauder의 문서 참조 시스템을 더욱 강력하고 효율적으로 만들 수 있습니다.