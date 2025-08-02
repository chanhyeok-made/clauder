# 📋 Claude Code 문서 시스템 명령어

이 문서는 Claude가 인식하고 실행할 수 있는 명령어들을 정의합니다.

## 🚀 초기화 명령어

### @initialize project [mode]
프로젝트 문서 시스템을 초기화합니다.

**모드:**
- `quick` (기본값): 필수 정보만 질문
- `full`: 모든 설정 항목 질문

**Claude의 동작:**
1. 프로젝트 파일 분석 (package.json, go.mod, requirements.txt 등)
2. 대화형 질문을 통한 정보 수집
3. `.claude/custom/project.yaml` 생성
4. `CLAUDE.md` 생성

### @reinitialize project
기존 설정을 유지하면서 업데이트합니다.

## 📝 문서 관리 명령어

### @generate claude.md
현재 설정을 기반으로 CLAUDE.md를 재생성합니다.

**Claude의 동작:**
1. `.claude/custom/project.yaml` 읽기
2. 템플릿 변수 치환
3. 조건부 섹션 처리
4. `CLAUDE.md` 업데이트

### @update project [section]
특정 섹션만 업데이트합니다.

**섹션:**
- `info`: 프로젝트 기본 정보
- `tech-stack`: 기술 스택
- `commands`: 개발 명령어
- `structure`: 디렉토리 구조

### @add context [name]
새로운 상황별 가이드를 추가합니다.

**예시:**
```
@add context deployment
@add context debugging
@add context performance-tuning
```

## 🔍 상태 확인 명령어

### @check documentation
현재 문서 시스템 상태를 확인합니다.

**체크 항목:**
- 필수 파일 존재 여부
- 설정 완성도
- 템플릿 버전
- 커스텀 파일 목록

### @validate project.yaml
project.yaml의 유효성을 검사합니다.

## 🎨 커스터마이징 명령어

### @override template [name]
기본 템플릿을 커스터마이징합니다.

**예시:**
```
@override template work-principles
@override template dev-principles
```

### @extend [section] [content]
특정 섹션에 내용을 추가합니다.

**예시:**
```
@extend essentials "## 특별 요구사항\n- 실시간 동기화 필요"
```

## 🛠 유틸리티 명령어

### @preview [template]
템플릿이 어떻게 렌더링되는지 미리 봅니다.

### @list templates
사용 가능한 모든 템플릿을 나열합니다.

### @list contexts
현재 정의된 모든 컨텍스트를 나열합니다.

## 💡 사용 팁

1. **명령어 조합**: 여러 명령을 순차적으로 실행할 수 있습니다.
   ```
   @initialize project quick
   @add context deployment
   @generate claude.md
   ```

2. **자동 완성**: Claude는 문맥을 이해하여 적절한 기본값을 제안합니다.

3. **되돌리기**: 모든 변경사항은 git으로 추적되므로 안전합니다.

---

📌 **참고**: 이 명령어들은 Claude가 해석하여 실행합니다. 
실제 CLI 명령어가 아니라 Claude와의 대화에서 사용하는 지시어입니다.