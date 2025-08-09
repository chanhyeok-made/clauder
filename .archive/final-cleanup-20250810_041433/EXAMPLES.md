---
doc_id: 519
---

# Clauder 사용 예제

> 💡 이 문서는 Lazy Loading 방식으로 최적화되었습니다.
> 필요한 시나리오만 참조하세요.

실제 프로젝트에서 Clauder를 활용하는 다양한 예제들입니다.

## 🚀 시나리오 1: 새 Node.js 프로젝트 시작

```bash
# 1. 새 프로젝트 생성
mkdir my-api-server && cd my-api-server

# 2. Node.js 프로젝트 초기화
npm init -y

# 3. Git 초기화
git init

# 4. Clauder 템플릿 가져오기
git clone https://github.com/chanhyeok-made/clauder.git temp
cp -r temp/.claude .
rm -rf temp

# 5. 초기 커밋
git add .
git commit -m "Initial commit with Clauder"
```

### Claude Code에서:
```
User: /clauder start
Claude: 🚀 Clauder 초기화를 시작합니다...

✅ Git 저장소 확인됨
📦 Node.js 프로젝트 감지 (package.json)

프로젝트 이름은 "my-api-server"가 맞나요? (Y/n) y
한 줄로 프로젝트를 설명해주세요: RESTful API 서버
특별한 개발 가이드가 필요한가요? (y/N) y
어떤 가이드가 필요한가요? API 엔드포인트 개발 가이드

✨ 생성 완료!
- .claude/custom/project.yaml
- .claude/custom/contexts/api-development.md
- CLAUDE.md

🪝 Git hooks를 설치하시겠습니까? (Y/n) y
✅ Git hooks 설치 완료

시작할 준비가 되었습니다! 🎉
```

## 🔧 시나리오 2: 기존 React 프로젝트에 적용

```bash
cd existing-react-app

# Clauder 추가
curl -L https://github.com/chanhyeok-made/clauder/archive/main.zip -o clauder.zip
unzip clauder.zip "clauder-main/.claude/*" -d .
mv clauder-main/.claude .
rm -rf clauder-main clauder.zip
```

### Claude Code에서:
```
User: /clauder start --from-existing
Claude: 🔍 기존 프로젝트 분석 중...

✅ React 프로젝트 감지
✅ TypeScript 설정 발견
✅ 테스트 프레임워크: Jest

다음 정보로 초기화하시겠습니까?
- 프로젝트: existing-react-app
- 기술 스택: React, TypeScript, Jest
- 빌드 도구: Vite

(Y/n) y

📝 기존 스크립트 감지:
- npm run dev
- npm run build
- npm run test

♻️ 마이그레이션 완료!
버전 추적이 활성화되었습니다.
```

## 📝 시나리오 3: 일일 작업 플로우

### 아침에 작업 시작
```
User: /clauder daily
Claude: 🌅 좋은 아침입니다! 프로젝트 상태를 확인합니다...

📊 문서 상태
- ✅ 최신: 15개
- ⚠️ 3일 이상 된 문서: 2개
  - debugging.md (5일 전)
  - deployment.md (7일 전)

🔄 어제 이후 변경사항
- src/api/users.ts (새 엔드포인트 추가)
- src/utils/validation.ts (버그 수정)

💡 오늘의 제안
1. debugging.md 업데이트 (최근 에러 패턴 반영)
2. 새로운 유저 API 문서화
3. 테스트 커버리지 확인

작업을 시작하시겠습니까? (Y/n)
```

### 버그 수정 작업
```
User: 유저 인증 API에서 401 에러가 발생해
Claude: 인증 에러를 확인하겠습니다. 먼저 관련 파일을 살펴보겠습니다.

[파일 분석 중...]

🐛 문제 발견: JWT 토큰 검증 로직에서 만료 시간 체크 누락

수정하겠습니다:
[코드 수정]

✅ 수정 완료
🪝 훅 실행: after-edit
  ✓ 버전 메타데이터 업데이트
  ✓ 관련 문서: auth-guide.md 업데이트 필요

테스트를 실행할까요?
```

## 🎯 시나리오 4: 새 기능 추가

```
User: 사용자 프로필 이미지 업로드 기능을 추가하고 싶어
Claude: 프로필 이미지 업로드 기능을 추가하겠습니다.

📋 작업 계획:
1. 파일 업로드 엔드포인트 생성
2. 이미지 검증 로직 추가
3. 스토리지 설정
4. 프론트엔드 UI 업데이트

/clauder add context image-upload
✅ 이미지 업로드 가이드 생성됨

시작하겠습니다...
[구현 진행]
```

## 💾 시나리오 5: 커밋과 버전 관리

```bash
# 작업 완료 후
git add .
git commit -m "feat: 프로필 이미지 업로드 기능 추가"
```

### 자동 실행:
```
🪝 Clauder pre-commit 훅 실행 중...
📝 마크다운 파일 감지됨. 버전 메타데이터 업데이트 중...
  ✓ .claude/custom/contexts/image-upload.md - 메타데이터 업데이트
  ✓ CLAUDE.md - 메타데이터 업데이트
✅ Pre-commit 훅 완료

[main abc123d] feat: 프로필 이미지 업로드 기능 추가
 5 files changed, 123 insertions(+)
```

## 🔍 시나리오 6: 문서 버전 확인

```
User: /clauder track check all
Claude: 문서 버전 상태 리포트
====================

✅ 최신 문서 (15개)
├─ CLAUDE.md (abc123d)
├─ .claude/README.md (abc123d)
└─ ...

⚠️ 업데이트 필요 (2개)
├─ debugging.md (5 커밋 뒤처짐)
│  └─ 참조: error-handling.ts 변경됨
└─ deployment.md (7 커밋 뒤처짐)
   └─ 참조: Dockerfile 업데이트됨

❌ 누락된 참조 (0개)

동기화하시겠습니까? (Y/n)
```

## 🛠 시나리오 7: 팀 협업

### 팀원 A: 기능 개발
```
git checkout -b feature/user-settings
# 작업...
/clauder add context user-settings
git commit -m "feat: 사용자 설정 페이지"
git push origin feature/user-settings
```

### 팀원 B: PR 리뷰
```
# PR을 로컬로 가져옴
git fetch origin
git checkout feature/user-settings

User: /clauder check
Claude: 📊 브랜치 문서 상태 확인

✅ 새로운 문서
- user-settings.md (적절한 버전 정보 포함)

✅ 업데이트된 문서
- CLAUDE.md (user-settings 컨텍스트 추가됨)

⚠️ 확인 필요
- 관련 테스트 문서 업데이트 필요할 수 있음

전반적으로 문서가 잘 관리되고 있습니다! 👍
```

## 📚 추가 팁

### 빠른 상태 확인
```
# 언제든 현재 상태 확인
/clauder check

# 특정 파일의 버전 확인
/clauder track check README.md
```

### 문서 자동 생성
```
# 변경사항이 많을 때
/clauder generate

# 미리보기
/clauder generate preview
```

### 훅 임시 비활성화
```bash
# 한 번만 훅 건너뛰기
git commit --no-verify -m "WIP: 임시 커밋"
```

