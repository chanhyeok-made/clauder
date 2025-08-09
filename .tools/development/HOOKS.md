---
doc_id: 512
---

## 🎯 개요

Claude가 모든 과정을 기억하는 것에 의존하지 않고, 명시적인 훅을 통해 자동으로 적절한 동작이 실행되도록 합니다.

## 🪝 훅 포인트

### 1. 파일 작업 훅

#### `before-edit`
```yaml
trigger: Edit 도구 사용 전
actions:
  - 파일이 문서인지 확인
  - 버전 메타데이터 존재 확인
  - 백업 생성 (선택)
```

#### `after-edit`
```yaml
trigger: Edit 도구 사용 후
actions:
  - 문서라면 버전 메타데이터 업데이트
  - 참조 일관성 확인
  - 변경 로그 기록
```

### 2. Git 작업 훅

#### `before-commit`
```yaml
trigger: git commit 전
actions:
  - 모든 문서의 버전 메타데이터 업데이트
  - 참조 동기화
  - 일관성 검증
```

#### `after-push`
```yaml
trigger: git push 후
actions:
  - 원격 버전과 동기화
  - 팀 알림 (선택)
```

### 3. 프로젝트 시작 훅

#### `on-project-open`
```yaml
trigger: Claude Code가 프로젝트 열 때
actions:
  - .claude/ 디렉토리 확인
  - Git 상태 확인
  - 버전 불일치 경고
  - 일일 체크 제안
```

### 4. 문서 작업 훅

#### `on-doc-create`
```yaml
trigger: 새 .md 파일 생성
actions:
  - 템플릿 제안
  - 버전 메타데이터 자동 추가
  - 관련 문서 연결
```

#### `on-doc-reference`
```yaml
trigger: @로 다른 문서 참조
actions:
  - 참조 대상 존재 확인
  - 양방향 참조 설정
  - 버전 호환성 확인
```

## 📝 훅 정의 파일

### `.claude/hooks.yaml`
```yaml
hooks:
  file:
    before-edit:
      - check-doc-type
      - verify-version-metadata
    after-edit:
      - update-version-metadata
      - check-references
      
  git:
    pre-commit:
      - sync-all-versions
      - validate-consistency
    post-push:
      - notify-team
      
  project:
    on-open:
      - check-clauder-setup
      - suggest-daily-check
      
  document:
    on-create:
      - add-version-metadata
      - suggest-template
    on-reference:
      - validate-reference
      - setup-bidirectional
```

## 🔧 훅 구현 방식

### 1. Claude 지시문 (.claude/instructions.md)
```markdown
# Claude 작업 지시사항

## 파일 편집 시
1. Edit 도구 사용 전: 파일 확장자가 .md면 버전 확인
2. Edit 도구 사용 후: .md 파일이면 자동으로 메타데이터 업데이트

## Git 명령 시
1. commit 전: /clauder track check all 실행
2. push 후: 성공 메시지와 함께 동기화 상태 표시
```

### 2. 자동 실행 스크립트
```bash
# .claude/hooks/pre-edit.sh
#!/bin/bash
if [[ "$1" == *.md ]]; then
  echo "📝 문서 편집 감지: 버전 추적 확인 중..."
  # 버전 메타데이터 확인 로직
fi
```

### 3. Claude 프롬프트 통합
CLAUDE.md에 훅 동작 명시:
```markdown
## 자동 동작 (훅)
- 문서 편집 시: 버전 자동 업데이트
- Git 커밋 시: 일관성 자동 검증
- 프로젝트 시작 시: 상태 자동 확인
```

## 🚀 구현 로드맵

### Phase 1: 명시적 지시
- [ ] instructions.md에 훅 동작 정의
- [ ] CLAUDE.md에 훅 설명 추가
- [ ] 각 명령어에 훅 트리거 명시

### Phase 2: 반자동화
- [ ] 훅 실행 제안 시스템
- [ ] 확인 후 실행 방식
- [ ] 실행 로그 기록

### Phase 3: 완전 자동화
- [ ] Git hooks 통합
- [ ] VS Code 확장
- [ ] CI/CD 파이프라인

## ⚠️ 중요 원칙

1. **명시적 정의**: 모든 훅은 문서에 명시적으로 정의
2. **투명한 실행**: 훅 실행 시 사용자에게 알림
3. **실패 안전**: 훅 실패가 작업을 막지 않음
4. **로그 기록**: 모든 훅 실행은 기록됨

## 📊 훅 실행 예시

```
User: [파일 편집]
Claude: 
🪝 훅 실행: before-edit
  ✓ 문서 타입 확인 (.md)
  ✓ 버전 메타데이터 존재

[편집 수행]

🪝 훅 실행: after-edit
  ✓ 버전 메타데이터 업데이트
  ✓ 참조 일관성 확인
  ℹ️ 2개 파일이 이 문서를 참조합니다
```
