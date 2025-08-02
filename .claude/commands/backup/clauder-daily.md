---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "61bcea8"
  
dependencies:
  - file: ".claude/commands/clauder-check.md"
    commit: "78b8a7b"
  - file: ".claude/commands/clauder-track.md"
    commit: "78b8a7b"
---

# /clauder daily

매일 작업 시작 시 실행하는 자동화 명령입니다.

## 사용법

```
/clauder daily
```

## 자동 수행 작업

### 1. 🔍 상태 점검
- Git 상태 확인
- 커밋되지 않은 변경사항 확인
- 문서 일관성 검사

### 2. 📊 버전 리포트
```
문서 상태 요약
==============
✅ 최신: 12개
⚠️ 업데이트 필요: 2개
❌ 누락된 참조: 0개

상세 내용을 보시겠습니까? (y/N)
```

### 3. 🔄 자동 동기화 제안
```
다음 문서가 오래되었습니다:
- README.md (5일 전)
- .claude/custom/contexts/debugging.md (3일 전)

자동으로 업데이트하시겠습니까? (Y/n)
```

### 4. 💡 작업 제안
```
오늘의 제안:
- [ ] debugging.md 가이드 업데이트 (최근 에러 패턴 반영)
- [ ] 새로운 배포 가이드 추가 고려
- [ ] 3개의 TODO 주석 해결
```

## 실행 예시

### 모든 것이 최신일 때
```
User: /clauder daily
Claude:
🌅 좋은 아침입니다! 프로젝트 상태를 확인합니다...

✅ 모든 문서가 최신 상태입니다
✅ Git 저장소 깨끗함
✅ 참조 일관성 확인됨

오늘도 좋은 코딩 되세요! 🚀
```

### 업데이트가 필요할 때
```
User: /clauder daily
Claude:
🌅 프로젝트 상태 확인 중...

⚠️ 주의가 필요한 항목:

1. 오래된 문서 (2개)
   - README.md: 최근 API 변경사항 미반영
   - debugging.md: 새로운 에러 패턴 추가 필요

2. 커밋되지 않은 변경사항
   - src/api/handler.ts
   - tests/api.test.ts

다음 작업을 추천합니다:
1. 변경사항 커밋 → /clauder track 자동 실행
2. 문서 업데이트 → /clauder update

지금 시작하시겠습니까? (Y/n)
```

## 스마트 기능

### 컨텍스트 인식
- 최근 작업 패턴 분석
- 자주 수정되는 파일 추적
- 팀 작업 패턴 학습

### 프로젝트 단계별 조정
- 초기: 기본 구조 점검 중심
- 개발: 일관성과 동기화 중심  
- 유지보수: 문서 최신성 중심

## 설정 커스터마이징

`.claude/settings.yaml`에서 조정 가능:
```yaml
daily:
  auto_sync: true
  report_detail: summary  # summary | detailed | minimal
  suggestions: true
  time_based: morning     # morning | anytime
```

## 관련 명령어
- `/clauder start` - 프로젝트 초기화
- `/clauder sync` - 강제 전체 동기화
- `/clauder report` - 상세 리포트만 확인