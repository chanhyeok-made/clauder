---
doc_id: 852
---

# 자동화 스크립트

> Clauder 개발과 유지보수를 위한 자동화 스크립트들입니다.

## 📁 구조

- **check-documentation.sh**: 문서화 체크 스크립트
- **validate-references.sh**: 참조 검증 스크립트
- **update-version-tree.sh**: 버전 트리 업데이트
- **pre-commit-check.sh**: 커밋 전 검증
- **migrate-structure.sh**: 구조 마이그레이션

## 🔍 주요 내용

프로젝트의 일관성과 품질을 유지하기 위한 자동화 스크립트들입니다. CI/CD 파이프라인이나 Git 훅과 연동하여 사용할 수 있습니다.

## 🚀 주요 스크립트

### 1. 문서화 체크
```bash
./check-documentation.sh
# - 새 문서의 doc_id 확인
# - 버전 트리 등록 확인
# - commit 필드 검증
```

### 2. 참조 검증
```bash
./validate-references.sh
# - 모든 참조 유효성 확인
# - 순환 참조 탐지
# - 미사용 문서 식별
```

### 3. 자동 업데이트
```bash
./update-version-tree.sh [doc_id]
# - 버전 트리 자동 업데이트
# - 참조 관계 동기화
```

## 🔧 설정

대부분의 스크립트는 프로젝트 루트에서 실행되도록 설계되었습니다. 실행 권한 부여:

```bash
chmod +x .clauder-dev/tools/scripts/*.sh
```