#!/bin/bash
# Integration Test for Auto-Bridge System
# Tests the complete flow from detection to module loading

TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRIDGE_DIR="$TEST_DIR"
CORE_DIR="$(dirname "$BRIDGE_DIR")"
CLAUDER_ROOT="$(dirname "$CORE_DIR")"

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0

# Test function
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    echo -e "${BLUE}TEST:${NC} $test_name"
    
    if eval "$test_command" >/dev/null 2>&1; then
        echo -e "  ${GREEN}✓${NC} PASSED"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "  ${RED}✗${NC} FAILED"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Test detector
test_detector() {
    source "$BRIDGE_DIR/detector.sh"
    
    # Test CLAUDE.md detection
    run_test "CLAUDE.md detection" "detect_claude_md"
    
    # Test requirements analysis
    run_test "Requirements analysis" "analyze_requirements CLAUDE.md true"
    
    # Test project type detection
    run_test "Project type detection" "detect_project_type"
    
    # Test module list generation
    local modules=$(generate_module_list)
    run_test "Module list generation" "[ ! -z '$modules' ]"
}

# Test auto-loader
test_auto_loader() {
    # Clean environment
    unset LOADED_MODULES
    unset CLAUDER_AUTO_LOAD
    
    # Source auto-loader
    source "$BRIDGE_DIR/auto-loader.sh"
    
    # Test module engine check
    run_test "Module engine check" "check_module_engine"
    
    # Test module engine loading
    run_test "Module engine loading" "load_module_engine"
    
    # Test auto-loading (silent mode)
    run_test "Auto module loading" "auto_load_modules"
    
    # Check if modules were loaded
    run_test "Modules loaded check" "[ ! -z '$LOADED_MODULES' ]"
}

# Test command wrapper
test_command_wrapper() {
    # Source command wrapper
    source "$BRIDGE_DIR/command-wrapper.sh"
    
    # Test wrapper initialization
    run_test "Command wrapper init" "init_command_wrapper true"
    
    # Test wrapper functions exist
    run_test "Wrapper functions created" "type safe-emoji-remover >/dev/null 2>&1"
    
    # Test wrapper bin creation
    run_test "Wrapper binaries created" "[ -f '$CLAUDER_ROOT/.claude/bin/safe-emoji-remover' ]"
}

# Test config converter
test_config_converter() {
    # Clean up old config
    rm -f clauder.config .clauder.config
    
    # Source converter
    source "$BRIDGE_DIR/config-converter.sh"
    
    # Test CLAUDE.md parsing
    local parsed=$(parse_claude_md "" "true")
    run_test "CLAUDE.md parsing" "[ ! -z '$parsed' ]"
    
    # Test config generation
    run_test "Config generation" "generate_config '$parsed' clauder.config.test"
    
    # Test config file created
    run_test "Config file created" "[ -f 'clauder.config.test' ]"
    
    # Clean up test file
    rm -f clauder.config.test
}

# Test complete flow
test_complete_flow() {
    echo ""
    echo -e "${YELLOW}INTEGRATION:${NC} Testing complete flow"
    
    # Clean environment
    unset LOADED_MODULES
    unset CLAUDER_AUTO_LOAD
    unset CLAUDER_MODULES_LOADED
    
    # Simulate Claude Code starting
    echo -e "${BLUE}SIMULATING:${NC} Claude Code startup"
    
    # Source the hook (as Claude Code would)
    if [ -f "$CLAUDER_ROOT/.claude/hooks/auto-module-loader.sh" ]; then
        source "$CLAUDER_ROOT/.claude/hooks/auto-module-loader.sh"
        run_test "Hook execution" "[ '$CLAUDER_MODULES_LOADED' = 'true' ]"
    else
        run_test "Hook execution" "false"
    fi
    
    # Test that modules are available
    run_test "Modules available after hook" "[ ! -z '$LOADED_MODULES' ]"
    
    # Test command availability
    run_test "Commands available" "type safe-emoji-remover >/dev/null 2>&1"
}

# Test module functionality
test_module_functionality() {
    echo ""
    echo -e "${YELLOW}FUNCTIONALITY:${NC} Testing module functions"
    
    # Test if we can call module functions
    if type clauder_validate >/dev/null 2>&1; then
        run_test "Module functions callable" "true"
    else
        run_test "Module functions callable" "false"
    fi
}

# Main test runner
run_integration_tests() {
    echo "======================================"
    echo "Auto-Bridge System Integration Test"
    echo "======================================"
    echo ""
    
    # Run test suites
    echo -e "${YELLOW}SUITE 1:${NC} Detector Tests"
    test_detector
    echo ""
    
    echo -e "${YELLOW}SUITE 2:${NC} Auto-Loader Tests"
    test_auto_loader
    echo ""
    
    echo -e "${YELLOW}SUITE 3:${NC} Command Wrapper Tests"
    test_command_wrapper
    echo ""
    
    echo -e "${YELLOW}SUITE 4:${NC} Config Converter Tests"
    test_config_converter
    echo ""
    
    echo -e "${YELLOW}SUITE 5:${NC} Complete Flow Test"
    test_complete_flow
    echo ""
    
    echo -e "${YELLOW}SUITE 6:${NC} Functionality Test"
    test_module_functionality
    echo ""
    
    # Summary
    echo "======================================"
    echo "Test Summary"
    echo "======================================"
    echo -e "${GREEN}PASSED:${NC} $TESTS_PASSED tests"
    if [ $TESTS_FAILED -gt 0 ]; then
        echo -e "${RED}FAILED:${NC} $TESTS_FAILED tests"
    fi
    echo "======================================"
    
    # Return status
    if [ $TESTS_FAILED -eq 0 ]; then
        echo -e "${GREEN}SUCCESS:${NC} All tests passed!"
        return 0
    else
        echo -e "${RED}FAILURE:${NC} Some tests failed"
        return 1
    fi
}

# Run if executed directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    run_integration_tests
fi