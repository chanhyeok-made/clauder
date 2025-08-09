# Clauder 재구조화 계획

## 문제
- 256개 문서 = 관리 불가능
- Context compact 시 작업 손실
- 실제로 작동하지 않는 시스템

## 해결 전략: 3-3-3 원칙

### 1. 3개 핵심 파일만
```
CLAUDE.md         # 진입점 (50줄 이내)
.claude/STATE.md  # 현재 상태 (자동 업데이트)
.claude/LEARN.md  # 학습 기록 (append-only)
```

### 2. 3단계 워크플로우
```
1. READ STATE  → 이전 작업 확인
2. DO WORK     → 작업 수행
3. SAVE STATE  → 상태 저장
```

### 3. 3가지 핵심 기능
```
1. 상태 유지 (State Persistence)
2. 학습 축적 (Learning Accumulation)
3. 타 프로젝트 적용 (Project Portability)
```

## 실행 계획

### Phase 1: 백업 및 정리
```bash
# 1. 현재 상태 백업
tar -czf clauder_backup_$(date +%Y%m%d).tar.gz .

# 2. 불필요한 것 제거
rm -rf modules/ projects/ runtime/ patterns/ insights/
rm -rf project-memory/ .emoji-backup-*

# 3. 핵심만 남기기
# 유지: .claude/, .clauder-dev/, .base-principles/
# 삭제: 나머지 전부
```

### Phase 2: 핵심 시스템 구축
```
CLAUDE.md
├─ 즉시 실행 섹션 (STATE 로드)
├─ 작업 규칙 (3단계)
└─ 학습 저장 규칙

.claude/STATE.md
├─ current_task
├─ completed_tasks[]
├─ pending_tasks[]
└─ last_updated

.claude/LEARN.md
├─ errors_solved[]
├─ patterns_found[]
└─ improvements[]
```

### Phase 3: 자동화
```bash
# Git hooks
.git/hooks/pre-commit  → STATE 업데이트
.git/hooks/post-commit → LEARN 추가

# Claude hooks
.claude/hooks/on-start.sh  → STATE 로드
.claude/hooks/on-work.sh    → 작업 추적
.claude/hooks/on-end.sh    → STATE 저장
```

## 성공 기준
1. Context compact 후에도 작업 이어가기 ✓
2. 3개 파일로 전체 시스템 운영 ✓
3. 다른 프로젝트에 즉시 적용 가능 ✓

## 우선순위
1. **즉시**: STATE.md 생성하여 현재 작업 기록
2. **다음**: 불필요한 문서 정리
3. **마지막**: 새 구조로 마이그레이션