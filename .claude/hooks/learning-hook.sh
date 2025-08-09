#!/bin/bash
# Learning Hook - Clauder 자체 학습 시스템 통합

HOOK_DIR="$(dirname ${BASH_SOURCE[0]})"
CLAUDE_DIR="$(dirname $HOOK_DIR)"
PROJECT_ROOT="$(dirname $CLAUDE_DIR)"

# 학습 시스템 로드
LEARNING_SYSTEM="$PROJECT_ROOT/.clauder-dev/learning/system.sh"

if [ -f "$LEARNING_SYSTEM" ]; then
    source "$LEARNING_SYSTEM"
    
    # 자동 학습 활성화
    export CLAUDER_LEARNING_ENABLED="true"
    
    # Git 훅과 통합 (커밋 시 학습)
    if [ -d ".git/hooks" ]; then
        # post-commit 훅 생성
        cat > .git/hooks/post-commit << 'EOF'
#!/bin/bash
# Clauder 학습 시스템 - 커밋 후 패턴 학습

if [ "$CLAUDER_LEARNING_ENABLED" = "true" ]; then
    # 성공 패턴 기록
    if type learn_from_success >/dev/null 2>&1; then
        commit_msg=$(git log -1 --format=%s)
        learn_from_success "commit" "$commit_msg" "$(date +%s)"
    fi
fi
EOF
        chmod +x .git/hooks/post-commit
    fi
    
    echo "[LEARNING] Clauder 학습 시스템 활성화됨"
else
    echo "[LEARNING] 학습 시스템을 찾을 수 없음"
fi

# Claude Code 작업 추적 함수
track_claude_action() {
    local action="$1"
    local details="$2"
    
    if [ "$CLAUDER_LEARNING_ENABLED" = "true" ]; then
        case "$action" in
            "error_fixed")
                learn_from_error "$details" "$3" "$4" "$5"
                ;;
            "task_completed")
                learn_from_success "$details" "$3"
                ;;
            "pattern_detected")
                remember_project_trait "$details" "$3" "$4"
                ;;
            "command_used")
                track_frequent_command "$details"
                ;;
        esac
    fi
}

# Export for use
export -f track_claude_action