#!/bin/bash
# Clauder Module Auto-Loading Hook
# Automatically loads modules when Claude Code starts

# This hook is designed to be sourced by Claude Code
# It provides transparent module loading based on project configuration

HOOK_DIR="$(dirname ${BASH_SOURCE[0]})"
CLAUDE_DIR="$(dirname $HOOK_DIR)"
PROJECT_ROOT="$(dirname $CLAUDE_DIR)"

# Check if auto-loader exists
AUTO_LOADER_PATH="$PROJECT_ROOT/core/bridge/auto-loader.sh"

if [ -f "$AUTO_LOADER_PATH" ]; then
    # Source the auto-loader
    source "$AUTO_LOADER_PATH"
    
    # Initialize with silent mode for cleaner Claude Code experience
    init_auto_loader "true"
    
    # Set environment to indicate modules are loaded
    export CLAUDER_MODULES_LOADED="true"
    export CLAUDER_MODULES_PATH="$PROJECT_ROOT/modules"
else
    # Fallback to traditional mode
    export CLAUDER_MODULES_LOADED="false"
fi

# Provide helper function for manual loading
clauder_load_modules() {
    if [ -f "$AUTO_LOADER_PATH" ]; then
        source "$AUTO_LOADER_PATH"
        init_auto_loader
    else
        echo "ERROR: Auto-loader not found at $AUTO_LOADER_PATH"
        return 1
    fi
}

# Export the helper
export -f clauder_load_modules