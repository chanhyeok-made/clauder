#!/bin/bash
# CLAUDE.md Detector and Analyzer
# Detects project configuration and determines required modules

BRIDGE_DIR="$(dirname ${BASH_SOURCE[0]})"
CLAUDER_ROOT="${CLAUDER_ROOT:-$(pwd)}"

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Detect CLAUDE.md
detect_claude_md() {
    local claude_file="${1:-CLAUDE.md}"
    
    if [ -f "$claude_file" ]; then
        echo -e "${GREEN}DETECTED:${NC} CLAUDE.md found"
        return 0
    elif [ -f ".claude/CLAUDE.md" ]; then
        claude_file=".claude/CLAUDE.md"
        echo -e "${GREEN}DETECTED:${NC} .claude/CLAUDE.md found"
        return 0
    else
        return 1
    fi
}

# Analyze CLAUDE.md for module requirements
analyze_requirements() {
    local claude_file="${1:-CLAUDE.md}"
    local quiet_mode="${2:-false}"
    local required_modules=()
    
    if [ ! -f "$claude_file" ]; then
        return 1
    fi
    
    if [ "$quiet_mode" != "true" ]; then
        echo -e "${BLUE}ANALYZING:${NC} Project requirements..."
    fi
    
    # Check for workflow references
    if grep -q "workflow\|TODO\|stage\|단계" "$claude_file" 2>/dev/null; then
        required_modules+=("workflow")
        if [ "$quiet_mode" != "true" ]; then
            echo "  FOUND: Workflow management needed"
        fi
    fi
    
    # Check for validation needs
    if grep -q "validation\|검증\|convention\|컨벤션" "$claude_file" 2>/dev/null; then
        required_modules+=("validation")
        if [ "$quiet_mode" != "true" ]; then
            echo "  FOUND: Validation tools needed"
        fi
    fi
    
    # Check for tools references
    if grep -q "emoji\|state\|tracker\|도구" "$claude_file" 2>/dev/null; then
        required_modules+=("tools")
        if [ "$quiet_mode" != "true" ]; then
            echo "  FOUND: Tools module needed"
        fi
    fi
    
    # Check for .claude directory
    if [ -d ".claude" ]; then
        # Always load tools if .claude exists
        if [[ ! " ${required_modules[@]} " =~ " tools " ]]; then
            required_modules+=("tools")
            if [ "$quiet_mode" != "true" ]; then
                echo "  FOUND: .claude directory → Tools needed"
            fi
        fi
        
        # Check for workflow directory
        if [ -d ".claude/workflow" ]; then
            if [[ ! " ${required_modules[@]} " =~ " workflow " ]]; then
                required_modules+=("workflow")
                if [ "$quiet_mode" != "true" ]; then
                    echo "  FOUND: .claude/workflow → Workflow needed"
                fi
            fi
        fi
    fi
    
    # Default modules if nothing specific found
    if [ ${#required_modules[@]} -eq 0 ]; then
        required_modules=("workflow" "tools")
        if [ "$quiet_mode" != "true" ]; then
            echo "  DEFAULT: Loading standard modules"
        fi
    fi
    
    # Export the list
    echo "${required_modules[@]}"
}

# Detect project type
detect_project_type() {
    local project_type="generic"
    
    # Check for package.json (Node.js)
    if [ -f "package.json" ]; then
        project_type="nodejs"
    # Check for requirements.txt (Python)
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
        project_type="python"
    # Check for go.mod (Go)
    elif [ -f "go.mod" ]; then
        project_type="golang"
    # Check for Cargo.toml (Rust)
    elif [ -f "Cargo.toml" ]; then
        project_type="rust"
    fi
    
    echo "$project_type"
}

# Generate module list based on detection
generate_module_list() {
    local claude_file="${1:-CLAUDE.md}"
    local modules=()
    
    # Get required modules from CLAUDE.md (suppress output)
    if detect_claude_md "$claude_file" >/dev/null 2>&1; then
        local required=$(analyze_requirements "$claude_file" "true")
        modules=($required)
    fi
    
    # Add project-specific modules
    local project_type=$(detect_project_type)
    case "$project_type" in
        "nodejs")
            # Add Node.js specific modules if they exist
            if [ -d "$CLAUDER_ROOT/modules/nodejs" ]; then
                modules+=("nodejs")
            fi
            ;;
        "python")
            if [ -d "$CLAUDER_ROOT/modules/python" ]; then
                modules+=("python")
            fi
            ;;
    esac
    
    # Remove duplicates
    local unique_modules=($(echo "${modules[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
    
    echo "${unique_modules[@]}"
}

# Check if module is available
module_available() {
    local module_name="$1"
    local module_path="$CLAUDER_ROOT/modules/$module_name"
    
    if [ -d "$module_path" ] && [ -f "$module_path/module.json" ]; then
        return 0
    fi
    return 1
}

# Main detection function
detect_and_analyze() {
    local quiet_mode="${1:-false}"
    
    if [ "$quiet_mode" != "true" ]; then
        echo "======================================"
        echo "Clauder Auto-Detection System"
        echo "======================================"
        echo ""
    fi
    
    # Detect CLAUDE.md
    if ! detect_claude_md >/dev/null 2>&1; then
        if [ "$quiet_mode" != "true" ]; then
            echo -e "${YELLOW}INFO:${NC} No CLAUDE.md found"
            echo "Creating from template..."
        fi
        return 1
    fi
    
    # Analyze and generate module list
    local modules=$(generate_module_list)
    
    if [ "$quiet_mode" != "true" ]; then
        echo ""
        echo -e "${GREEN}RECOMMENDED MODULES:${NC}"
        for module in $modules; do
            if module_available "$module"; then
                echo "  ✓ $module (available)"
            else
                echo "  ✗ $module (not found)"
            fi
        done
        
        echo ""
        echo "======================================"
    fi
    
    # Return module list
    echo "$modules"
}

# Export functions
export -f detect_claude_md
export -f analyze_requirements
export -f detect_project_type
export -f generate_module_list
export -f module_available

# Run if executed directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    detect_and_analyze
fi