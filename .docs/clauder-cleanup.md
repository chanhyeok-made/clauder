---
doc_id: 114
---

# /clauder cleanup

임시 파일 및 로그 파일 정리 명령어입니다.

## 개요
작업 중 생성된 임시 파일과 오래된 로그를 정리합니다.

## 사용법

### 임시 파일 정리
```
/clauder cleanup temp
```
- `.clauder-dev/temp/` 디렉토리의 모든 파일 삭제
- 프로젝트 전체에서 `temp-*`, `draft-*` 패턴 파일 확인

### 오래된 로그 아카이브
```
/clauder cleanup logs --older-than 30d
```
- 30일 이상 된 로그를 archive/ 디렉토리로 이동
- 중요한 작업 로그는 보존

### 전체 정리
```
/clauder cleanup all
```
- 임시 파일과 오래된 로그 모두 정리
- 정리 전 확인 프롬프트 표시

## 옵션
- `--dry-run`: 실제 삭제하지 않고 대상 파일만 표시
- `--force`: 확인 없이 즉시 삭제
- `--older-than <기간>`: 지정 기간보다 오래된 파일만 대상

## 예시
```
# 7일 이상 된 임시 파일 확인
/clauder cleanup temp --older-than 7d --dry-run

# 모든 임시 파일 강제 삭제
/clauder cleanup temp --force

# 60일 이상 된 로그 아카이브
/clauder cleanup logs --older-than 60d
```

## 주의사항
- 실행 중인 작업의 임시 파일은 삭제하지 않음
- 로그는 삭제가 아닌 아카이브로 이동
- 중요한 파일은 수동으로 백업 권장

## 관련 문서
- 파일 관리 정책: @/.clauder-dev/FILE-MANAGEMENT-POLICY.md