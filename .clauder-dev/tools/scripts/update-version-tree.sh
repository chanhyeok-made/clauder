#!/bin/bash
# 버전 트리 경로 업데이트 스크립트

echo "버전 트리 경로 업데이트 중..."

# 백업 생성
cp .claude/version-tree.yaml .claude/version-tree.yaml.backup

# 경로 변경 적용
sed -i '' \
  -e 's|/.claude/docs/principles/|/.clauder-dev/principles/|g' \
  -e 's|/.claude/docs/design/|/.clauder-dev/design/|g' \
  -e 's|/.claude/commands/|/docs/commands/|g' \
  -e 's|/.claude/docs/COMMAND_INDEX.md|/docs/commands/README.md|g' \
  -e 's|/.claude/docs/guides/WORKFLOWS.md|/docs/guides/workflows.md|g' \
  -e 's|/.claude/docs/guides/TROUBLESHOOTING.md|/docs/guides/troubleshooting.md|g' \
  -e 's|/.claude/docs/guides/CAPABILITIES.md|/docs/guides/capabilities.md|g' \
  -e 's|/.claude/docs/guides/VERSION-TREE-MIGRATION.md|/.clauder-dev/roadmap/VERSION-TREE-MIGRATION.md|g' \
  -e 's|/.claude/docs/guides/VERSION-INFO-REMOVAL-PLAN.md|/.clauder-dev/roadmap/VERSION-INFO-REMOVAL-PLAN.md|g' \
  -e 's|/.claude/docs/guides/VERSION-TREE-GUIDE.md|/.clauder-dev/tools/helpers/VERSION-TREE-GUIDE.md|g' \
  -e 's|/.claude/docs/TEMPLATE_GUIDE.md|/docs/templates/README.md|g' \
  -e 's|/.claude/scripts/version-tree-manager.py|/.clauder-dev/tools/scripts/version-tree-manager.py|g' \
  -e 's|/.claude/scripts/tree-sync.py|/.clauder-dev/tools/scripts/tree-sync.py|g' \
  -e 's|/.claude/scripts/generate-tree-entries.sh|/.clauder-dev/tools/scripts/generate-tree-entries.sh|g' \
  -e 's|/.claude/scripts/version-tree-helper.md|/.clauder-dev/tools/helpers/version-tree-helper.md|g' \
  -e 's|/ARCHITECTURE.md|/.clauder-dev/design/architecture.md|g' \
  -e 's|/FEATURE_MAP.md|/.clauder-dev/design/feature-map.md|g' \
  .claude/version-tree.yaml

echo "경로 업데이트 완료"