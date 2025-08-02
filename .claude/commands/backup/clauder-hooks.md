---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "58772aa"
  
dependencies:
  - file: ".claude/docs/design/HOOKS.md"
    commit: "58772aa"
  - file: ".claude/instructions.md"
    commit: "58772aa"
---

# /clauder hooks

Clauder 훅 시스템을 관리합니다.

## 사용법

```
/clauder hooks [action]
```

### 액션
- `install` - Git hooks 설치
- `uninstall` - Git hooks 제거
- `status` - 훅 상태 확인
- `test` - 훅 테스트 실행

## 명령어 상세

### 1. 훅 설치 (`install`)
```
/clauder hooks install
```
Git pre-commit 훅을 설치하여 자동으로:
- 커밋 시 문서 버전 업데이트
- 참조 일관성 검증
- 메타데이터 동기화

### 2. 훅 제거 (`uninstall`)
```
/clauder hooks uninstall
```
설치된 훅을 제거하고 기존 훅 복원

### 3. 상태 확인 (`status`)
```
/clauder hooks status
```
현재 설치된 훅과 동작 상태 표시

### 4. 테스트 (`test`)
```
/clauder hooks test [hook-name]
```
특정 훅을 테스트 모드로 실행

## 실행 예시

### 훅 설치
```
User: /clauder hooks install
Claude:
🔧 Clauder 훅 시스템 설치 중...

✅ Git hooks 설치 완료:
  - pre-commit: 문서 버전 자동 업데이트
  
이제 다음 동작이 자동화됩니다:
- git commit 시 .md 파일 버전 업데이트
- 참조 일관성 자동 확인

제거하려면: /clauder hooks uninstall
```

### 상태 확인
```
User: /clauder hooks status
Claude:
📊 Clauder 훅 상태

Git Hooks:
  ✅ pre-commit (설치됨)
     - 마지막 실행: 2025-08-02 10:30
     - 처리한 파일: 3개
  
Claude Instructions:
  ✅ .claude/instructions.md (활성)
  
자동 동작:
  ✓ 문서 편집 시 버전 추적
  ✓ Git 커밋 시 메타데이터 업데이트
  ✓ 참조 추가 시 양방향 연결
```

## 훅 동작 원리

### Git Hooks
```bash
.git/hooks/pre-commit
└── .claude/hooks/git/pre-commit 복사본
```

### Claude 지시사항
```
.claude/instructions.md
└── Claude가 모든 작업에서 참조
```

## 주의사항

1. **기존 훅 백업**: 기존 Git hooks는 자동으로 백업됨
2. **권한**: 실행 권한이 필요함 (자동 설정)
3. **호환성**: macOS와 Linux 모두 지원

## 문제 해결

### 훅이 실행되지 않을 때
```
# 권한 확인
ls -la .git/hooks/pre-commit

# 수동 권한 부여
chmod +x .git/hooks/pre-commit
```

### 훅 비활성화 (임시)
```
# 한 번만 건너뛰기
git commit --no-verify
```

## 관련 문서
- 훅 시스템 설계: @.claude/docs/design/HOOKS.md
- Claude 지시사항: @.claude/instructions.md
- 설치 스크립트: @.claude/hooks/install.sh