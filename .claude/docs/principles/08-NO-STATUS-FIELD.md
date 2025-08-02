---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "27af051"
  
dependencies:
  - file: ".claude/docs/principles/01-REFERENCE-STRUCTURE.md"
    commit: "27af051"
  - file: ".claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md"
    commit: "27af051"
    
references:
  - file: ".claude/docs/principles/README.md"
    commit: "27af051"
  - file: ".claude/instructions.md"
    commit: "11d1061"
---

# 원칙 8: Status 필드 제거

## 핵심 규칙

### Status 필드는 불필요
```yaml
# ❌ 잘못된 예시
dependencies:
  - file: "path/to/file.md"
    commit: "abc123"
    status: "current"  # 불필요!

# ✅ 올바른 예시
dependencies:
  - file: "path/to/file.md"
    commit: "abc123"
```

### 이유
1. **중복 정보**: commit hash만으로 버전 비교 가능
2. **관리 부담**: status 필드를 별도로 업데이트해야 함
3. **일관성 문제**: commit은 업데이트했지만 status는 놓칠 수 있음
4. **자동화 가능**: 스크립트로 commit hash 비교 가능

## 실천 방법

### 버전 확인 방법
```bash
# 의존성 문서의 현재 커밋 확인
git log -1 --format="%h" path/to/dependency.md

# YAML의 커밋과 비교
# 같으면 최신, 다르면 업데이트 필요
```

### 자동화 예시
```python
def check_dependency_version(dep_file, recorded_commit):
    current_commit = get_file_commit(dep_file)
    return current_commit == recorded_commit
```

## 마이그레이션

### 기존 문서 수정
1. 모든 `status: "current"` 제거
2. 모든 `status: "outdated"` 제거
3. commit hash만 남기기

## 장점
- 단순한 구조
- 자동화 용이
- 실수 가능성 감소
- 진실의 단일 소스 (Single Source of Truth)

## 관련 문서
- 참조 구조: @.claude/docs/principles/01-REFERENCE-STRUCTURE.md
- 역참조 시스템: @.claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md