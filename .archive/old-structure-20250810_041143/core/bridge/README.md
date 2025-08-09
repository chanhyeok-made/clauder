---
doc_id: 5003
created: 2025-08-10
type: documentation
module: bridge
---

# Auto-Bridge System

## Overview

The Auto-Bridge System provides transparent migration from traditional CLAUDE.md-based configuration to the modular system. It automatically detects project requirements, loads appropriate modules, and maintains backward compatibility.

## Components

### 1. Detector (`detector.sh`)
Analyzes project configuration and determines required modules.

**Features:**
- CLAUDE.md detection and parsing
- Project type identification (Node.js, Python, etc.)
- Automatic module recommendation
- Dependency analysis

**Usage:**
```bash
# Standalone detection
bash core/bridge/detector.sh

# Silent mode for scripting
source core/bridge/detector.sh
modules=$(detect_and_analyze "true")
```

### 2. Auto-Loader (`auto-loader.sh`)
Automatically loads detected modules when Claude Code starts.

**Features:**
- Automatic module detection
- Dependency resolution
- Silent initialization
- Compatibility layer creation

**Usage:**
```bash
# Direct execution
bash core/bridge/auto-loader.sh

# Source for current shell
source core/bridge/auto-loader.sh

# Auto-load via CLAUDE.md
# Add to CLAUDE.md:
source .claude/hooks/auto-module-loader.sh
```

### 3. Command Wrapper (`command-wrapper.sh`)
Provides backward compatibility for legacy commands.

**Wrapped Commands:**
- `safe-emoji-remover` → `modules/tools/bin/emoji-remover`
- `validate-convention` → `modules/tools/bin/validator`
- `state-tracker` → `modules/tools/bin/state-tracker`

**Usage:**
```bash
# After auto-loading, use commands normally
safe-emoji-remover README.md
validate-convention .
state-tracker show
```

### 4. Config Converter (`config-converter.sh`)
Converts CLAUDE.md to clauder.config format.

**Features:**
- YAML front matter parsing
- Module requirement detection
- Bidirectional sync
- Automatic config generation

**Usage:**
```bash
# Convert CLAUDE.md to clauder.config
bash core/bridge/config-converter.sh

# Sync configurations
source core/bridge/config-converter.sh
sync_configs "CLAUDE.md" "clauder.config"
```

## Integration with Claude Code

### Automatic Loading
Add to CLAUDE.md:
```markdown
## AUTO_LOAD: Module System
\```bash
source .claude/hooks/auto-module-loader.sh 2>/dev/null || true
\```
```

### Manual Loading
```bash
# Load all components
source core/bridge/auto-loader.sh
init_auto_loader

# Load specific component
source core/bridge/detector.sh
detect_and_analyze
```

## How It Works

### Detection Flow
1. Checks for CLAUDE.md or .claude/CLAUDE.md
2. Analyzes content for keywords (workflow, TODO, tools, etc.)
3. Checks .claude directory structure
4. Identifies project type (package.json, requirements.txt, etc.)
5. Generates module list

### Loading Flow
1. Sources detector for analysis
2. Loads module engine
3. Resolves dependencies
4. Initializes modules in order
5. Creates compatibility layer
6. Sets up command aliases

### Compatibility Flow
1. Creates wrapper functions
2. Sets up executable scripts in .claude/bin
3. Creates aliases for common commands
4. Falls back to legacy tools if modules unavailable

## Configuration

### Environment Variables
- `CLAUDER_AUTO_LOAD`: Enable auto-loading (default: true)
- `CLAUDER_MODULES_LOADED`: Indicates modules are loaded
- `CLAUDER_ROOT`: Project root directory
- `LOADED_MODULES`: Space-separated list of loaded modules

### Module Detection Keywords

**Workflow Module:**
- workflow
- TODO
- TodoWrite
- stage
- 단계

**Tools Module:**
- emoji
- state
- tracker
- 도구
- .claude directory presence

**Validation Module:**
- validation
- 검증
- convention
- 컨벤션

## Testing

### Run Integration Tests
```bash
bash core/bridge/test-integration.sh
```

### Test Individual Components
```bash
# Test detector
source core/bridge/detector.sh
detect_and_analyze

# Test auto-loader
bash core/bridge/auto-loader.sh

# Test converter
bash core/bridge/config-converter.sh
```

## Troubleshooting

### Modules Not Loading
1. Check CLAUDE.md exists and is readable
2. Verify modules directory exists
3. Check module.json files are valid
4. Run detector manually to see what's detected

### Commands Not Found
1. Ensure auto-loader ran successfully
2. Check .claude/bin directory was created
3. Verify wrapper functions are defined: `type safe-emoji-remover`

### Config Not Converting
1. Check CLAUDE.md has proper YAML front matter
2. Ensure write permissions in project directory
3. Run converter with error output: `bash -x core/bridge/config-converter.sh`

## Migration Guide

### From Legacy to Modules

#### Step 1: Add Auto-Loading
Add to CLAUDE.md:
```markdown
## AUTO_LOAD: Module System
\```bash
source .claude/hooks/auto-module-loader.sh 2>/dev/null || true
\```
```

#### Step 2: Test Detection
```bash
bash core/bridge/detector.sh
```

#### Step 3: Verify Loading
```bash
source core/bridge/auto-loader.sh
echo $LOADED_MODULES
```

#### Step 4: Use Commands
Commands work the same as before:
```bash
safe-emoji-remover docs/
validate-convention README.md
```

### Gradual Migration
The auto-bridge system allows gradual migration:
1. **Phase 1**: Auto-detection and loading (transparent)
2. **Phase 2**: Start using module features directly
3. **Phase 3**: Create custom modules
4. **Phase 4**: Full module-based workflow

## Benefits

### Zero Learning Curve
- Existing commands continue working
- No configuration changes required
- Automatic module detection

### Progressive Enhancement
- Start with basic compatibility
- Gradually adopt module features
- Maintain backward compatibility

### Transparent Operation
- No user intervention required
- Silent initialization
- Automatic fallbacks

## Future Enhancements

### Planned Features
- Custom module detection rules
- Project template generation
- Module marketplace integration
- Performance optimizations

### Extension Points
- Custom detectors for project types
- Additional command wrappers
- Config transformation plugins
- Hook system for events

## API Reference

### Detector Functions
- `detect_claude_md [file]` - Check for CLAUDE.md
- `analyze_requirements [file] [quiet]` - Analyze requirements
- `detect_project_type` - Identify project type
- `generate_module_list [file]` - Generate module list
- `module_available [name]` - Check module availability

### Auto-Loader Functions
- `init_auto_loader [silent]` - Initialize auto-loader
- `auto_load_modules` - Load detected modules
- `create_compatibility_layer` - Set up compatibility
- `clauder_auto_hook` - Shell initialization hook

### Wrapper Functions
- `init_command_wrapper [silent]` - Initialize wrappers
- `create_command_wrappers` - Create function wrappers
- `create_path_wrappers` - Create executable wrappers

### Converter Functions
- `parse_claude_md [file] [silent]` - Parse CLAUDE.md
- `generate_config [data] [output]` - Generate config
- `sync_configs [claude] [config]` - Sync configurations
- `convert_config` - Main conversion function

## Support

For issues or questions about the auto-bridge system:
1. Check this documentation
2. Run integration tests
3. Check .clauder-dev/analysis/ for design documents
4. Review module documentation in modules/*/README.md