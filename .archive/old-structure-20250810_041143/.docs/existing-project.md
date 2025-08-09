---
doc_id: 811
---

# 기존 프로젝트에 적용

## 기본 설치

```bash
# 1. 프로젝트 루트로 이동
cd /path/to/existing-project

# 2. 백업 (중요!)
cp CLAUDE.md CLAUDE.md.backup 2>/dev/null || true

# 3. Clauder 템플릿 가져오기
curl -L https://github.com/chanhyeok-made/clauder/archive/main.zip -o clauder.zip
unzip clauder.zip "clauder-main/.claude/*" -d .
mv clauder-main/.claude .
rm -rf clauder-main clauder.zip

# 4. Git 설정 확인 (필수!)
git add .
git commit -m "Add Clauder documentation system"

# 5. Claude Code에서 마이그레이션:
/clauder initialize --migrate
```

## 마이그레이션 옵션

### 기존 CLAUDE.md가 있는 경우
```
/clauder start --from-existing
```
Claude가 기존 문서를 분석하여 정보 추출

### 수동 마이그레이션
- 기존 내용을 `.claude/custom/overrides/`에 복사
- 필요한 부분만 커스터마이징

### 점진적 적용
```
# 단계별로 적용
/clauder update project info      # 기본 정보만
/clauder update project tech      # 기술 스택
/clauder add context debugging    # 필요한 가이드 추가
```

## 주의사항

- 기존 CLAUDE.md는 백업 필수
- Git 저장소가 필수 (없으면 `git init` 먼저)
- 커스텀 설정은 별도 관리 (.gitignore에 추가)