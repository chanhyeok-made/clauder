---
doc_id: 1000
priority: 높음
load_when: 항상
---

# Clauder 프로젝트 가이드

목적: Claude Code와 함께하는 Clauder 개발 필수 가이드

## 자동_로드: 모듈 시스템
```bash
# 자동: 사용 가능한 모듈 자동 로드
source .claude/hooks/auto-module-loader.sh 2>/dev/null || true
```

## 즉시실행: 작업 요청 시

### 필수: 워크플로우 TODO 생성
```
즉시 TodoWrite로 11개 항목 생성:
1.1 분석: 요구사항이 명확한가?
1.2 분석: 작업 크기와 접근법 결정
2.1 구현: 코드베이스 이해 후 시작
2.2 구현: 구현 및 테스트
2.3 구현: 요구사항 충족 확인
3.1 회고: 발견사항이나 이슈가 있나?
3.2 회고: 가치있다면 문서화
4.1 문서화: 문서화 필요성 평가
4.2 문서화: 필요시 문서 작성 및 버전 트리 업데이트
5.1 커밋: 변경사항 검토
5.2 커밋: 메시지 작성 후 푸시
```

### 필수: 상태 표시
```
현재_단계: [분석/구현/회고/문서화/커밋]
```

## 필요시_참조:
- 워크플로우 상세: @.claude/workflow/README.md
- 원칙: @.base-principles/README.md | @.clauder-dev/principles/README.md
- 프로젝트 정보: @.claude/project/clauder-overview.md
- 개발 가이드: @.clauder-dev/guides/

## 금지사항:
- 워크플로우 없이 작업 시작
- 분석 없이 구현
- 회고 없이 커밋