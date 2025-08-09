---
doc_id: 4002
created: 2025-08-10
type: guide
version: 1.0.0
---

# Clauder 모듈 개발 가이드

## 개요
Clauder 2.0의 모듈 시스템을 사용한 확장 개발 가이드

## 아키텍처

### 3계층 구조
```
clauder/
├── core/          # 핵심 엔진 (불변)
├── modules/       # 확장 모듈 (선택적)
└── projects/      # 프로젝트 설정 (커스터마이징)
```

## 모듈 개발

### 1. 모듈 구조 생성

```bash
# 모듈 디렉토리 생성
mkdir -p modules/my-module/{src,templates,tests,hooks,bin,config}

# 기본 구조
my-module/
├── module.json       # 필수: 모듈 메타데이터
├── README.md        # 필수: 모듈 문서
├── src/
│   └── init.sh      # 필수: 초기화 스크립트
├── hooks/           # 선택: 생명주기 훅
├── bin/             # 선택: 실행 파일
├── templates/       # 선택: 템플릿
└── tests/           # 권장: 테스트
```

### 2. module.json 작성

```json
{
  "name": "my-module",
  "version": "1.0.0",
  "type": "custom",
  "description": "Module description",
  "author": "Your Name",
  "dependencies": {
    "other-module": "^1.0.0"
  },
  "provides": ["feature1", "feature2"],
  "requires": ["core-feature"],
  "hooks": {
    "pre-init": "hooks/pre-init.sh",
    "post-init": "hooks/post-init.sh"
  }
}
```

### 3. 초기화 스크립트

```bash
#!/bin/bash
# src/init.sh

MODULE_NAME="my-module"
MODULE_VERSION="1.0.0"

# 초기화 로직
init_my_module() {
    echo "Initializing $MODULE_NAME v$MODULE_VERSION"
    # 모듈 초기화 코드
}

# 함수 내보내기
export -f init_my_module

# 자동 초기화
init_my_module
```

### 4. 의존성 관리

#### dependencies.txt (간단한 방법)
```
validation
workflow@2.0.0
```

#### module.json (표준 방법)
```json
"dependencies": {
  "validation": "^1.0.0",
  "workflow": "~2.0.0"
}
```

## 모듈 로딩

### 수동 로딩
```bash
source core/engine/loader.sh
load_module "my-module@1.0.0"
```

### 설정 파일 통한 자동 로딩
```yaml
# clauder.config
modules:
  - my-module@1.0.0
  - workflow@2.0.0
```

## 훅 시스템

### 사용 가능한 훅
- `install`: 모듈 설치 시
- `uninstall`: 모듈 제거 시
- `pre-init`: 초기화 전
- `post-init`: 초기화 후
- `cleanup`: 정리 시

### 훅 예시
```bash
#!/bin/bash
# hooks/post-init.sh

echo "Post-initialization tasks..."
# 추가 설정
# 파일 생성
# 권한 설정
```

## 명령어 내보내기

### bin/commands.sh
```bash
#!/bin/bash

# 명령어 정의
my_command() {
    echo "Executing my command"
    # 명령어 로직
}

# 내보내기
export -f my_command

# 별칭 설정
alias mymod='my_command'
```

## 테스트

### 테스트 스크립트
```bash
#!/bin/bash
# tests/test.sh

# 모듈 로드 테스트
test_module_load() {
    source core/engine/loader.sh
    load_module "my-module"
    
    if [ $? -eq 0 ]; then
        echo "PASS: Module loaded"
    else
        echo "FAIL: Module load failed"
        return 1
    fi
}

# 기능 테스트
test_functionality() {
    # 기능 테스트 코드
}

# 실행
test_module_load
test_functionality
```

## 모범 사례

### DO
- ✓ 명확한 모듈 이름 사용
- ✓ Semantic Versioning 준수
- ✓ 의존성 최소화
- ✓ 테스트 작성
- ✓ 문서화 철저히

### DON'T
- ✗ 글로벌 변수 남용
- ✗ 다른 모듈 직접 수정
- ✗ 하드코딩된 경로
- ✗ 무거운 초기화

## 예제: Counter 모듈

### module.json
```json
{
  "name": "counter",
  "version": "1.0.0",
  "type": "tool",
  "description": "Simple counter module"
}
```

### src/init.sh
```bash
#!/bin/bash

COUNTER=0

increment() {
    COUNTER=$((COUNTER + 1))
    echo "Counter: $COUNTER"
}

decrement() {
    COUNTER=$((COUNTER - 1))
    echo "Counter: $COUNTER"
}

reset_counter() {
    COUNTER=0
    echo "Counter reset"
}

export -f increment decrement reset_counter
```

## 디버깅

### 로그 확인
```bash
tail -f runtime/logs/loader.log
tail -f runtime/logs/workflow.log
```

### 상태 확인
```bash
cat runtime/state/modules.json
cat runtime/state/workflow.json
```

### 문제 해결

#### 모듈이 로드되지 않음
1. module.json 유효성 확인
2. 의존성 확인
3. 파일 권한 확인
4. 로그 확인

#### 함수를 찾을 수 없음
1. export -f 확인
2. source 순서 확인
3. 네임스페이스 충돌 확인

## 배포

### 로컬 테스트
```bash
# 로컬 모듈 로드
load_module "./modules/my-module"
```

### 패키징
```bash
# 모듈 압축
tar -czf my-module-1.0.0.tar.gz modules/my-module/
```

### 공유
1. GitHub 저장소 생성
2. 모듈 레지스트리 등록
3. 문서 업데이트

## 버전 관리

### 버전 규칙
- Major: 호환성 깨짐
- Minor: 기능 추가
- Patch: 버그 수정

### 업그레이드
```bash
# 기존 모듈 언로드
unload_module "my-module"

# 새 버전 로드
load_module "my-module@2.0.0"
```

## 참고 자료

- 모듈 스키마: `core/api/module.schema.json`
- 로더 엔진: `core/engine/loader.sh`
- 예제 모듈: `modules/workflow/`
- 프로토타입: `.clauder-dev/prototypes/`

---

질문이나 기여는 GitHub Issues로 제출해주세요.