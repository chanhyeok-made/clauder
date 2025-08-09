---
doc_id: 810
---

# 새 프로젝트와 함께 시작

## 템플릿 설치

```bash
# 1. 새 프로젝트 디렉토리 생성
mkdir my-new-project && cd my-new-project

# 2. Clauder 템플릿 가져오기
git clone https://github.com/chanhyeok-made/clauder.git temp
cp -r temp/.claude .
rm -rf temp

# 3. Git 초기화 (필수!)
git init
git add .
git commit -m "Initial commit with Clauder"
echo ".claude/custom/" >> .gitignore  # 커스텀 설정은 별도 관리

# 4. Claude에서 자동 초기화
# Claude Code를 열고:
/clauder start  # 모든 것을 자동으로!
```

## 설정 프로세스

### 1. 템플릿 복사 후 Claude에서 초기화
```
User: /clauder start
Claude: 🚀 Clauder 초기화를 시작합니다...
```

### 2. 질문에 답변
- 프로젝트 이름
- 주요 목적
- 사용 언어/프레임워크

### 3. 자동 생성
- `.claude/custom/project.yaml`
- `CLAUDE.md`

## 다음 단계

- 커스터마이징: @docs/readme/customization.md
- 훅 설치: @docs/readme/hooks.md