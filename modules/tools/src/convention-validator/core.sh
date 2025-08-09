#!/bin/bash
# Convention validation script for Clauder documentation
# Ensures documents follow Claude Code optimized conventions

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
total_files=0
passed_files=0
warnings=0
errors=0

# Check for emojis in file
check_emoji() {
    local file="$1"
    # Common emoji ranges
    if grep -E "[🔴🟡🟢🔵⚫⚪🟠🟣🟤🔶🔷🔸🔹❌✅✓✗❓❗⚠️📌📝📋🚨🛠️💡🎯🔍🏁🚀✨⭐🌟💫🔥⚡🌈🎨🎭🎪🎯🎲🎳]" "$file" > /dev/null 2>&1; then
        echo -e "${YELLOW}WARNING${NC}: Emoji found in $file"
        ((warnings++))
        return 1
    fi
    return 0
}

# Check for required keywords
check_keywords() {
    local file="$1"
    local has_error=0
    
    # Skip non-markdown files
    if [[ ! "$file" =~ \.md$ ]]; then
        return 0
    fi
    
    # Check for doc_id (required for all docs)
    if ! grep -q "^doc_id:" "$file"; then
        echo -e "${RED}ERROR${NC}: Missing doc_id in $file"
        ((errors++))
        has_error=1
    fi
    
    # For CLAUDE.md specifically
    if [[ "$file" == *"CLAUDE.md" ]]; then
        for keyword in "IMMEDIATE" "REQUIRED" "FORBIDDEN"; do
            if ! grep -q "$keyword" "$file"; then
                echo -e "${RED}ERROR${NC}: Missing keyword '$keyword' in $file"
                ((errors++))
                has_error=1
            fi
        done
    fi
    
    return $has_error
}

# Check file structure
check_structure() {
    local file="$1"
    
    # Check for clear sections
    if [[ "$file" == *"CLAUDE.md" ]]; then
        if ! grep -q "^PURPOSE:" "$file"; then
            echo -e "${YELLOW}WARNING${NC}: Missing PURPOSE statement in $file"
            ((warnings++))
        fi
    fi
}

# Validate single file
validate_file() {
    local file="$1"
    local file_passed=1
    
    echo "Checking: $file"
    
    check_emoji "$file" || file_passed=0
    check_keywords "$file" || file_passed=0
    check_structure "$file" || file_passed=0
    
    if [[ $file_passed -eq 1 ]]; then
        echo -e "${GREEN}✓${NC} $file passed all checks"
        ((passed_files++))
    fi
    
    ((total_files++))
}

# Main validation
main() {
    echo "======================================"
    echo "Clauder Convention Validation"
    echo "======================================"
    echo ""
    
    # Check specific important files
    if [[ -f "CLAUDE.md" ]]; then
        validate_file "CLAUDE.md"
    fi
    
    # Check all markdown files in .claude/
    if [[ -d ".claude" ]]; then
        while IFS= read -r -d '' file; do
            validate_file "$file"
        done < <(find .claude -name "*.md" -type f -print0)
    fi
    
    # Summary
    echo ""
    echo "======================================"
    echo "Validation Summary"
    echo "======================================"
    echo "Total files checked: $total_files"
    echo -e "Files passed: ${GREEN}$passed_files${NC}"
    echo -e "Warnings: ${YELLOW}$warnings${NC}"
    echo -e "Errors: ${RED}$errors${NC}"
    
    # Calculate compliance rate
    if [[ $total_files -gt 0 ]]; then
        compliance=$((passed_files * 100 / total_files))
        echo "Compliance rate: ${compliance}%"
        
        if [[ $compliance -ge 95 ]]; then
            echo -e "${GREEN}✓ Convention compliance goal met!${NC}"
        else
            echo -e "${RED}✗ Convention compliance below 95% target${NC}"
        fi
    fi
    
    # Exit code based on errors
    if [[ $errors -gt 0 ]]; then
        exit 1
    fi
    exit 0
}

# Run main function
main "$@"