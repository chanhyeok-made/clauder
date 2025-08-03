# 개인 설정 가이드

대규모 팀에서 작업할 때, 각 개발자가 자신만의 설정과 맥락을 가질 수 있습니다.

## 개인 설정이란?

개인 설정은 Git에 커밋되지 않고 로컬에만 존재하는 사용자별 설정입니다:
- 개인 코딩 스타일 가이드
- 자주 사용하는 디버깅 방법
- 개인 별칭 및 단축키
- 로컬 환경 정보

## 개인 설정 구조

```
.claude/custom/personal/   # .gitignore에 포함됨
├── settings.yaml         # 개인 설정
├── contexts/            # 개인 맥락 문서
│   ├── my-style.md
│   └── local-debug.md
└── aliases.yaml         # 개인 별칭
```

## 설정 방법

### 1. 개인 설정 디렉토리 생성
```bash
mkdir -p .claude/custom/personal/contexts
```

### 2. 개인 설정 파일 생성
`.claude/custom/personal/settings.yaml`:
```yaml
# 개인 정보
developer:
  name: "김개발"
  email: "dev@example.com"
  team: "백엔드팀"

# 개인 선호 설정
preferences:
  # 코딩 스타일
  code_style:
    indent: "spaces"
    indent_size: 2
    line_length: 100
    
  # 커밋 메시지 형식
  commit_format: "conventional" # conventional, simple, detailed
  
  # 문서 작성 스타일
  documentation:
    language: "ko" # ko, en
    detail_level: "high" # low, medium, high

# 로컬 환경
local_env:
  editor: "vscode"
  terminal: "iTerm2"
  shell: "zsh"
```

### 3. 개인 맥락 추가
`.claude/custom/personal/contexts/my-style.md`:
```markdown
# 내 코딩 스타일 가이드

## 선호하는 패턴
- Early return 선호
- 함수는 20줄 이내
- 주석은 왜(why)를 설명

## 변수명 규칙
- 불린: is*, has*, should*
- 리스트: *List, *Array
- 맵: *Map, *Dict

## 커밋 스타일
- feat: 새 기능
- fix: 버그 수정
- refactor: 리팩토링
- docs: 문서만 수정
- test: 테스트 추가/수정
```

### 4. 개인 별칭 설정
`.claude/custom/personal/aliases.yaml`:
```yaml
# 자주 사용하는 경로 별칭
aliases:
  $my: ".claude/custom/personal"
  $work: "~/work/current-project"
  $test: "tests/integration"
  
# 자주 참조하는 문서
shortcuts:
  debug: "$my/contexts/local-debug.md"
  style: "$my/contexts/my-style.md"
```

## 우선순위

설정 우선순위 (높은 것이 우선):
1. 개인 설정 (`.claude/custom/personal/`)
2. 프로젝트 설정 (`.claude/custom/`)
3. 기본 템플릿 (`.claude/templates/`)

## 팀 협업

### 개인 설정 공유
개인 설정을 팀과 공유하고 싶다면:
```bash
# 개인 설정을 팀 설정으로 복사
cp .claude/custom/personal/contexts/my-style.md \
   .claude/custom/contexts/team-style-kim.md
```

### 팀 설정에서 개인화
팀 설정을 기반으로 개인 설정 만들기:
```bash
# 팀 스타일을 개인 설정으로 복사 후 수정
cp .claude/custom/contexts/team-style.md \
   .claude/custom/personal/contexts/my-style.md
```

## 고급 기능

### 조건부 로드
`.claude/custom/personal/settings.yaml`:
```yaml
# 프로젝트별 설정
project_overrides:
  "backend-api":
    contexts:
      - "api-personal-guide.md"
    aliases:
      $api: "src/main/java/api"
      
  "frontend-app":
    contexts:
      - "react-personal-patterns.md"
    aliases:
      $components: "src/components"
```

### 환경별 설정
```yaml
# 환경별 다른 설정 적용
environments:
  development:
    debug_level: "verbose"
    contexts:
      - "local-debug.md"
      
  production:
    debug_level: "error"
    contexts:
      - "prod-troubleshooting.md"
```

## 개인 설정 명령어

### 설정 초기화
```
/clauder personal init
```
개인 설정 디렉토리와 기본 파일 생성

### 설정 확인
```
/clauder personal show
```
현재 활성화된 개인 설정 표시

### 맥락 추가
```
/clauder personal add context <name>
```
개인 맥락 문서 추가

## 보안 주의사항

개인 설정에는 절대 포함하지 마세요:
- ❌ 비밀번호, API 키
- ❌ 내부 서버 주소
- ❌ 민감한 비즈니스 정보

대신 환경 변수 참조를 사용하세요:
```yaml
api_key: "${MY_API_KEY}"  # 환경 변수 참조
```

## 문제 해결

### 개인 설정이 적용되지 않을 때
1. `.claude/custom/personal/` 디렉토리 존재 확인
2. 파일 권한 확인 (읽기 가능)
3. YAML 문법 오류 확인
4. `/clauder check --personal` 실행

### 설정 충돌
개인 설정과 프로젝트 설정이 충돌할 때:
- 개인 설정이 항상 우선
- 명시적으로 프로젝트 설정 사용: `--no-personal` 옵션

## 예시: 실제 개인 설정

전체 예시는 `.claude/templates/personal/` 디렉토리를 참조하세요:
- `settings.example.yaml`
- `contexts/style-example.md`
- `aliases.example.yaml`