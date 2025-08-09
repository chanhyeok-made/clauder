---
doc_id: 722
---

# 📁 Clauder 파일 관리 정책

## 🎯 목적
프로젝트의 파일들을 체계적으로 관리하여 중요한 것과 임시적인 것을 명확히 구분합니다.

## 📊 파일 분류 체계

### 1. 영구 파일 (Permanent)
**위치**: 기존 디렉토리 구조 유지
**특징**: 
- 프로젝트의 핵심 구성 요소
- 버전 관리 필수
- 문서화 필수

**예시**:
- 원칙 문서 (principles/)
- 설계 문서 (design/)
- 핵심 템플릿 (templates/)
- 필수 도구 (tools/essential/)

### 2. 임시 파일 (Temporary)
**위치**: `.clauder-dev/temp/`
**특징**:
- 작업 중 임시로 필요
- 작업 완료 후 삭제
- .gitignore에 포함

**명명 규칙**:
```
temp-<목적>-<YYYYMMDD>.<확장자>
예: temp-migration-20250803.sh
```

### 3. 로그 파일 (Logs)
**위치**: `.clauder-dev/logs/`
**특징**:
- 작업 기록 보존
- 구조화된 형식
- 주기적 아카이브

**구조**:
```
logs/
├── daily/           # 일별 작업 로그
│   └── 2025-08-03.md
├── migrations/      # 마이그레이션 로그
│   └── docid-migration-20250803.log
└── archive/         # 30일 이상 된 로그
```

## 🔄 수명 주기 관리

### 파일 생성 시
```yaml
checklist:
  - purpose: "영구적인가, 임시적인가?"
  - location: "어느 디렉토리가 적절한가?"
  - naming: "명명 규칙을 따르는가?"
  - documentation: "README에 추가 필요한가?"
```

### 작업 완료 시
1. temp/ 디렉토리 확인
2. 필요없는 임시 파일 삭제
3. 중요한 내용은 적절한 위치로 이동
4. 로그 파일 생성 (필요시)

### 정기 정리
- **일간**: temp/ 확인 및 정리
- **주간**: logs/ 정리 및 아카이브
- **월간**: 전체 구조 검토

## 📝 구현 예시

### 임시 스크립트 생성
```bash
# 잘못된 예
/.clauder-dev/tools/scripts/quick-fix.sh  # ❌

# 올바른 예
/.clauder-dev/temp/temp-quick-fix-20250803.sh  # ✅
```

### 작업 로그 기록
```bash
# 잘못된 예
/.clauder-dev/migration-notes.txt  # ❌

# 올바른 예
/.clauder-dev/logs/migrations/docid-migration-20250803.log  # ✅
```

## 🚫 하지 말아야 할 것
1. 임시 파일을 영구 디렉토리에 생성
2. 날짜 없이 임시 파일 생성
3. 로그를 구조 없이 방치
4. 사용 끝난 임시 파일 방치

## ✅ 반드시 해야 할 것
1. 파일 생성 전 목적과 수명 고려
2. 적절한 디렉토리 선택
3. 명명 규칙 준수
4. 작업 완료 시 정리

## 🔧 도구 지원

### 임시 파일 정리 명령
```
/clauder cleanup temp
```

### 로그 아카이브 명령
```
/clauder archive logs --older-than 30d
```

## 📌 .gitignore 설정
```
# 임시 파일
.clauder-dev/temp/
temp-*
draft-*
*.tmp
*.temp

# 로그 파일
.clauder-dev/logs/
*.log

# 단, 예시 로그는 포함
!.clauder-dev/logs/example.log
```

---

이 정책을 통해 Clauder 프로젝트를 깔끔하고 관리하기 쉽게 유지합니다.