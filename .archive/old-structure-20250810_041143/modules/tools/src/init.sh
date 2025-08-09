#!/bin/bash
# Tools Module Main Initialization
# Version: 1.0.0

MODULE_NAME="tools"
MODULE_VERSION="1.0.0"
MODULE_DIR="$(dirname $(dirname ${BASH_SOURCE[0]}))"

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Initialize all tools
init_tools_module() {
    echo -e "${BLUE}TOOLS:${NC} Initializing module v$MODULE_VERSION"
    
    # Load each tool component
    local tools_loaded=0
    
    # Load emoji-remover
    if [ -f "$MODULE_DIR/src/emoji-remover/init.sh" ]; then
        source "$MODULE_DIR/src/emoji-remover/init.sh"
        tools_loaded=$((tools_loaded + 1))
    fi
    
    # Load convention-validator
    if [ -f "$MODULE_DIR/src/convention-validator/init.sh" ]; then
        source "$MODULE_DIR/src/convention-validator/init.sh"
        tools_loaded=$((tools_loaded + 1))
    fi
    
    # Load state-tracker
    if [ -f "$MODULE_DIR/src/state-tracker/init.sh" ]; then
        source "$MODULE_DIR/src/state-tracker/init.sh"
        tools_loaded=$((tools_loaded + 1))
    fi
    
    echo -e "${GREEN}SUCCESS:${NC} Tools module loaded ($tools_loaded tools)"
}

# Provide unified interface
clauder_remove_emojis() {
    if type main >/dev/null 2>&1; then
        main "$@"
    else
        echo "ERROR: Emoji remover not loaded"
        return 1
    fi
}

clauder_validate() {
    if type validate_file >/dev/null 2>&1; then
        validate_file "$@"
    else
        echo "ERROR: Convention validator not loaded"
        return 1
    fi
}

clauder_track_state() {
    if type show_state >/dev/null 2>&1; then
        case "$1" in
            "show") show_state ;;
            "update") update_stage "$2" "$3" ;;
            "log") show_log "$2" ;;
            *) show_state ;;
        esac
    else
        echo "ERROR: State tracker not loaded"
        return 1
    fi
}

# Export unified functions
export -f clauder_remove_emojis
export -f clauder_validate
export -f clauder_track_state

# Initialize on load
init_tools_module