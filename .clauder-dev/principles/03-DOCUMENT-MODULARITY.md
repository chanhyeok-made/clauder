---
doc_id: 3
---

## 핵심 규칙

### 단일 책임 원칙
- 한 문서 = 한 개념
- 긴 문서 금지
- 명확한 제목과 범위

### 참조 기반 구성
- 관련 내용은 참조로 연결
- 중복 내용 금지
- 계층적 구조 유지

## 실천 방법

1. **문서 작성 시**
   - 300줄 이하 유지
   - 하나의 주제만 다루기
   - 관련 문서 참조

2. **문서 분할 시**
   - 개념별로 파일 분리
   - 참조 구조로 연결
   - 네비게이션 제공

## 예시
```
principles/
├── 01-REFERENCE-STRUCTURE.md
├── 02-PROJECT-INDEPENDENCE.md
├── 03-DOCUMENT-MODULARITY.md
└── README.md (인덱스 역할)
```

## 관련 문서
- 참조 구조: @.claude/docs/principles/01-REFERENCE-STRUCTURE.md
