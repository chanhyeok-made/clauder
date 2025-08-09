---
doc_id: 828
---

# 초기화 문제

## 완전 재설정

### 1. 백업
```bash
cp -r .claude .claude.backup
```

### 2. 기존 설정 제거
```bash
rm -rf .claude
```

### 3. 템플릿 재설치
```bash
git clone https://github.com/chanhyeok-made/clauder.git temp
cp -r temp/.claude .
rm -rf temp
```

### 4. 재초기화
```
/clauder start
```

## 부분 초기화

### 템플릿만 업데이트
```bash
# 커스텀 설정 보존
mv .claude/custom .claude_custom_backup

# 템플릿 업데이트
rm -rf .claude/templates
cp -r [new_templates] .claude/templates

# 커스텀 설정 복원
mv .claude_custom_backup .claude/custom
```

### 설정 리셋
```
# 프로젝트 설정만
rm .claude/custom/project.yaml
/clauder initialize

# 개인 설정만
rm -rf .claude/custom/personal
/clauder initialize --personal
```

## 문제 해결 체크리스트

- [ ] Git 저장소 확인
- [ ] 필수 디렉토리 존재
- [ ] 권한 설정 확인
- [ ] 템플릿 무결성
- [ ] 설정 파일 유효성