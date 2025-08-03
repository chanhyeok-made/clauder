---
doc_id: 725
---

# 🚀 Clauder 인터랙티브 설정 가이드

## 👋 환영합니다!

Clauder는 Claude Code와 함께 사용하는 문서화 시스템입니다.
5분만 투자하시면 프로젝트를 완벽하게 설정할 수 있습니다.

## 📋 사전 준비 체크리스트

시작하기 전에 확인해주세요:

- [ ] Git이 설치되어 있나요? (`git --version`)
- [ ] Claude Code를 사용 중인가요?
- [ ] 프로젝트 루트 디렉토리에 있나요?

## 🎯 단계별 설정

### 1단계: Clauder 다운로드

#### 옵션 A: Git Clone (추천)
```bash
git clone https://github.com/chanhyeok-made/clauder.git temp-clauder
cp -r temp-clauder/.claude .
cp -r temp-clauder/.clauder-dev .
cp -r temp-clauder/docs .
rm -rf temp-clauder
```

#### 옵션 B: 직접 다운로드
1. [GitHub에서 ZIP 다운로드](https://github.com/chanhyeok-made/clauder/archive/main.zip)
2. 압축 해제 후 필요한 디렉토리 복사

### 2단계: Claude Code에서 초기화

Claude Code를 열고 다음 명령을 실행하세요:

```
/clauder start
```

Claude가 묻는 질문:
1. **프로젝트 이름**: (예: my-awesome-app)
2. **프로젝트 설명**: 한 줄로 설명
3. **특별한 가이드 필요?**: 필요하면 Y

### 3단계: 결과 확인

성공적으로 설정되면:
- ✅ `CLAUDE.md` 파일 생성
- ✅ `.claude/custom/project.yaml` 생성
- ✅ Git hooks 설치

## 🎨 첫 사용 예시

### 새 기능 개발하기
```
User: 사용자 인증 기능을 추가하고 싶어
Claude: 사용자 인증 기능을 추가하겠습니다. 먼저 현재 프로젝트 구조를 확인하고...
```

### 버그 수정하기
```
User: 로그인 시 500 에러가 발생해
Claude: 로그인 에러를 확인하겠습니다. 관련 파일을 살펴보고...
```

## 🛠️ 자주 사용하는 명령어

### 상태 확인
```
/clauder check
```

### 문서 재생성
```
/clauder generate
```

### 일일 체크
```
/clauder daily
```

## ❓ 자주 묻는 질문

### Q: CLAUDE.md가 생성되지 않아요
**A**: Git이 초기화되어 있는지 확인하세요:
```bash
git init
git add .
git commit -m "Initial commit"
```

### Q: 명령어가 작동하지 않아요
**A**: Claude Code 내에서만 작동합니다. 터미널이 아닌 Claude와의 대화에서 사용하세요.

### Q: 기존 프로젝트에 적용할 수 있나요?
**A**: 네! `/clauder start --from-existing` 명령을 사용하세요.

## 🎯 다음 단계

1. **개인 설정 추가**: `/clauder personal setup`
2. **팀 가이드 작성**: `/clauder add context team-guidelines`
3. **훅 설치**: `/clauder hooks install`

## 💬 도움이 필요하신가요?

- 문제 해결: @docs/guides/TROUBLESHOOTING.md
- 상세 가이드: @docs/guides/workflows.md
- GitHub 이슈: https://github.com/chanhyeok-made/clauder/issues

---

🎉 축하합니다! 이제 Clauder를 사용할 준비가 되었습니다.
Claude Code와 함께 즐거운 개발 되세요!