---
doc_id: 724
---

# 🤖 버전 트리 자동화 가이드

## 개요
버전 트리는 이제 대부분의 작업이 자동화되어 있습니다.

## 자동화된 프로세스

### 1. Git Pre-commit Hook
```bash
# 자동으로 실행되는 작업:
- 새 .md 파일을 버전 트리에 추가
- 수정된 파일의 updated/commit 필드 업데이트
- doc_id 누락 검사
- 임시 파일 위치 검증
```

### 2. 수동 실행 (필요시)
```bash
# 버전 트리 수동 업데이트
.clauder-dev/tools/scripts/auto-update-tree.sh

# 전체 검증
/clauder tree check
```

## 설치 방법

### 자동 설치
```
/clauder hooks install
```

### 수동 설치
```bash
cp .claude/hooks/git/pre-commit .git/hooks/
chmod +x .git/hooks/pre-commit
```

## 작동 방식

### 새 파일 추가 시
1. 파일 생성 및 doc_id 추가 (자동 할당)
2. `git add` 시 자동으로 버전 트리에 등록
3. 커밋 시 메타데이터 완성

### 파일 수정 시
1. 내용 수정
2. `git commit` 시 자동으로:
   - updated 날짜 갱신
   - commit 해시 업데이트

## 주의사항

### doc_id 필수
- 모든 .md 파일은 doc_id가 있어야 함
- 없으면 pre-commit이 실패함

### ID 할당 규칙
```yaml
1-99: 핵심 원칙 문서
100-199: 명령어 문서
200-299: 설계 문서
300-399: 가이드 문서
400-499: 템플릿 문서
500-599: 기타 시스템 문서
700-799: 학습 문서
1000+: 프로젝트 루트 문서
```

## 문제 해결

### Hook이 실행되지 않음
```bash
ls -la .git/hooks/pre-commit
# 없으면 설치 필요
```

### doc_id 충돌
- 버전 트리에서 가장 큰 ID 확인
- 수동으로 다음 번호 할당

### 버전 트리 동기화 오류
```bash
# 전체 재구축
/clauder tree rebuild
```

## 관련 파일
- 자동화 스크립트: @.clauder-dev/tools/scripts/auto-update-tree.sh
- Git Hook: @.claude/hooks/git/pre-commit
- 버전 트리: @.claude/version-tree.yaml