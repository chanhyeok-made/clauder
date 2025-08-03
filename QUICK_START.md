---
doc_id: 523
---

5분 안에 Clauder를 시작하세요!

## 1. 요구사항

- Git이 설치되어 있어야 합니다
- Claude Code를 사용 중이어야 합니다

## 2. 설치

### 옵션 A: 새 프로젝트
```bash
# 1. 프로젝트 생성
mkdir my-project && cd my-project

# 2. Git 초기화
git init

# 3. Clauder 가져오기
git clone https://github.com/chanhyeok-made/clauder.git temp
cp -r temp/.claude .
rm -rf temp

# 4. 초기 커밋
git add .
git commit -m "Initial commit with Clauder"
```

### 옵션 B: 기존 프로젝트
```bash
# 프로젝트 디렉토리에서
curl -L https://github.com/chanhyeok-made/clauder/archive/main.zip -o clauder.zip
unzip clauder.zip "clauder-main/.claude/*" -d .
mv clauder-main/.claude .
rm -rf clauder-main clauder.zip
git add .claude
git commit -m "Add Clauder"
```

## 3. 초기화

Claude Code에서:
```
/clauder start
```

3가지 간단한 질문에 답하면 자동으로 설정됩니다!

## 4. 일일 사용

매일 작업 시작할 때:
```
/clauder daily
```

## 5. 다음 단계

- 📖 [전체 가이드](README.md) - 상세한 설명
- 💡 [예제](EXAMPLES.md) - 실제 사용 사례
- 📚 [명령어](docs/commands/) - 모든 명령어 설명

## 도움이 필요하신가요?

- [문제 해결 가이드](docs/guides/troubleshooting.md)
- [GitHub Issues](https://github.com/chanhyeok-made/clauder/issues)

