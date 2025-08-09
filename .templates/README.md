---
doc_id: 3000
last_updated: 2025-08-10
---

# Clauder 템플릿 시스템

## 목적
다른 프로젝트에 Clauder 문서 구조를 쉽게 적용

## 사용법

### 1. 빠른 시작
```bash
# Clauder 클론
git clone https://github.com/your/clauder.git
cd clauder

# 대상 프로젝트에 적용
./INIT.sh /path/to/your/project

# 또는 현재 디렉토리에 적용
cd /your/project
/path/to/clauder/INIT.sh
```

### 2. 설치되는 구조
```
your-project/
├── CLAUDE.md                 # 핵심 가이드 (커스터마이징 필요)
└── .claude/
    ├── workflow/            # 5단계 워크플로우
    ├── learning/            # 학습 시스템
    ├── validators/          # 문서 검증
    ├── hooks/              # 자동화 훅
    └── templates/          # 프로젝트 템플릿
```

## 템플릿 종류

### 기본 템플릿 (Generic)
모든 프로젝트에 적용 가능한 기본 구조

### Node.js 템플릿
```bash
./INIT.sh /my/node/project
```
- package.json 감지
- npm 스크립트 통합
- Jest 테스트 연동

### Python 템플릿
```bash
./INIT.sh /my/python/project
```
- requirements.txt/pyproject.toml 감지
- pytest 통합
- black/flake8 설정

### Go 템플릿
```bash
./INIT.sh /my/go/project
```
- go.mod 감지
- go test 통합
- go fmt 자동화

## 커스터마이징

### CLAUDE.md 수정
```markdown
## PROJECT_SPECIFIC: 프로젝트 특화 설정
- 빌드 명령: make build
- 테스트 명령: make test
- 배포 프로세스: make deploy
```

### 워크플로우 조정
```bash
# .claude/workflow/custom.sh
STAGES=("design" "implement" "test" "deploy" "monitor")
```

### 학습 패턴 추가
```bash
# .claude/learning/patterns/custom.md
## 프로젝트 특화 패턴
- API 에러 처리 패턴
- 데이터베이스 최적화 패턴
```

## 템플릿 개발

### 새 템플릿 추가
```bash
templates/
├── generic/          # 기본 템플릿
├── nodejs/          # Node.js
├── python/          # Python
├── go/              # Go
└── custom/          # 커스텀 템플릿
    ├── CLAUDE.md
    ├── workflow/
    └── hooks/
```

### 템플릿 구조
```yaml
# template.yaml
name: custom-template
version: 1.0.0
files:
  - source: CLAUDE.md
    target: CLAUDE.md
    variables:
      - PROJECT_NAME
      - BUILD_COMMAND
      - TEST_COMMAND
directories:
  - .claude/workflow
  - .claude/learning
hooks:
  - post_install: setup.sh
```

## 마이그레이션

### 기존 프로젝트에서 Clauder로
```bash
# 1. 백업
cp -r .claude .claude.backup

# 2. Clauder 설치
./INIT.sh .

# 3. 기존 설정 병합
merge_configs.sh

# 4. 검증
.claude/validators/check.sh
```

### Clauder 버전 업그레이드
```bash
# 1. 최신 버전 가져오기
git pull origin main

# 2. 템플릿 재적용
./INIT.sh --upgrade /my/project

# 3. 변경사항 확인
git diff CLAUDE.md
```

## 검증

### 설치 확인
```bash
# 필수 파일 확인
ls -la CLAUDE.md .claude/

# 시스템 테스트
source .claude/hooks/init.sh

# 문서 검증
.claude/validators/document-freshness.sh
```

### 호환성 테스트
```bash
# Claude Code 테스트
claude test

# 워크플로우 테스트
get_current_stage
advance_stage

# 학습 시스템 테스트
learn_from_success "test" "passed"
```

## 모범 사례

### DO ✅
- CLAUDE.md를 프로젝트에 맞게 커스터마이징
- 정기적으로 문서 최신성 검증
- 학습 패턴 적극 활용
- 팀과 템플릿 공유

### DON'T ❌
- 기본 템플릿 그대로 사용
- 문서 업데이트 무시
- 워크플로우 건너뛰기
- 학습 기록 삭제

## 문제 해결

### 설치 실패
```bash
# 권한 문제
chmod +x INIT.sh
sudo ./INIT.sh /project

# 경로 문제
cd /absolute/path/to/clauder
./INIT.sh /absolute/path/to/project
```

### 충돌 해결
```bash
# 기존 .claude 디렉토리 있을 때
mv .claude .claude.old
./INIT.sh .
# 수동으로 병합
```

## 기여하기

### 템플릿 제출
1. templates/ 에 새 템플릿 추가
2. 테스트 작성
3. PR 제출

### 개선 제안
- Issue 생성
- 문서 개선
- 버그 수정