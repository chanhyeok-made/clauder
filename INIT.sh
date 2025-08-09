#!/bin/bash
# Clauder 초기화 스크립트
# 다른 프로젝트에 Clauder 문서 구조를 적용

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Clauder 소스 경로 (이 스크립트가 있는 위치)
CLAUDER_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 대상 프로젝트 경로 (현재 디렉토리 또는 인자로 전달)
TARGET_PROJECT="${1:-$(pwd)}"

echo "======================================"
echo "Clauder Initialization System"
echo "======================================"
echo ""
echo -e "${BLUE}Source:${NC} $CLAUDER_SOURCE"
echo -e "${BLUE}Target:${NC} $TARGET_PROJECT"
echo ""

# 프로젝트 타입 감지
detect_project_type() {
    local project_type="generic"
    
    if [ -f "$TARGET_PROJECT/package.json" ]; then
        project_type="nodejs"
        echo -e "${GREEN}Detected:${NC} Node.js project"
    elif [ -f "$TARGET_PROJECT/requirements.txt" ] || [ -f "$TARGET_PROJECT/pyproject.toml" ]; then
        project_type="python"
        echo -e "${GREEN}Detected:${NC} Python project"
    elif [ -f "$TARGET_PROJECT/go.mod" ]; then
        project_type="golang"
        echo -e "${GREEN}Detected:${NC} Go project"
    elif [ -f "$TARGET_PROJECT/Cargo.toml" ]; then
        project_type="rust"
        echo -e "${GREEN}Detected:${NC} Rust project"
    else
        echo -e "${YELLOW}Detected:${NC} Generic project"
    fi
    
    echo "$project_type"
}

# 필수 디렉토리 생성
create_directory_structure() {
    echo ""
    echo -e "${BLUE}Creating directory structure...${NC}"
    
    # 핵심 디렉토리
    mkdir -p "$TARGET_PROJECT/.claude"/{workflow,tools,hooks,validators,templates}
    mkdir -p "$TARGET_PROJECT/.claude/learning"/{patterns,project-memory,insights}
    
    echo -e "  ${GREEN}✓${NC} .claude/ structure created"
}

# 핵심 파일 복사 (템플릿으로)
copy_core_templates() {
    echo ""
    echo -e "${BLUE}Copying core templates...${NC}"
    
    # CLAUDE.md 템플릿 생성
    cat > "$TARGET_PROJECT/CLAUDE.md" << 'EOF'
---
doc_id: 1000
priority: HIGH
load_when: ALWAYS
last_updated: DATE_PLACEHOLDER
project_type: TYPE_PLACEHOLDER
---

# PROJECT_NAME 프로젝트 가이드

PURPOSE: Claude Code와 함께하는 PROJECT_NAME 개발 가이드

## NEVER_FORGET: 핵심 목표
- **토큰 효율성**: 최소 토큰으로 최대 정보
- **체계적 작업**: 모든 작업 워크플로우 준수
- **지속적 학습**: 패턴 기록 및 재사용
- **작업 완전성**: 시작한 작업 반드시 완료

## AUTO_LOAD: 시스템 초기화
```bash
# Clauder 시스템 자동 로드
source .claude/hooks/init.sh 2>/dev/null || true
```

## IMMEDIATE: 작업 시작 시

### REQUIRED: 워크플로우 단계별 실행
```
1. 현재 단계 확인: get_current_stage
2. 단계별 TODO 생성
3. 완료 후 advance_stage
```

### REQUIRED: 상태 표시
```
CURRENT_STAGE: [analysis/implementation/review/documentation/commit]
```

## PROJECT_SPECIFIC: 프로젝트 특화 설정
<!-- 프로젝트별 커스터마이징 영역 -->

## REFERENCE_IF_NEEDED: 필요시 참조
- 워크플로우: @.claude/workflow/README.md
- 문서 규칙: @.claude/docs/conventions.md
- 학습 시스템: @.claude/learning/README.md

## FORBIDDEN: 금지사항
- 워크플로우 없이 작업 시작
- 문서 업데이트 없이 변경
- 학습 기록 없이 완료
EOF
    
    # 날짜와 타입 치환
    local project_type=$(detect_project_type)
    local project_name=$(basename "$TARGET_PROJECT")
    sed -i.bak "s/DATE_PLACEHOLDER/$(date +%Y-%m-%d)/" "$TARGET_PROJECT/CLAUDE.md"
    sed -i.bak "s/TYPE_PLACEHOLDER/$project_type/" "$TARGET_PROJECT/CLAUDE.md"
    sed -i.bak "s/PROJECT_NAME/$project_name/g" "$TARGET_PROJECT/CLAUDE.md"
    rm "$TARGET_PROJECT/CLAUDE.md.bak"
    
    echo -e "  ${GREEN}✓${NC} CLAUDE.md created"
}

# 워크플로우 시스템 설치
install_workflow_system() {
    echo ""
    echo -e "${BLUE}Installing workflow system...${NC}"
    
    # 워크플로우 README
    cat > "$TARGET_PROJECT/.claude/workflow/README.md" << 'EOF'
---
doc_id: 2000
last_updated: DATE_PLACEHOLDER
---

# 워크플로우 시스템

## 5단계 프로세스

1. **Analysis** - 요구사항 분석
2. **Implementation** - 구현
3. **Review** - 검토 및 테스트
4. **Documentation** - 문서화
5. **Commit** - 커밋 및 푸시

## 사용법

```bash
# 현재 단계 확인
get_current_stage

# 다음 단계로
advance_stage

# 상태 표시
show_workflow_status
```
EOF
    
    sed -i.bak "s/DATE_PLACEHOLDER/$(date +%Y-%m-%d)/" "$TARGET_PROJECT/.claude/workflow/README.md"
    rm "$TARGET_PROJECT/.claude/workflow/README.md.bak"
    
    echo -e "  ${GREEN}✓${NC} Workflow system installed"
}

# 학습 시스템 설치
install_learning_system() {
    echo ""
    echo -e "${BLUE}Installing learning system...${NC}"
    
    # 학습 시스템 복사 (간소화 버전)
    cat > "$TARGET_PROJECT/.claude/learning/system.sh" << 'EOF'
#!/bin/bash
# Project Learning System

LEARNING_DIR="$(dirname "${BASH_SOURCE[0]}")"

# 에러 패턴 학습
learn_from_error() {
    local error="$1"
    local solution="$2"
    echo "[$(date)] ERROR: $error → SOLUTION: $solution" >> "$LEARNING_DIR/patterns/errors.log"
}

# 성공 패턴 학습
learn_from_success() {
    local task="$1"
    local approach="$2"
    echo "[$(date)] SUCCESS: $task → APPROACH: $approach" >> "$LEARNING_DIR/patterns/success.log"
}

export -f learn_from_error
export -f learn_from_success
EOF
    
    chmod +x "$TARGET_PROJECT/.claude/learning/system.sh"
    echo -e "  ${GREEN}✓${NC} Learning system installed"
}

# 검증 도구 설치
install_validators() {
    echo ""
    echo -e "${BLUE}Installing validators...${NC}"
    
    # 문서 최신성 검증기 (간소화)
    cp "$CLAUDER_SOURCE/.claude/validators/document-freshness.sh" \
       "$TARGET_PROJECT/.claude/validators/" 2>/dev/null || {
        # 파일이 없으면 기본 버전 생성
        cat > "$TARGET_PROJECT/.claude/validators/check.sh" << 'EOF'
#!/bin/bash
# Document validator
echo "Checking document freshness..."
find . -name "*.md" -mtime +30 -print | while read file; do
    echo "STALE: $file"
done
EOF
        chmod +x "$TARGET_PROJECT/.claude/validators/check.sh"
    }
    
    echo -e "  ${GREEN}✓${NC} Validators installed"
}

# 초기화 훅 생성
create_init_hook() {
    echo ""
    echo -e "${BLUE}Creating initialization hook...${NC}"
    
    cat > "$TARGET_PROJECT/.claude/hooks/init.sh" << 'EOF'
#!/bin/bash
# Clauder Initialization Hook

HOOK_DIR="$(dirname "${BASH_SOURCE[0]}")"
CLAUDE_DIR="$(dirname "$HOOK_DIR")"

# 워크플로우 시스템 로드
if [ -f "$CLAUDE_DIR/workflow/system.sh" ]; then
    source "$CLAUDE_DIR/workflow/system.sh"
fi

# 학습 시스템 로드
if [ -f "$CLAUDE_DIR/learning/system.sh" ]; then
    source "$CLAUDE_DIR/learning/system.sh"
fi

echo "[CLAUDER] Systems initialized"
EOF
    
    chmod +x "$TARGET_PROJECT/.claude/hooks/init.sh"
    echo -e "  ${GREEN}✓${NC} Init hook created"
}

# .gitignore 업데이트
update_gitignore() {
    echo ""
    echo -e "${BLUE}Updating .gitignore...${NC}"
    
    # CLAUDE.md를 gitignore에 추가 (프로젝트별 커스터마이징)
    if [ -f "$TARGET_PROJECT/.gitignore" ]; then
        if ! grep -q "CLAUDE.md" "$TARGET_PROJECT/.gitignore"; then
            echo "" >> "$TARGET_PROJECT/.gitignore"
            echo "# Clauder project-specific configuration" >> "$TARGET_PROJECT/.gitignore"
            echo "CLAUDE.md" >> "$TARGET_PROJECT/.gitignore"
            echo ".claude/learning/patterns/" >> "$TARGET_PROJECT/.gitignore"
            echo ".claude/learning/project-memory/" >> "$TARGET_PROJECT/.gitignore"
            echo -e "  ${GREEN}✓${NC} .gitignore updated"
        else
            echo -e "  ${YELLOW}→${NC} .gitignore already configured"
        fi
    fi
}

# 프로젝트별 커스터마이징
customize_for_project() {
    local project_type="$1"
    
    echo ""
    echo -e "${BLUE}Customizing for $project_type...${NC}"
    
    case "$project_type" in
        "nodejs")
            cat >> "$TARGET_PROJECT/CLAUDE.md" << 'EOF'

## NODE.JS 특화 설정
- 테스트: npm test
- 빌드: npm run build
- 린트: npm run lint
EOF
            ;;
        "python")
            cat >> "$TARGET_PROJECT/CLAUDE.md" << 'EOF'

## PYTHON 특화 설정
- 테스트: pytest
- 포맷: black .
- 린트: flake8
EOF
            ;;
    esac
    
    echo -e "  ${GREEN}✓${NC} Customization complete"
}

# 최종 검증
final_validation() {
    echo ""
    echo "======================================"
    echo "Installation Summary"
    echo "======================================"
    
    local success=0
    local failed=0
    
    # 필수 파일 확인
    [ -f "$TARGET_PROJECT/CLAUDE.md" ] && ((success++)) || ((failed++))
    [ -d "$TARGET_PROJECT/.claude" ] && ((success++)) || ((failed++))
    [ -f "$TARGET_PROJECT/.claude/hooks/init.sh" ] && ((success++)) || ((failed++))
    
    echo -e "Success: ${GREEN}$success${NC}"
    echo -e "Failed: ${RED}$failed${NC}"
    
    if [ $failed -eq 0 ]; then
        echo ""
        echo -e "${GREEN}✓ Clauder successfully initialized!${NC}"
        echo ""
        echo "Next steps:"
        echo "1. Review and customize CLAUDE.md"
        echo "2. Test with: source .claude/hooks/init.sh"
        echo "3. Start using with Claude Code"
    else
        echo ""
        echo -e "${RED}✗ Some components failed to install${NC}"
        return 1
    fi
}

# 메인 실행
main() {
    # 확인
    if [ "$TARGET_PROJECT" = "$CLAUDER_SOURCE" ]; then
        echo -e "${RED}ERROR:${NC} Cannot initialize in Clauder source directory"
        exit 1
    fi
    
    echo ""
    read -p "Initialize Clauder in $TARGET_PROJECT? (y/n): " confirm
    if [ "$confirm" != "y" ]; then
        echo "Cancelled"
        exit 0
    fi
    
    # 설치 진행
    local project_type=$(detect_project_type)
    
    create_directory_structure
    copy_core_templates
    install_workflow_system
    install_learning_system
    install_validators
    create_init_hook
    update_gitignore
    customize_for_project "$project_type"
    final_validation
}

# 실행
main