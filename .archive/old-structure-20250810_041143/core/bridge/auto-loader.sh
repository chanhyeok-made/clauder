#!/bin/bash
# Automatic Module Loader
# Detects and loads required modules based on project configuration

# Determine the script directory even when sourced
if [ -n "${BASH_SOURCE[0]}" ]; then
    SCRIPT_PATH="${BASH_SOURCE[0]}"
else
    SCRIPT_PATH="$0"
fi

# Get absolute path
if [[ "$SCRIPT_PATH" = /* ]]; then
    BRIDGE_DIR="$(dirname "$SCRIPT_PATH")"
else
    BRIDGE_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
fi

CORE_DIR="$(dirname "$BRIDGE_DIR")"
CLAUDER_ROOT="$(dirname "$CORE_DIR")"

# Fallback to pwd-based detection if paths are incorrect
if [ ! -d "$BRIDGE_DIR" ] || [ ! -f "$BRIDGE_DIR/detector.sh" ]; then
    if [ -f "core/bridge/auto-loader.sh" ]; then
        CLAUDER_ROOT="$(pwd)"
        CORE_DIR="$CLAUDER_ROOT/core"
        BRIDGE_DIR="$CORE_DIR/bridge"
    fi
fi

# Load detector if not already loaded
if ! declare -f detect_and_analyze >/dev/null 2>&1; then
    source "$BRIDGE_DIR/detector.sh"
fi

# Load module engine if available
ENGINE_PATH="$CORE_DIR/engine/loader.sh"

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if module engine exists
check_module_engine() {
    if [ -f "$ENGINE_PATH" ]; then
        return 0
    else
        echo -e "${YELLOW}WARNING:${NC} Module engine not found"
        return 1
    fi
}

# Load module engine
load_module_engine() {
    if check_module_engine; then
        source "$ENGINE_PATH"
        echo -e "${GREEN}SUCCESS:${NC} Module engine loaded"
        return 0
    fi
    return 1
}

# Auto-load modules based on detection
auto_load_modules() {
    local modules_to_load=""
    
    # Detect required modules
    echo -e "${BLUE}AUTO-LOADER:${NC} Analyzing project..."
    
    # Call detector in quiet mode to get just the module list
    local detected_modules=$(detect_and_analyze "true")
    
    if [ -z "$detected_modules" ]; then
        echo -e "${YELLOW}INFO:${NC} No modules detected"
        return 1
    fi
    
    echo -e "${BLUE}DETECTED:${NC} $detected_modules"
    
    # Load each detected module
    for module in $detected_modules; do
        if module_available "$module"; then
            echo -e "${BLUE}LOADING:${NC} $module module..."
            
            if load_module "$module"; then
                echo -e "  ${GREEN}✓${NC} $module loaded successfully"
            else
                echo -e "  ${RED}✗${NC} Failed to load $module"
            fi
        else
            echo -e "${YELLOW}SKIP:${NC} $module module not available"
        fi
    done
    
    return 0
}

# Create command aliases and wrappers for backward compatibility
create_compatibility_layer() {
    # Load command wrapper system
    local wrapper_script="$BRIDGE_DIR/command-wrapper.sh"
    
    if [ -f "$wrapper_script" ]; then
        source "$wrapper_script"
        init_command_wrapper "true"
        echo -e "${GREEN}COMPATIBILITY:${NC} Command wrappers initialized"
    fi
    
    # Check if tools module is loaded
    if [ ! -z "$LOADED_MODULES" ] && [[ " $LOADED_MODULES " =~ " tools " ]]; then
        # Create aliases for common tools
        alias safe-emoji-remover='$CLAUDER_ROOT/modules/tools/bin/emoji-remover'
        alias validate-convention='$CLAUDER_ROOT/modules/tools/bin/validator'
        alias state-tracker='$CLAUDER_ROOT/modules/tools/bin/state-tracker'
        
        echo -e "${GREEN}ALIASES:${NC} Compatibility aliases created"
    fi
}

# Initialize auto-loader session
init_auto_loader() {
    local silent_mode="${1:-false}"
    
    if [ "$silent_mode" != "true" ]; then
        echo ""
        echo "======================================"
        echo "Clauder Auto-Loader Initializing"
        echo "======================================"
    fi
    
    # Check for CLAUDE.md or .claude directory
    if [ ! -f "CLAUDE.md" ] && [ ! -f ".claude/CLAUDE.md" ] && [ ! -d ".claude" ]; then
        if [ "$silent_mode" != "true" ]; then
            echo -e "${YELLOW}INFO:${NC} No Clauder configuration detected"
        fi
        return 0
    fi
    
    # Load module engine
    if ! load_module_engine; then
        if [ "$silent_mode" != "true" ]; then
            echo -e "${RED}ERROR:${NC} Could not load module engine"
        fi
        return 1
    fi
    
    # Auto-load detected modules
    auto_load_modules
    
    # Create compatibility layer (aliases and wrappers)
    create_compatibility_layer
    
    if [ "$silent_mode" != "true" ]; then
        echo "======================================"
        echo ""
    fi
    
    return 0
}

# Hook for shell initialization
clauder_auto_hook() {
    # Check if we should auto-load
    if [ ! -z "$CLAUDER_AUTO_LOAD" ] && [ "$CLAUDER_AUTO_LOAD" = "true" ]; then
        init_auto_loader "true"
    fi
}

# Export functions
export -f check_module_engine
export -f load_module_engine
export -f auto_load_modules
export -f create_compatibility_layer
export -f init_auto_loader
export -f clauder_auto_hook

# Check if being sourced or executed
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    # Executed directly - run initialization
    init_auto_loader
else
    # Being sourced - set up auto-hook
    # This allows it to be added to .bashrc or similar
    export CLAUDER_AUTO_LOAD="${CLAUDER_AUTO_LOAD:-true}"
    
    # Try to auto-initialize if in a project directory
    if [ -f "CLAUDE.md" ] || [ -f ".claude/CLAUDE.md" ] || [ -d ".claude" ]; then
        clauder_auto_hook
    fi
fi