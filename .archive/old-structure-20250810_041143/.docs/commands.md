---
doc_id: 813
---

# 기본 명령어

## 핵심 명령어

```
/clauder start           # 프로젝트 자동 설정
/clauder initialize      # 프로젝트 초기화
/clauder generate        # CLAUDE.md 재생성
/clauder check          # 문서 상태 확인
```

## 문서 관리

```
/clauder add context [name]  # 새 가이드 추가
/clauder track              # 버전 추적 관리
/clauder update             # 설정 업데이트
```

## 고급 명령어

```
/clauder hooks install      # Git hooks 설치
/clauder daily             # 일일 상태 체크
/clauder migrate           # 기존 프로젝트 마이그레이션
```

## 명령어 옵션

```
--help              # 도움말 표시
--dry-run           # 실제 실행 없이 미리보기
--from-existing     # 기존 문서에서 정보 추출
--verbose           # 상세 로그 출력
```

## 사용 예시

```
# 새 컨텍스트 추가
/clauder add context api-development

# 버전 상태 확인
/clauder track check all

# 프로젝트 정보 업데이트
/clauder update project info
```

## 자세한 내용

- 명령어 인덱스: @.claude/docs/COMMAND_INDEX.md
- 워크플로우: @docs/guides/workflows.md