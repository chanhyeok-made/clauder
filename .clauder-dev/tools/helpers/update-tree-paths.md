---
doc_id: 528
---

# 버전 트리 경로 업데이트 가이드

## 경로 변경 매핑

### 원칙 문서
- `/.claude/docs/principles/*.md` → `/.clauder-dev/principles/*.md`

### 설계 문서
- `/.claude/docs/design/*.md` → `/.clauder-dev/design/*.md`
- `/ARCHITECTURE.md` → `/.clauder-dev/design/architecture.md`
- `/FEATURE_MAP.md` → `/.clauder-dev/design/feature-map.md`

### 명령어 문서
- `/.claude/commands/*.md` → `/docs/commands/*.md`
- `/.claude/docs/COMMAND_INDEX.md` → `/docs/commands/README.md`

### 가이드 문서
- `/.claude/docs/guides/WORKFLOWS.md` → `/docs/guides/workflows.md`
- `/.claude/docs/guides/TROUBLESHOOTING.md` → `/docs/guides/troubleshooting.md`
- `/.claude/docs/guides/CAPABILITIES.md` → `/docs/guides/capabilities.md`
- `/.claude/docs/guides/TOKEN_TIPS.md` → 삭제 (best-practices.md에 통합)
- `/.claude/docs/guides/OPTIMIZATION.md` → 삭제 (best-practices.md에 통합)
- `/.claude/docs/guides/VERSION-TREE-MIGRATION.md` → `/.clauder-dev/roadmap/VERSION-TREE-MIGRATION.md`
- `/.claude/docs/guides/VERSION-INFO-REMOVAL-PLAN.md` → `/.clauder-dev/roadmap/VERSION-INFO-REMOVAL-PLAN.md`
- `/.claude/docs/guides/VERSION-TREE-GUIDE.md` → `/.clauder-dev/tools/helpers/VERSION-TREE-GUIDE.md`

### 템플릿 문서
- `/.claude/docs/TEMPLATE_GUIDE.md` → `/docs/templates/README.md`

### 스크립트
- `/.claude/scripts/*.py` → `/.clauder-dev/tools/scripts/*.py`
- `/.claude/scripts/*.sh` → `/.clauder-dev/tools/scripts/*.sh`
- `/.claude/scripts/version-tree-helper.md` → `/.clauder-dev/tools/helpers/version-tree-helper.md`

### 새로운 문서
- `/QUICK_START.md` (신규)
- `/docs/README.md` (신규)
- `/docs/guides/best-practices.md` (신규)
- `/.clauder-dev/README.md` (신규)
- `/.claude/config.yaml` (신규)

### 삭제된 문서
- `/.claude/aliases.yaml` (config.yaml에 통합)
- `/.claude/references.yaml` (config.yaml에 통합)

## 업데이트 절차

1. 각 문서 ID의 경로 업데이트
2. depends_on과 referenced_by 관계 유지
3. 새 문서들에 ID 할당
4. 삭제된 문서들의 ID 제거
5. path_to_id 인덱스 재생성