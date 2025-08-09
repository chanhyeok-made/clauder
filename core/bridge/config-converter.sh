#!/bin/bash
# Config Converter - CLAUDE.md to clauder.config
# Transforms legacy configuration to module system format

BRIDGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CORE_DIR="$(dirname "$BRIDGE_DIR")"
CLAUDER_ROOT="$(dirname "$CORE_DIR")"

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Parse CLAUDE.md for configuration
parse_claude_md() {
    local claude_file="${1:-CLAUDE.md}"
    local config_data=""
    local silent="${2:-false}"
    
    if [ ! -f "$claude_file" ]; then
        if [ -f ".claude/CLAUDE.md" ]; then
            claude_file=".claude/CLAUDE.md"
        else
            if [ "$silent" != "true" ]; then
                echo -e "${RED}ERROR:${NC} CLAUDE.md not found" >&2
            fi
            return 1
        fi
    fi
    
    if [ "$silent" != "true" ]; then
        echo -e "${BLUE}PARSING:${NC} $claude_file" >&2
    fi
    
    # Extract metadata from YAML front matter
    local in_frontmatter=false
    local project_name=""
    local priority=""
    
    while IFS= read -r line; do
        if [[ "$line" == "---" ]]; then
            if [ "$in_frontmatter" = false ]; then
                in_frontmatter=true
            else
                in_frontmatter=false
            fi
        elif [ "$in_frontmatter" = true ]; then
            if [[ "$line" =~ ^project:\ (.+)$ ]]; then
                project_name="${BASH_REMATCH[1]}"
            elif [[ "$line" =~ ^priority:\ (.+)$ ]]; then
                priority="${BASH_REMATCH[1]}"
            fi
        fi
    done < "$claude_file"
    
    # Detect required modules from content
    local modules=()
    
    if grep -q "workflow\|TODO\|TodoWrite" "$claude_file" 2>/dev/null; then
        modules+=("workflow")
    fi
    
    if grep -q "validation\|convention" "$claude_file" 2>/dev/null; then
        modules+=("validation")
    fi
    
    if grep -q "tools\|emoji\|state" "$claude_file" 2>/dev/null; then
        modules+=("tools")
    fi
    
    # Default modules if none detected
    if [ ${#modules[@]} -eq 0 ]; then
        modules=("workflow" "tools")
    fi
    
    echo "$project_name|$priority|${modules[@]}"
}

# Generate clauder.config from parsed data
generate_config() {
    local parse_result="$1"
    local output_file="${2:-clauder.config}"
    
    IFS='|' read -r project_name priority modules_str <<< "$parse_result"
    
    # Create config structure
    cat > "$output_file" << EOF
{
  "version": "1.0.0",
  "project": {
    "name": "${project_name:-Clauder Project}",
    "priority": "${priority:-normal}"
  },
  "modules": {
EOF
    
    # Add module configurations
    local first=true
    for module in $modules_str; do
        if [ "$first" = true ]; then
            first=false
        else
            echo "," >> "$output_file"
        fi
        
        case "$module" in
            "workflow")
                cat >> "$output_file" << 'EOF'
    "workflow": {
      "enabled": true,
      "version": "^2.0.0",
      "config": {
        "auto_todos": true,
        "strict_stages": true
      }
    }
EOF
                ;;
            "tools")
                cat >> "$output_file" << 'EOF'
    "tools": {
      "enabled": true,
      "version": "^1.0.0",
      "config": {
        "emoji_removal": true,
        "convention_validation": true,
        "state_tracking": true
      }
    }
EOF
                ;;
            "validation")
                cat >> "$output_file" << 'EOF'
    "validation": {
      "enabled": true,
      "version": "^1.0.0",
      "config": {
        "strict_mode": true,
        "target_compliance": 95
      }
    }
EOF
                ;;
        esac
    done
    
    cat >> "$output_file" << 'EOF'
  },
  "hooks": {
    "pre_commit": [],
    "post_load": ["auto-module-loader.sh"]
  },
  "environment": {
    "CLAUDER_AUTO_LOAD": "true"
  }
}
EOF
    
    echo -e "${GREEN}SUCCESS:${NC} Generated $output_file"
}

# Convert .claude directory structure to module config
convert_claude_structure() {
    local claude_dir=".claude"
    local config_additions=""
    
    if [ ! -d "$claude_dir" ]; then
        return 0
    fi
    
    echo -e "${BLUE}ANALYZING:${NC} .claude directory structure"
    
    # Check for custom tools
    if [ -d "$claude_dir/tools" ]; then
        local custom_tools=$(ls "$claude_dir/tools"/*.sh 2>/dev/null | wc -l)
        if [ "$custom_tools" -gt 0 ]; then
            echo "  FOUND: $custom_tools custom tools"
            config_additions="custom_tools:$custom_tools"
        fi
    fi
    
    # Check for workflow definitions
    if [ -d "$claude_dir/workflow" ]; then
        echo "  FOUND: Workflow definitions"
        config_additions="$config_additions|workflow_custom:true"
    fi
    
    # Check for templates
    if [ -d "$claude_dir/templates" ]; then
        echo "  FOUND: Custom templates"
        config_additions="$config_additions|templates:true"
    fi
    
    echo "$config_additions"
}

# Sync configuration bidirectionally
sync_configs() {
    local claude_file="${1:-CLAUDE.md}"
    local config_file="${2:-clauder.config}"
    
    echo -e "${BLUE}SYNCING:${NC} Configurations"
    
    # Check which is newer
    if [ -f "$claude_file" ] && [ -f "$config_file" ]; then
        if [ "$claude_file" -nt "$config_file" ]; then
            echo "  CLAUDE.md is newer - updating clauder.config"
            local parsed=$(parse_claude_md "$claude_file")
            generate_config "$parsed" "$config_file"
        elif [ "$config_file" -nt "$claude_file" ]; then
            echo "  clauder.config is newer - no update needed"
        else
            echo "  Configurations are in sync"
        fi
    elif [ -f "$claude_file" ] && [ ! -f "$config_file" ]; then
        echo "  Creating clauder.config from CLAUDE.md"
        local parsed=$(parse_claude_md "$claude_file")
        generate_config "$parsed" "$config_file"
    else
        echo "  No configuration files found"
        return 1
    fi
    
    return 0
}

# Main converter function
convert_config() {
    echo "======================================"
    echo "Clauder Config Converter"
    echo "======================================"
    echo ""
    
    # Parse CLAUDE.md (show parsing message)
    parse_claude_md "" "false" >/dev/null
    
    # Parse again silently for actual data
    local parse_result=$(parse_claude_md "" "true")
    if [ $? -ne 0 ]; then
        return 1
    fi
    
    # Analyze .claude structure
    local structure_info=$(convert_claude_structure)
    
    # Generate config
    generate_config "$parse_result"
    
    # Create compatibility symlink
    if [ -f "clauder.config" ] && [ ! -f ".clauder.config" ]; then
        ln -s clauder.config .clauder.config
        echo -e "${GREEN}LINK:${NC} Created .clauder.config symlink"
    fi
    
    echo ""
    echo "======================================"
    echo -e "${GREEN}COMPLETE:${NC} Configuration converted"
    echo "======================================"
}

# Export functions
export -f parse_claude_md
export -f generate_config
export -f convert_claude_structure
export -f sync_configs
export -f convert_config

# Run if executed directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    convert_config "$@"
fi