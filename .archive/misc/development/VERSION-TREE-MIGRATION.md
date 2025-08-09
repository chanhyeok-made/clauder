---
doc_id: 301
---

# 버전 트리 마이그레이션 가이드

## 핵심 질문과 해결책

### 1. 트리에 누락되지 않도록 방지하는 방법

#### 자동 감지 메커니즘
1. **Git Hooks**
   ```bash
   # .git/hooks/pre-commit
   python3 .claude/scripts/tree-sync.py
   ```

2. **Claude 지시사항**
   ```yaml
   # 새 파일 생성 시 자동으로 트리에 추가
   AFTER Write .md file:
     - Run: tree-sync.py
     - Add doc_id to file
   ```

3. **주기적 검증**
   ```bash
   /clauder tree validate  # 누락 검사
   /clauder tree sync     # 자동 동기화
   ```

#### 실시간 모니터링
- 파일 시스템 감시 (fswatch/inotify)
- VS Code 확장으로 자동 감지
- CI/CD 파이프라인에서 검증

### 2. 기존 메타데이터 처리 전략

#### 3단계 전환 계획

**Stage 1: 공존 (현재~1개월)**
```yaml
---
doc_id: 998  # 새로운 방식 (예시)
version:   # 기존 방식 유지
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "abc123"
dependencies:  # 기존 방식 유지
  - file: "path/to/file.md"
references:    # 기존 방식 유지
  - file: "path/to/ref.md"
---
```
- 두 시스템 병행 운영
- 트리는 기존 메타데이터에서 자동 생성
- 충돌 시 트리가 우선

**Stage 2: 트리 우선 (1~3개월)**
```yaml
---
doc_id: 998  # 예시
# 아래는 읽기 전용 (업데이트 안 함)
version:
  created: "2025-08-02"  # deprecated
  updated: "2025-08-02"  # deprecated
---
```
- 트리가 진실의 원천
- 문서 메타데이터는 참고용
- 새 문서는 doc_id만 포함

**Stage 3: 완전 마이그레이션 (3개월 후)**
```yaml
---
doc_id: 998  # 이것만! (예시)
---
```
- 모든 버전 정보는 트리에서
- 레거시 메타데이터 제거
- 완전한 토큰 최적화

## 마이그레이션 도구

### tree-sync.py
```bash
# 전체 동기화
python3 .claude/scripts/tree-sync.py

# 기능:
- 모든 .md 파일 스캔
- 트리에 없는 파일 자동 추가
- 기존 메타데이터 → 트리로 마이그레이션
- doc_id 할당 및 제안
```

### 일괄 변환 스크립트
```bash
# Stage 2로 전환
/clauder migrate to-stage2

# Stage 3로 전환
/clauder migrate to-stage3
```

## 모범 사례

### DO ✅
1. 새 파일은 처음부터 doc_id만 사용
2. 트리 동기화를 정기적으로 실행
3. 커밋 전 트리 검증
4. 팀원들에게 전환 계획 공유

### DON'T ❌
1. 수동으로 doc_id 할당 (충돌 위험)
2. 트리 없이 문서만 수정
3. 급격한 전환 (점진적으로)
4. 백업 없이 마이그레이션

## 문제 해결

### "doc_id가 없는 파일 발견"
```bash
python3 .claude/scripts/tree-sync.py
# doc_id 제안 목록 확인 후 파일에 추가
```

### "트리와 문서 정보 불일치"
```bash
# 트리를 기준으로 재동기화
/clauder tree sync --force
```

### "순환 참조 발견"
```bash
python3 .claude/scripts/version-tree-manager.py status
# 순환 참조 체인 확인 후 수정
```

## 장기 로드맵

1. **자동화 강화** (1개월)
   - VS Code 확장 개발
   - 실시간 동기화

2. **시각화 도구** (2개월)
   - 의존성 그래프
   - 버전 히스토리

3. **완전 마이그레이션** (3개월)
   - 레거시 제거
   - 성능 최적화

이 가이드를 따라 안전하고 효율적으로 새로운 버전 트리 시스템으로 전환할 수 있습니다.