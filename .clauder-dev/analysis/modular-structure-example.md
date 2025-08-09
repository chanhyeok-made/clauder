---
doc_id: 3006
created: 2025-08-10
type: example
---

# 모듈화 구조 구체적 예시

## 실제 사용 시나리오

### 시나리오 1: 웹 애플리케이션 프로젝트

```bash
# 프로젝트 초기화
clauder init my-web-app --template=standard --preset=web-app

# 생성되는 구조
my-web-app/
├── .claude/
│   ├── clauder.config
│   └── modules/
│       ├── workflow@2.0.0 -> ../../modules/workflow
│       ├── validation@1.5.0 -> ../../modules/validation
│       └── web-conventions@1.0.0 -> ../../modules/web-conventions
```

**clauder.config:**
```yaml
version: "2.0"
project: "my-web-app"
extends: "standard"
modules:
  core:
    - workflow@2.0.0
    - validation@1.5.0
  domain:
    - web-conventions@1.0.0
    - api-patterns@2.1.0
  custom:
    - ./local-modules/team-standards
overrides:
  workflow:
    stages: 
      - planning
      - implementation
      - testing
      - deployment
  validation:
    rules:
      - no-console-log
      - must-have-tests
```

### 시나리오 2: 모듈 추가/제거

```bash
# 모듈 추가
clauder module add security-audit@latest
# → modules/security-audit 심볼릭 링크 생성
# → clauder.config 업데이트
# → 의존성 자동 해결

# 모듈 제거
clauder module remove web-conventions
# → 심볼릭 링크 제거
# → config에서 제거
# → 정리 작업 실행

# 커스텀 모듈 생성
clauder module create my-custom-rules
# → local-modules/my-custom-rules/ 생성
# → 기본 module.json 생성
# → 템플릿 파일 생성
```

### 시나리오 3: 팀별 커스터마이징

**기업 A팀 설정:**
```yaml
# projects/instances/team-a/clauder.config
extends: "enterprise"
organization: "company-xyz"
modules:
  core: ["workflow", "validation"]
  compliance: ["sox-compliance", "gdpr-checker"]
  team: ["team-a-conventions"]
policies:
  commit:
    require-ticket: true
    require-review: true
  documentation:
    min-coverage: 80%
```

**스타트업 B팀 설정:**
```yaml
# projects/instances/team-b/clauder.config
extends: "minimal"
modules:
  core: ["workflow-lite"]
  tools: ["rapid-deploy", "quick-test"]
settings:
  speed-over-process: true
  auto-deploy: true
```

## 모듈 예시

### 1. Workflow 모듈

```
modules/workflow/
├── module.json
├── README.md
├── src/
│   ├── stages/
│   │   ├── analysis.sh
│   │   ├── implementation.sh
│   │   └── review.sh
│   ├── hooks/
│   │   ├── pre-stage.sh
│   │   └── post-stage.sh
│   └── state-manager.sh
├── templates/
│   ├── todo.template
│   └── stage.template
└── tests/
    └── workflow.test.sh
```

**module.json:**
```json
{
  "name": "workflow",
  "version": "2.0.0",
  "type": "core",
  "description": "Standard workflow management",
  "author": "Clauder Team",
  "provides": [
    "workflow-management",
    "stage-tracking",
    "todo-integration"
  ],
  "requires": [],
  "dependencies": {
    "validation": "^1.0.0"
  },
  "config": {
    "stages": {
      "type": "array",
      "default": ["analysis", "implementation", "review"],
      "customizable": true
    },
    "auto-advance": {
      "type": "boolean",
      "default": false
    }
  },
  "hooks": {
    "install": "scripts/install.sh",
    "uninstall": "scripts/cleanup.sh",
    "upgrade": "scripts/migrate.sh"
  },
  "exports": {
    "commands": {
      "stage": "src/stage-manager.sh",
      "todo": "src/todo-manager.sh"
    },
    "templates": "templates/"
  }
}
```

### 2. Validation 모듈

```
modules/validation/
├── module.json
├── rules/
│   ├── documentation/
│   │   ├── must-have-docid.rule
│   │   └── no-emojis.rule
│   ├── code/
│   │   ├── no-console-log.rule
│   │   └── must-have-tests.rule
│   └── custom/
├── validators/
│   ├── markdown.validator
│   ├── yaml.validator
│   └── json.validator
├── reports/
│   └── compliance-report.template
└── bin/
    └── validate.sh
```

### 3. 커스텀 모듈 예시

```
local-modules/company-standards/
├── module.json
├── rules/
│   ├── must-use-jira-ticket.rule
│   ├── security-headers.rule
│   └── data-privacy.rule
├── templates/
│   ├── CLAUDE.md.company
│   └── project-setup.template
└── hooks/
    ├── pre-commit.sh
    └── post-deploy.sh
```

## 모듈 간 통신

### 이벤트 시스템
```javascript
// 모듈 A가 이벤트 발생
clauder.emit('stage:completed', { stage: 'analysis' });

// 모듈 B가 이벤트 구독
clauder.on('stage:completed', (data) => {
  if (data.stage === 'analysis') {
    startValidation();
  }
});
```

### 서비스 레지스트리
```javascript
// 모듈이 서비스 제공
clauder.provide('validation', {
  validate: (file) => { /* ... */ },
  report: () => { /* ... */ }
});

// 다른 모듈이 서비스 사용
const validator = clauder.require('validation');
validator.validate('README.md');
```

## 버전 호환성 관리

### 자동 호환성 체크
```bash
clauder compat check
# 출력:
# ✓ workflow@2.0.0 - compatible
# ✓ validation@1.5.0 - compatible
# ⚠ custom-module@0.1.0 - update available (0.2.0)
# ✗ legacy-tool@0.5.0 - incompatible with workflow@2.0.0
```

### 마이그레이션 지원
```bash
clauder migrate --from=1.0 --to=2.0
# 자동으로:
# 1. 구조 변환
# 2. 설정 마이그레이션
# 3. 모듈 업데이트
# 4. 호환성 테스트
```

## 장점 실현

### 1. 선택적 기능
- 필요한 모듈만 로드 → 빠른 시작
- 프로젝트별 최적화 → 효율성

### 2. 팀 협업
- 공통 모듈 공유 → 일관성
- 팀별 커스터마이징 → 유연성

### 3. 확장성
- 써드파티 모듈 → 생태계
- 기업 내부 모듈 → 보안

### 4. 유지보수
- 모듈별 버전 관리 → 안정성
- 격리된 테스트 → 신뢰성

이 구조는 Clauder를 진정한 "플랫폼"으로 만들어, 
다양한 팀과 프로젝트가 각자의 요구사항에 맞게 활용할 수 있게 합니다.