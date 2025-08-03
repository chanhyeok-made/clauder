---
doc_id: 703
---

# 토큰 최적화 학습 기록

## 상황
문서 참조 시 각 파일의 YAML front matter가 과도한 토큰을 사용하고 있었습니다.

## 초기 접근
```yaml
# 각 파일마다
---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "abc123"
dependencies:
  - file: "path/to/file1.md"
    commit: "def456"
  - file: "path/to/file2.md"
    commit: "ghi789"
references:
  - file: "path/to/ref1.md"
    commit: "jkl012"
---
```

## 문제점
- 파일당 평균 500토큰 사용
- 50개 파일 = 25,000토큰
- 중복 정보 다수
- 업데이트 시 모든 파일 수정 필요

## 개선된 해결책
```yaml
# 각 파일에는
---
doc_id: 301
---

# 중앙 트리에서 관리
documents:
  301:
    path: "path/to/file.md"
    created: "2025-08-02"
    updated: "2025-08-02"
    commit: "abc123"
    depends_on: [101, 102]
    referenced_by: [201, 202]
```

## 근본 원인
- 분산된 메타데이터 관리
- 정보의 중복 저장
- 파일 간 동기화 어려움

## 재발 방지
1. 중앙 집중식 메타데이터 관리 원칙 수립
2. doc_id 기반 참조 시스템 도입
3. 자동 동기화 도구 개발

## 결과
- 파일당 50토큰으로 감소 (90% 절감)
- 업데이트 용이성 향상
- 일관성 보장

## 적용된 문서
- [중앙 버전 트리 설계](../../tools/helpers/VERSION-TREE-GUIDE.md)
- [참조 구조 원칙 업데이트](../../principles/01-REFERENCE-STRUCTURE.md)