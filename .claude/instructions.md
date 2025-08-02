---
version:
  created: "2025-08-02"
  updated: "2025-08-02"
  commit: "67e1355"
  
dependencies:
  - file: ".claude/docs/principles/README.md"
    commit: "11d1061"
  - file: ".claude/docs/principles/01-REFERENCE-STRUCTURE.md"
    commit: "11d1061"
  - file: ".claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md"
    commit: "11d1061"
  - file: ".claude/docs/principles/06-WORK-UNIT-COMMITS.md"
    commit: "11d1061"
    
references: []  # 아직 역참조 없음
---

# Claude 작업 지시사항 (필수 준수)

이 문서는 Claude가 Clauder 프로젝트에서 작업할 때 **반드시** 따라야 하는 지시사항입니다.

## 🚨 핵심 원칙

1. **완벽한 참조 구조**: @.claude/docs/principles/01-REFERENCE-STRUCTURE.md
2. **프로젝트 독립성**: @.claude/docs/principles/02-PROJECT-INDEPENDENCE.md
3. **문서 모듈화**: @.claude/docs/principles/03-DOCUMENT-MODULARITY.md
4. **즉시 인지 가능**: @.claude/docs/principles/04-IMMEDIATE-RECOGNITION.md
5. **필수 역참조**: @.claude/docs/principles/05-BIDIRECTIONAL-REFERENCES.md
6. **작업 단위 커밋**: @.claude/docs/principles/06-WORK-UNIT-COMMITS.md

전체 원칙: @.claude/docs/principles/README.md

### 필수 규칙
- **실제 commit hash 사용**: "current" 금지, `git log -1 --format="%h"` 사용
- **모든 문서**에 YAML front matter 포함
- **모든 참조**는 @ 형식 사용
- **개념별 분리**: 한 문서 = 한 개념
- **역참조 필수**: 모든 문서에 references 섹션 포함 (비어있어도 `references: []` 명시)
- **양방향 참조**: A가 B를 참조하면, B의 references에 A 추가

## 🆘 작업 단위 커밋 (긴급!)

### 현재 작업 완료 시 즉시 수행
```
WHEN 작업 완료:
- ALERT: "🚨 작업 단위 커밋 필요!"
- SUGGEST: "git add . && git commit -m '[message]' && git push"
- REMIND: @.claude/docs/principles/06-WORK-UNIT-COMMITS.md
```

### TodoWrite 완료 시
```
IF all todos completed:
- MUST: Git commit 제안
- SHOW: 커밋 메시지 예시
- WARN: 커밋 없이 종료 금지
```

## 🚨 핵심 규칙

### 1. 문서 편집 시
```
BEFORE Edit 도구 사용:
- IF 파일이 .md 확장자 THEN
  - 버전 메타데이터 확인
  - 없으면 추가 제안

AFTER Edit 도구 사용:
- IF 편집한 파일이 .md THEN
  - updated 날짜 변경
  - commit 해시 업데이트 (git log -1 --format="%h")
  - 참조 확인
```

### 2. 새 파일 생성 시
```
WHEN Write 도구로 .md 파일 생성:
- MUST 버전 메타데이터 포함
- MUST 실제 commit 해시 기록 (git log -1 --format="%h")
- MUST "current" 대신 실제 해시 사용
- SHOULD 관련 문서 참조 확인
- MUST 버전 트리에 추가 (.claude/version-tree.yaml)
```

### 2.1 버전 트리 업데이트 (필수!)
```
AFTER 새 파일 생성 OR 파일 삭제:
- UPDATE: .claude/version-tree.yaml
- ADD: 새 파일 ID 할당 및 경로 추가
- UPDATE: metadata의 last_update와 commit
- UPDATE: path_to_id 인덱스
- WARN: 트리 업데이트 없이 종료 금지
```

### 3. Git 작업 시
```
BEFORE git commit:
- RUN: git status
- CHECK: 변경된 .md 파일 목록
- UPDATE: 각 파일의 버전 메타데이터

AFTER git commit:
- LOG: 새로운 commit 해시
- SUGGEST: 관련 문서 업데이트 필요 여부
```

### 4. 프로젝트 시작 시
```
WHEN 사용자가 처음 질문:
- CHECK: .claude/ 디렉토리 존재
- IF Git 저장소 THEN
  - 현재 commit 해시 확인
  - 문서 버전 상태 간단히 확인
```

## 📋 체크리스트

### 문서 작업 체크리스트
- [ ] 편집 전: 파일 타입 확인
- [ ] 편집 전: 버전 메타데이터 존재 확인
- [ ] 편집 후: 메타데이터 업데이트
- [ ] 편집 후: 참조 일관성 확인
- [ ] 새 파일 생성 시: 버전 트리에 추가
- [ ] 파일 삭제 시: 버전 트리에서 제거

### Git 작업 체크리스트
- [ ] commit 전: 문서 버전 동기화
- [ ] commit 후: 새 해시 기록
- [ ] push 후: 성공 확인

## 🔄 자동 실행 패턴

### 패턴 1: 문서 편집
```python
if tool == "Edit" and file.ends_with(".md"):
    before_edit_hook(file)
    # 실제 편집
    after_edit_hook(file)
```

### 패턴 2: 참조 추가
```python
if "@" in content and ".md" in content:
    validate_reference(referenced_file)
    add_bidirectional_reference()
```

### 패턴 3: 버전 확인
```python
if "version:" not in file_content:
    suggest_add_version_metadata()
```

## ⚡ 빠른 명령어

자주 사용하는 훅 관련 명령:
- `git log -1 --format="%h"` - 현재 커밋 해시
- `date -u +"%Y-%m-%d"` - 현재 날짜 (ISO 형식)
- `/clauder track check` - 버전 상태 확인

## 📊 토큰 최적화 규칙

### 문서 로딩 전략
```
BEFORE 세션 시작:
- LOAD: .claude/LOADING_STRATEGY.md 참조
- LOAD: 필수 문서만 (config.yaml 참조)
- DEFER: 나머지는 필요 시 로드
```

### 컨텍스트 압축
```
IF 파일 크기 > 2000 토큰:
- USE: context-compressor.py
- APPLY: 메타데이터 압축
- APPLY: 별칭 변환
- TRUNCATE: 긴 코드 블록
```

### 프로젝트 패턴 학습
```
AFTER 각 세션:
- RECORD: 사용된 문서
- UPDATE: .claude/custom/patterns.yaml
- OPTIMIZE: 다음 세션 위해 학습
```

## 🚫 하지 말아야 할 것

1. 버전 메타데이터 없이 .md 파일 수정
2. 참조 확인 없이 문서 링크 추가
3. Git 커밋 전 버전 동기화 생략
4. 오래된 commit 해시 그대로 두기
5. **템플릿 파일(.base)과 실제 파일 혼동**
6. **다른 프로젝트에 영향 주는 설정 변경**
7. **작업 완료 후 커밋 없이 종료**
8. **새 파일 생성 후 버전 트리 업데이트 누락**

## 💡 기억할 것

> "모든 문서는 버전이 있고, 모든 버전은 추적된다"

이 지시사항은 Claude의 모든 작업 세션에 적용됩니다.