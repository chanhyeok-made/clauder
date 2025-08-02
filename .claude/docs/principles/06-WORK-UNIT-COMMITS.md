---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "11d1061"
  
dependencies:
  - file: ".claude/docs/principles/01-REFERENCE-STRUCTURE.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md"
    commit: "11d1061"
    status: "current"
    
references:
  - file: ".claude/docs/principles/README.md"
    commit: "11d1061"
    status: "current"
  - file: ".claude/instructions.md"
    commit: "11d1061"
    status: "current"
---

# 원칙 6: 작업 단위 커밋

## 핵심 규칙

### 모든 작업은 작업 단위로 GitHub에 커밋
- 완성된 작업 단위마다 반드시 GitHub에 push
- 미완성 상태로 세션을 종료하지 않음
- 각 커밋은 독립적으로 의미 있는 변경사항 포함

### 커밋 전 필수 검증
1. **참조 상태 확인**: 모든 문서의 dependencies와 references 검증
2. **역참조 동기화**: 참조된 문서들의 최신 상태 확인
3. **문서 최신화**: 구버전 참조 발견 시 즉시 업데이트

## 실천 방법

### 작업 시작 전
```bash
# 참조 상태 확인
/clauder track check

# 구버전 발견 시 동기화
/clauder track sync
```

### 작업 완료 후
1. **변경된 모든 파일의 front matter 업데이트**
   - commit hash 최신화
   - updated 날짜 갱신
   - 새로운 dependencies/references 추가

2. **역참조 문서들 확인 및 업데이트**
   - 현재 문서를 참조하는 모든 문서 확인
   - 해당 문서들의 status를 "current"로 업데이트

3. **커밋 및 푸시**
   ```bash
   git add .
   git commit -m "작업 단위 설명"
   git push origin main
   ```

## 자동화 지원

### 훅 시스템 활용
- pre-commit: 참조 상태 자동 검증
- post-commit: 역참조 자동 업데이트
- push 전: 최종 일관성 확인

### 검증 명령어
```bash
# 전체 문서 일관성 검사
/clauder validate all

# 특정 문서 역참조 확인
/clauder validate refs <file>

# 커밋 전 자동 검증
/clauder pre-commit
```

## 예외 상황

### 긴급 상황 시
- 최소한의 작업 단위라도 커밋 필수
- TODO 마커로 미완성 부분 명시
- 다음 세션에서 즉시 이어서 작업

### 실험적 작업 시
- feature 브랜치 사용 허용
- 실험 완료 후 main으로 병합
- 병합 시에도 모든 검증 과정 적용

## 관련 문서
- 참조 구조: @.claude/docs/principles/01-REFERENCE-STRUCTURE.md
- 역참조 시스템: @.claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md