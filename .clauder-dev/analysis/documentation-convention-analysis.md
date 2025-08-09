---
doc_id: 1003
---

# Clauder 문서화 컨벤션 현황 분석

## 핵심 문제: 컨벤션 일관성 부족

### 1. 파일명 컨벤션 혼재
```
현재 상황:
- UPPERCASE.md (CONVENTION_REVIEW_20250803.md)
- lowercase-kebab.md (adding-contexts.md)
- CamelCase.md (없음)
- 날짜 형식 불일치 (20250803 vs 2025-08-03)
```

### 2. 문서 구조 일관성 부족
```
A 스타일:
---
doc_id: 123
---
# 제목

B 스타일:
# 제목
메타데이터 없음

C 스타일:
---
doc_id: 123
version: 1.0.0
---
```

### 3. 참조 방식 불일치
```
- @.claude/workflow/README.md (@ 프리픽스)
- ../workflow/README.md (상대 경로)
- workflow/README.md (암묵적 상대 경로)
- [링크](파일) vs 파일명만
```

### 4. 디렉토리 구조 중복
```
.claude/guides/documentation/
.base-principles/documentation/
.clauder-dev/principles/08-DOCUMENTATION-STANDARDS.md
→ 문서화 관련 내용이 세 곳에 분산
```

## 명료성 문제

### 1. 추상적 지시
```
현재: "워크플로우를 따르세요"
개선: "TodoWrite로 다음 11개 항목 생성"
```

### 2. 참조만 있고 실행 없음
```
현재: @.claude/workflow/README.md 참조
개선: 구체적 액션 명시
```

### 3. 원칙의 중첩
```
- 기반 원칙 6개
- 개발 원칙 11개
- 프로젝트별 원칙 N개
→ 어느 것이 우선인지 불명확
```

## 효과성 부족

### 1. 수동적 문서
- 읽기만 가능
- 실행 불가능
- 검증 불가능

### 2. 피드백 루프 부재
- 원칙 준수 여부 확인 어려움
- 자동 검증 메커니즘 없음

### 3. 학습 축적 미흡
- learnings 디렉토리는 있으나 활용도 낮음
- 실수가 반복됨

## 제안하는 컨벤션 표준

### 1. 파일명 규칙
```
일반 문서: lowercase-kebab-case.md
분석 문서: analysis-{topic}-{YYYY-MM-DD}.md
학습 문서: learning-{topic}-{YYYY-MM-DD}.md
템플릿: {name}.template.md
```

### 2. 필수 문서 구조
```markdown
---
doc_id: {number}
version: {major.minor.patch}
last_updated: {YYYY-MM-DD}
---

# 제목

## 목적
한 문장으로 이 문서의 목적 설명

## 핵심 내용
- 구체적 지시
- 실행 가능한 명령
- 검증 가능한 체크리스트

## 참조
- 필수: 반드시 봐야 할 문서
- 선택: 추가 정보가 필요한 경우
```

### 3. 디렉토리 구조 단순화
```
.clauder/
├── conventions/      # 모든 컨벤션 통합
│   ├── documentation.md
│   ├── code.md
│   └── workflow.md
├── templates/        # 실제 사용할 템플릿
├── learnings/        # 학습 기록 (날짜별)
└── tools/           # 자동화 도구
```

### 4. 실행 가능한 문서
```markdown
## 실행 명령
\`\`\`bash
# 복사해서 바로 실행 가능
TodoWrite workflow_template
\`\`\`

## 체크리스트
- [ ] 자동 검증 가능한 항목
- [ ] 명확한 완료 기준
```

## 즉시 필요한 조치

1. **컨벤션 문서 통합**
   - 세 곳에 분산된 문서화 원칙 통합
   - 하나의 명확한 표준 수립

2. **CLAUDE.md 개선**
   - 참조 → 실행 가능한 지시
   - 추상적 → 구체적 명령

3. **자동 검증 도구**
   - 컨벤션 준수 체크 스크립트
   - Git hooks 활용

4. **학습 시스템 강화**
   - 모든 실수를 learnings에 기록
   - 주기적 리뷰 및 원칙 업데이트

## 기대 효과

- **일관성**: 모든 문서가 동일한 형식
- **명료성**: 구체적이고 실행 가능한 지시
- **효과성**: 자동 검증으로 품질 보장
- **지속성**: 학습이 축적되어 개선 지속