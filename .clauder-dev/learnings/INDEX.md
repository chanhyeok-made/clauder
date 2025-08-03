---
doc_id: 702
---

# 학습 기록 인덱스

Clauder 프로젝트를 개발하면서 배운 교훈과 개선사항을 기록합니다.

## 📚 카테고리별 학습 내용

### 오류 패턴 (Error Patterns)
- [current 커밋 안티패턴](error-patterns/current-commit-antipattern.md)
- [원칙 번호 중복](error-patterns/principle-numbering-conflict.md)
- [재발 방지 대책 누락](error-patterns/missing-prevention-measures.md)
- [순환 참조 방지](error-patterns/circular-references.md)

### 최적화 (Optimizations)
- [중앙 버전 트리 시스템](optimization/central-version-tree.md)
- [doc_id 기반 참조](optimization/doc-id-references.md)

### 사용자 피드백 (User Feedback)
- [문서 톤 개선](user-feedback/documentation-tone.md)
- [디렉토리 구조 분리](user-feedback/directory-separation.md)

## 🔄 최근 학습 내용

### 2025-08-03: 중앙 버전 트리 도입
- **문제**: 각 파일의 메타데이터로 인한 토큰 과다 사용
- **해결**: 중앙 집중식 버전 트리로 90% 토큰 절감
- **교훈**: 분산된 정보는 중복을 만들고 관리를 어렵게 함

### 2025-08-03: 전문적 문서 작성
- **문제**: 과도한 경고 메시지와 느낌표
- **해결**: 간결하고 전문적인 톤으로 통일
- **교훈**: 강조는 구조와 형식으로, 과도한 장식은 역효과

### 2025-08-03: 사용자/개발자 문서 분리
- **문제**: 문서의 대상이 불분명
- **해결**: docs/ (사용자용), .clauder-dev/ (개발자용) 분리
- **교훈**: 명확한 대상 설정이 문서 품질을 높임

### 2025-08-03: "current" 커밋 해시 금지
- **문제**: commit 값으로 "current" 사용
- **해결**: 항상 실제 커밋 해시 사용
- **교훈**: 명확성과 추적 가능성이 편의보다 중요
- **상세**: [current 커밋 안티패턴](error-patterns/current-commit-antipattern.md)

### 2025-08-03: 원칙 번호 중복 및 재발 방지
- **문제**: 0번 원칙 2개 생성, 재발 방지책 미수립
- **해결**: 원칙 레지스트리 생성, 학습 템플릿 강화
- **교훈**: 문제 해결과 재발 방지는 별개, 둘 다 필수
- **상세**: [원칙 번호 중복](error-patterns/principle-numbering-conflict.md), [재발 방지 누락](error-patterns/missing-prevention-measures.md)

## 📈 개선 추이

1. **토큰 사용량**: 파일당 500토큰 → 50토큰 (90% 감소)
2. **문서 가독성**: 경고 제거로 전문성 향상
3. **구조 명확성**: 디렉토리 분리로 혼란 제거

## 🎯 적용된 원칙

학습 내용이 다음 원칙들로 발전했습니다:

1. [원칙 0: 지속적 학습과 개선](../principles/00-CONTINUOUS-LEARNING.md)
2. [원칙 1: 완벽한 참조 구조](../principles/01-REFERENCE-STRUCTURE.md) - 중앙 트리 통합
3. [원칙 8: 문서 작성 기준](../principles/08-DOCUMENTATION-STANDARDS.md)

## 💡 미래 개선 방향

- 자동 학습 기록 시스템
- 패턴 인식 자동화
- 학습 내용의 자동 문서 반영