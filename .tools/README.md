---
doc_id: 5001
module: tools
version: 1.0.0
---

# Tools Module

## 개요
Clauder의 필수 도구들을 통합한 모듈

## 포함된 도구

### 1. Emoji Remover
- 문서에서 이모지를 키워드로 변환
- 백업 자동 생성
- 토큰 효율성 25% 개선

### 2. Convention Validator
- 문서 컨벤션 검증
- doc_id, 키워드, 이모지 체크
- 95% 컴플라이언스 목표

### 3. State Tracker
- 워크플로우 상태 관리
- 세션 추적 및 아카이브
- 메트릭 수집

## 설치

### 모듈 방식
```bash
source core/engine/loader.sh
load_module "tools"
```

### 직접 사용
```bash
# Emoji 제거
modules/tools/bin/emoji-remover [파일/디렉토리]

# 컨벤션 검증
modules/tools/bin/validator [파일]

# 상태 추적
modules/tools/bin/state-tracker show
```

## 호환성

### 기존 경로 지원
```bash
# 원본 도구 (계속 작동)
.claude/tools/safe-emoji-remover.sh
.claude/tools/validate-convention.sh
.claude/tools/state-tracker.sh

# 모듈 버전 (심볼릭 링크)
.claude/tools/safe-emoji-remover-modular.sh
.claude/tools/validate-convention-modular.sh
.claude/tools/state-tracker-modular.sh
```

## 사용 예시

### Emoji Remover
```bash
# 단일 파일
modules/tools/bin/emoji-remover README.md

# 디렉토리
modules/tools/bin/emoji-remover .claude/

# 드라이런
modules/tools/bin/emoji-remover --dry-run README.md
```

### Convention Validator
```bash
# 단일 파일 검증
modules/tools/bin/validator core/README.md

# 모든 마크다운 파일
modules/tools/bin/validator

# 특정 디렉토리
find .claude -name "*.md" | xargs modules/tools/bin/validator
```

### State Tracker
```bash
# 상태 확인
modules/tools/bin/state-tracker show

# 단계 업데이트
modules/tools/bin/state-tracker update implementation coding

# 로그 확인
modules/tools/bin/state-tracker log

# 체크포인트 생성
modules/tools/bin/state-tracker checkpoint "before-migration"
```

## 설정

### module.json 커스터마이징
```json
{
  "config": {
    "validation": {
      "strict_mode": true,
      "target_compliance": 95
    },
    "emoji_removal": {
      "backup": true,
      "dry_run": false
    }
  }
}
```

## 구조

```
tools/
├── module.json         # 모듈 메타데이터
├── README.md          # 이 파일
├── src/
│   ├── init.sh        # 메인 초기화
│   ├── emoji-remover/
│   │   ├── init.sh    # 컴포넌트 초기화
│   │   └── core.sh    # 핵심 로직
│   ├── convention-validator/
│   │   ├── init.sh
│   │   └── core.sh
│   └── state-tracker/
│       ├── init.sh
│       └── core.sh
└── bin/               # 실행 파일
    ├── emoji-remover
    ├── validator
    └── state-tracker
```

## 개발

### 새 도구 추가
1. `src/[tool-name]/` 디렉토리 생성
2. `core.sh`에 로직 구현
3. `init.sh`에 초기화 코드
4. `bin/[tool-name]` 실행 파일 생성
5. `module.json` 업데이트

### 테스트
```bash
# 모듈 로드 테스트
source core/engine/loader.sh
load_module "tools"

# 개별 도구 테스트
modules/tools/tests/test-emoji-remover.sh
modules/tools/tests/test-validator.sh
modules/tools/tests/test-state-tracker.sh
```

## 마이그레이션

### 기존 도구에서 전환
```bash
# 이전 (기존 경로)
./.claude/tools/safe-emoji-remover.sh file.md

# 이후 (모듈 경로)
./modules/tools/bin/emoji-remover file.md

# 또는 심볼릭 링크 사용
./.claude/tools/safe-emoji-remover-modular.sh file.md
```

## 버전 히스토리

### v1.0.0 (2025-08-10)
- 초기 모듈화
- 3개 핵심 도구 통합
- 호환성 레이어 구축

## 라이선스
MIT