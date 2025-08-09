---
doc_id: 3004
---

# 문서화 프로세스

## Version Tree 업데이트

### 왜 중요한가?
- 모든 문서의 버전과 의존성 추적
- 토큰 효율성 (ID 참조로 중복 제거)
- 문서 간 관계 명확화

### 자동 업데이트 프로세스

#### 1. 변경사항 감지
```bash
.claude/tools/simple-tree-update.sh detect
```
- 새 문서 자동 발견
- 수정된 파일 추적
- 카테고리 자동 분류

#### 2. 메타데이터 업데이트
```bash
.claude/tools/simple-tree-update.sh update
```
- 날짜 자동 갱신
- 커밋 해시 업데이트
- version-tree.yaml 메타데이터 섹션 수정

#### 3. 보고서 확인
```bash
.claude/tools/simple-tree-update.sh report
```
- 최근 업데이트 내역
- 로그 파일 확인

### 수동 업데이트 (고급)

#### Python 도구 사용 (PyYAML 필요)
```bash
# PyYAML 설치 후
pip install pyyaml

# 문서 추가
python3 .claude/tools/tree-manager.py add <path> <category>

# 문서 업데이트
python3 .claude/tools/tree-manager.py update <path>

# 참조 관계 추가
python3 .claude/tools/tree-manager.py ref <from> <to>
```

### 카테고리 분류
- `workflow`: 워크플로우 관련 (2000-2999)
- `learning`: 학습 시스템 (3000-3999)
- `tool`: 도구 및 스크립트 (4000-4999)
- `state`: 상태 관리 (5000-5999)
- `principle`: 원칙 문서 (1-99)
- `root`: 루트 문서 (1000-1999)

### 모범 사례

1. **커밋 전 항상 실행**
   ```bash
   .claude/tools/simple-tree-update.sh detect
   .claude/tools/simple-tree-update.sh update
   ```

2. **새 문서 생성 시**
   - 적절한 카테고리 선택
   - doc_id 할당 확인
   - 의존성 명시

3. **문서 삭제 시**
   - 참조하는 문서 확인
   - 의존성 정리
   - 로그에 기록

### 트러블슈팅

#### PyYAML 없을 때
- simple-tree-update.sh 사용
- 로그 기반 추적
- 수동 YAML 편집 가능

#### 중복 ID 발생
- tree-updates.log 확인
- 카테고리별 범위 준수
- 수동으로 ID 조정

#### 참조 깨짐
- validate.sh로 검증
- 양방향 참조 확인
- 의존성 그래프 검토