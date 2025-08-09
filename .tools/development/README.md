---
doc_id: 851
---

# 헬퍼 도구

> 개발을 돕는 유틸리티 도구들입니다.

## 📁 구조

- **VERSION-TREE-GUIDE.md**: 버전 트리 작업 가이드
- **token-counter.sh**: 토큰 사용량 계산
- **reference-validator.sh**: 참조 유효성 검증
- **doc-id-generator.sh**: doc_id 생성기

## 🔍 주요 내용

반복적인 작업을 자동화하고, 실수를 방지하며, 개발 효율성을 높이는 작은 도구들의 모음입니다.

## 🛠️ 주요 헬퍼

### 1. 버전 트리 가이드
- 버전 트리 업데이트 절차
- 체크리스트와 템플릿 제공

### 2. 토큰 카운터
- 문서의 토큰 사용량 측정
- 최적화 대상 식별

### 3. 참조 검증기
- 깨진 참조 탐지
- 순환 참조 확인

### 4. ID 생성기
- 유일한 doc_id 자동 생성
- 충돌 방지

## 📌 사용 예시

```bash
# 토큰 수 확인
./token-counter.sh document.md

# 참조 검증
./reference-validator.sh

# 새 doc_id 생성
./doc-id-generator.sh
```