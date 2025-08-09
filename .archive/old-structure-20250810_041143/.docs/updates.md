---
doc_id: 819
---

# 업데이트

## 템플릿 업데이트

### 최신 버전 가져오기
```bash
# 직접 업데이트
cd .claude/templates
git pull origin main

# 또는 전체 재설치
curl -L https://github.com/chanhyeok-made/clauder/archive/main.zip -o clauder.zip
unzip -o clauder.zip "clauder-main/.claude/templates/*" -d .
mv clauder-main/.claude/templates/* .claude/templates/
rm -rf clauder-main clauder.zip
```

### 업데이트 후 확인
```
# Claude Code에서:
/clauder check --templates
/clauder generate --dry-run
```

## 자동 업데이트

### 업데이트 확인
```
/clauder update check
```

### 선택적 업데이트
```
/clauder update templates     # 템플릿만
/clauder update commands      # 명령어만
/clauder update hooks         # 훅만
```

## 주의사항

### 커스텀 설정 보호
- custom/ 디렉토리는 업데이트에 영향받지 않음
- 오버라이드된 파일은 보존됨

### 호환성
- 역호환성 보장
- Breaking changes는 메이저 버전에서만

## 버전 확인

```
# 현재 버전
/clauder version

# 최신 버전 확인
/clauder version --check-update
```

## 마이그레이션 가이드

- v1.x → v2.x: [Migration Guide](https://github.com/chanhyeok-made/clauder/wiki/Migration-Guide)
- Breaking Changes: [CHANGELOG.md](https://github.com/chanhyeok-made/clauder/blob/main/CHANGELOG.md)