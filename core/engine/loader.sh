#!/bin/bash
# Clauder Core Module Loader
# Version: 1.0.0

# Configuration
CLAUDER_VERSION="2.0.0"
CLAUDER_ROOT="${CLAUDER_ROOT:-$(pwd)}"
MODULES_DIR="$CLAUDER_ROOT/modules"
CORE_DIR="$CLAUDER_ROOT/core"
RUNTIME_DIR="$CLAUDER_ROOT/runtime"
CONFIG_FILE="${CLAUDER_CONFIG:-clauder.config}"

# State management
LOADED_MODULES=()
MODULE_REGISTRY="$RUNTIME_DIR/state/modules.json"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Initialize runtime directories
init_runtime() {
    mkdir -p "$RUNTIME_DIR"/{state,cache,logs}
    
    # Initialize module registry
    if [ ! -f "$MODULE_REGISTRY" ]; then
        echo '{"modules": {}, "loaded": [], "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'"}' > "$MODULE_REGISTRY"
    fi
}

# Log function
log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "[$timestamp] [$level] $message" >> "$RUNTIME_DIR/logs/loader.log"
    
    case "$level" in
        ERROR) echo -e "${RED}ERROR:${NC} $message" >&2 ;;
        WARN)  echo -e "${YELLOW}WARN:${NC} $message" ;;
        INFO)  echo -e "${BLUE}INFO:${NC} $message" ;;
        SUCCESS) echo -e "${GREEN}DONE:${NC} $message" ;;
    esac
}

# Parse module specification (name@version)
parse_module_spec() {
    local spec="$1"
    local name="${spec%@*}"
    local version="${spec#*@}"
    
    if [ "$name" = "$version" ]; then
        version="latest"
    fi
    
    echo "$name:$version"
}

# Check if module exists
module_exists() {
    local module_name="$1"
    local module_path="$MODULES_DIR/$module_name"
    
    if [ -d "$module_path" ] && [ -f "$module_path/module.json" ]; then
        return 0
    fi
    return 1
}

# Load module metadata
load_module_metadata() {
    local module_name="$1"
    local module_path="$MODULES_DIR/$module_name"
    local metadata_file="$module_path/module.json"
    
    if [ ! -f "$metadata_file" ]; then
        log ERROR "Module metadata not found: $module_name"
        return 1
    fi
    
    # Parse JSON (simplified - in production use jq)
    local version=$(grep '"version"' "$metadata_file" | cut -d'"' -f4)
    local type=$(grep '"type"' "$metadata_file" | cut -d'"' -f4)
    local description=$(grep '"description"' "$metadata_file" | cut -d'"' -f4)
    
    log INFO "Module: $module_name@$version ($type)"
    
    # Store in registry
    echo "$module_name:$version:$type:loaded" >> "$RUNTIME_DIR/state/loaded_modules.txt"
    
    return 0
}

# Check module dependencies
check_dependencies() {
    local module_name="$1"
    local module_path="$MODULES_DIR/$module_name"
    local metadata_file="$module_path/module.json"
    
    if [ ! -f "$metadata_file" ]; then
        return 1
    fi
    
    log INFO "Checking dependencies for $module_name..."
    
    # Check for dependencies file first (simpler approach)
    local deps_file="$module_path/dependencies.txt"
    if [ -f "$deps_file" ]; then
        local deps=$(cat "$deps_file")
    else
        # Try to extract from JSON (very simplified)
        local deps=$(grep '"validation"' "$metadata_file" 2>/dev/null | head -1 | cut -d'"' -f2)
    fi
    
    if [ -z "$deps" ]; then
        log SUCCESS "No dependencies"
        return 0
    fi
    
    for dep in $deps; do
        local dep_name="${dep%@*}"
        if ! module_exists "$dep_name"; then
            log ERROR "Missing dependency: $dep"
            return 1
        fi
        log SUCCESS "Dependency found: $dep"
    done
    
    return 0
}

# Initialize module
init_module() {
    local module_name="$1"
    local module_path="$MODULES_DIR/$module_name"
    
    # Run pre-init hook
    if [ -f "$module_path/hooks/pre-init.sh" ]; then
        log INFO "Running pre-init hook for $module_name"
        source "$module_path/hooks/pre-init.sh"
    fi
    
    # Load module scripts
    if [ -f "$module_path/src/init.sh" ]; then
        log INFO "Initializing $module_name"
        source "$module_path/src/init.sh"
    fi
    
    # Register module commands
    if [ -f "$module_path/bin/commands.sh" ]; then
        source "$module_path/bin/commands.sh"
    fi
    
    # Run post-init hook
    if [ -f "$module_path/hooks/post-init.sh" ]; then
        log INFO "Running post-init hook for $module_name"
        source "$module_path/hooks/post-init.sh"
    fi
    
    # Mark as loaded
    LOADED_MODULES+=("$module_name")
    
    log SUCCESS "Module loaded: $module_name"
    return 0
}

# Load single module
load_module() {
    local module_spec="$1"
    local module_info=$(parse_module_spec "$module_spec")
    local module_name="${module_info%:*}"
    local module_version="${module_info#*:}"
    
    log INFO "Loading module: $module_name@$module_version"
    
    # Check if already loaded
    if [[ " ${LOADED_MODULES[@]} " =~ " ${module_name} " ]]; then
        log WARN "Module already loaded: $module_name"
        return 0
    fi
    
    # Check existence
    if ! module_exists "$module_name"; then
        log ERROR "Module not found: $module_name"
        return 1
    fi
    
    # Load metadata
    if ! load_module_metadata "$module_name"; then
        return 1
    fi
    
    # Check dependencies
    if ! check_dependencies "$module_name"; then
        log ERROR "Dependency check failed for $module_name"
        return 1
    fi
    
    # Initialize module
    if ! init_module "$module_name"; then
        log ERROR "Initialization failed for $module_name"
        return 1
    fi
    
    return 0
}

# Load modules from config
load_from_config() {
    local config_file="${1:-$CONFIG_FILE}"
    
    if [ ! -f "$config_file" ]; then
        log ERROR "Config file not found: $config_file"
        return 1
    fi
    
    log INFO "Loading modules from $config_file"
    
    # Parse config (simplified - would use proper YAML parser)
    local modules=$(grep -A10 "^modules:" "$config_file" | grep "  - " | sed 's/  - //')
    
    if [ -z "$modules" ]; then
        log WARN "No modules specified in config"
        return 0
    fi
    
    for module in $modules; do
        load_module "$module"
    done
    
    return 0
}

# List loaded modules
list_loaded_modules() {
    echo "======================================"
    echo "Loaded Modules"
    echo "======================================"
    
    if [ ${#LOADED_MODULES[@]} -eq 0 ]; then
        echo "No modules loaded"
    else
        for module in "${LOADED_MODULES[@]}"; do
            echo "  DONE: $module"
        done
    fi
    
    echo "======================================"
}

# Unload module
unload_module() {
    local module_name="$1"
    local module_path="$MODULES_DIR/$module_name"
    
    log INFO "Unloading module: $module_name"
    
    # Run cleanup hook
    if [ -f "$module_path/hooks/cleanup.sh" ]; then
        source "$module_path/hooks/cleanup.sh"
    fi
    
    # Remove from loaded list
    LOADED_MODULES=("${LOADED_MODULES[@]/$module_name}")
    
    log SUCCESS "Module unloaded: $module_name"
}

# Main initialization
clauder_init() {
    echo "======================================"
    echo "Clauder Core Engine v$CLAUDER_VERSION"
    echo "======================================"
    echo ""
    
    # Initialize runtime
    init_runtime
    
    # Load core principles
    if [ -d "$CORE_DIR/principles/base" ]; then
        log INFO "Loading core principles"
    fi
    
    # Load from config if exists
    if [ -f "$CONFIG_FILE" ]; then
        load_from_config "$CONFIG_FILE"
    else
        log WARN "No config file found, manual module loading required"
    fi
    
    echo ""
    list_loaded_modules
}

# Export functions for use
export -f load_module
export -f unload_module
export -f list_loaded_modules
export -f clauder_init

# Auto-init if sourced directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    clauder_init
fi