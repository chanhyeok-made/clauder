# Clauder 정리 실행 계획

## 현황 분석 완료
- 총 256개 문서
- 실제 사용: 약 20-30개
- 나머지: 중복, 오래됨, 미사용

## 디렉토리별 액션

### 1. 즉시 삭제 (빈 디렉토리)
```bash
rm -rf runtime/ projects/ project-memory/ patterns/ insights/
rm -rf .emoji-backup-*
```

### 2. 아카이브로 이동 (거의 안 씀)
```bash
mkdir -p .archive
mv modules/ templates/ .archive/
```

### 3. 핵심 디렉토리 정리

#### .clauder-dev (112개 → 20개로)
- **유지**: principles/, learnings/, analysis/
- **정리**: 중복 제거, 오래된 것 아카이브

#### docs (46개 → 10개로)
- **유지**: README.md, 핵심 가이드
- **병합**: 비슷한 내용 통합

#### .claude (63개 → 30개로)
- **유지**: workflow/, validators/, hooks/
- **정리**: templates 중 미사용 제거

### 4. INDEX 파일 생성
```bash
for dir in .claude .clauder-dev .base-principles; do
  echo "Creating INDEX for $dir"
  create_index_file "$dir"
done
```

### 5. 참조 정리
```bash
# 깨진 참조 찾기
grep -r "@\." --include="*.md" | while read line; do
  # 참조 대상이 존재하는지 확인
done

# 자동 수정
fix_broken_references.sh
```

## 실행 순서

### Phase 1: 백업 (5분)
```bash
tar -czf clauder_backup_$(date +%Y%m%d_%H%M).tar.gz .
echo "Backup created"
```

### Phase 2: 정리 (10분)
```bash
# 1. 빈 디렉토리 삭제
rm -rf runtime/ projects/ project-memory/ patterns/ insights/

# 2. 아카이브 생성
mkdir -p .archive/$(date +%Y%m%d)
mv modules/ core/ .archive/$(date +%Y%m%d)/

# 3. 이모지 백업 삭제
rm -rf .emoji-backup-*
```

### Phase 3: INDEX 생성 (15분)
각 핵심 디렉토리에 INDEX.md 생성하여 네비게이션 개선

### Phase 4: 새 CLAUDE.md (5분)
CLAUDE_ROUTER.md를 기반으로 새로운 CLAUDE.md 생성

## 성공 지표
- [ ] 256개 → 100개 이하로 감소
- [ ] 모든 핵심 디렉토리에 INDEX.md
- [ ] 깨진 참조 0개
- [ ] Git 커밋으로 기록

## 위험 관리
- 백업 먼저 생성
- 단계별 확인
- 되돌리기 가능한 구조