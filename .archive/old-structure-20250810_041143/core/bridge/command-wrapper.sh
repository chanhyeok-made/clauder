#!/bin/bash
# Command Wrapper for Backward Compatibility
# Maps legacy commands to new module system

BRIDGE_DIR="$(dirname ${BASH_SOURCE[0]})"
CORE_DIR="$(dirname $BRIDGE_DIR)"
CLAUDER_ROOT="$(dirname $CORE_DIR)"

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if modules are loaded
check_modules_loaded() {
    if [ -z "$LOADED_MODULES" ]; then
        return 1
    fi
    return 0
}

# Create wrapper functions for common commands
create_command_wrappers() {
    # Emoji remover wrapper
    safe-emoji-remover() {
        local module_bin="$CLAUDER_ROOT/modules/tools/bin/emoji-remover"
        local legacy_bin="$CLAUDER_ROOT/.claude/tools/safe-emoji-remover.sh"
        
        if [ -f "$module_bin" ]; then
            "$module_bin" "$@"
        elif [ -f "$legacy_bin" ]; then
            "$legacy_bin" "$@"
        else
            echo -e "${RED}ERROR:${NC} safe-emoji-remover not found"
            return 1
        fi
    }
    
    # Convention validator wrapper
    validate-convention() {
        local module_bin="$CLAUDER_ROOT/modules/tools/bin/validator"
        local legacy_bin="$CLAUDER_ROOT/.claude/tools/validate-convention.sh"
        
        if [ -f "$module_bin" ]; then
            "$module_bin" "$@"
        elif [ -f "$legacy_bin" ]; then
            "$legacy_bin" "$@"
        else
            echo -e "${RED}ERROR:${NC} validate-convention not found"
            return 1
        fi
    }
    
    # State tracker wrapper
    state-tracker() {
        local module_bin="$CLAUDER_ROOT/modules/tools/bin/state-tracker"
        local legacy_bin="$CLAUDER_ROOT/.claude/tools/state-tracker.sh"
        
        if [ -f "$module_bin" ]; then
            "$module_bin" "$@"
        elif [ -f "$legacy_bin" ]; then
            "$legacy_bin" "$@"
        else
            echo -e "${RED}ERROR:${NC} state-tracker not found"
            return 1
        fi
    }
    
    # Workflow wrapper
    clauder-workflow() {
        if check_modules_loaded && [[ " $LOADED_MODULES " =~ " workflow " ]]; then
            case "$1" in
                "show"|"status")
                    show_workflow_status
                    ;;
                "update")
                    update_workflow_stage "$2" "$3"
                    ;;
                "checkpoint")
                    create_workflow_checkpoint "$2"
                    ;;
                *)
                    echo "Usage: clauder-workflow [show|update|checkpoint]"
                    ;;
            esac
        else
            echo -e "${YELLOW}WARNING:${NC} Workflow module not loaded"
            return 1
        fi
    }
    
    # Export wrapper functions
    export -f safe-emoji-remover
    export -f validate-convention
    export -f state-tracker
    export -f clauder-workflow
}

# Create path-based wrappers (for direct execution)
create_path_wrappers() {
    local wrapper_dir="$CLAUDER_ROOT/.claude/bin"
    
    # Create bin directory if not exists
    mkdir -p "$wrapper_dir"
    
    # Create executable wrapper scripts
    cat > "$wrapper_dir/safe-emoji-remover" << 'EOF'
#!/bin/bash
source "$(dirname $(dirname ${BASH_SOURCE[0]}))/../core/bridge/command-wrapper.sh"
safe-emoji-remover "$@"
EOF
    chmod +x "$wrapper_dir/safe-emoji-remover"
    
    cat > "$wrapper_dir/validate-convention" << 'EOF'
#!/bin/bash
source "$(dirname $(dirname ${BASH_SOURCE[0]}))/../core/bridge/command-wrapper.sh"
validate-convention "$@"
EOF
    chmod +x "$wrapper_dir/validate-convention"
    
    cat > "$wrapper_dir/state-tracker" << 'EOF'
#!/bin/bash
source "$(dirname $(dirname ${BASH_SOURCE[0]}))/../core/bridge/command-wrapper.sh"
state-tracker "$@"
EOF
    chmod +x "$wrapper_dir/state-tracker"
    
    echo -e "${GREEN}SUCCESS:${NC} Command wrappers created in $wrapper_dir"
}

# Initialize command wrapper system
init_command_wrapper() {
    local silent_mode="${1:-false}"
    
    if [ "$silent_mode" != "true" ]; then
        echo -e "${BLUE}WRAPPER:${NC} Initializing command compatibility layer..."
    fi
    
    # Create function wrappers
    create_command_wrappers
    
    # Create executable wrappers if needed
    if [ ! -d "$CLAUDER_ROOT/.claude/bin" ] || [ ! -f "$CLAUDER_ROOT/.claude/bin/safe-emoji-remover" ]; then
        create_path_wrappers
    fi
    
    if [ "$silent_mode" != "true" ]; then
        echo -e "${GREEN}SUCCESS:${NC} Command wrappers initialized"
    fi
    
    return 0
}

# Auto-initialize if sourced with modules loaded
if [ ! -z "$CLAUDER_MODULES_LOADED" ] && [ "$CLAUDER_MODULES_LOADED" = "true" ]; then
    init_command_wrapper "true"
fi

# Export initialization function
export -f init_command_wrapper

# Run if executed directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    init_command_wrapper
fi