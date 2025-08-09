#\!/bin/bash
# Convention Validator Module Component

MODULE_DIR="$(dirname ${BASH_SOURCE[0]})"
source "$MODULE_DIR/core.sh"

# Export validation functions
export -f check_doc_id
export -f check_emoji
export -f check_keywords
export -f validate_file

echo "TOOLS: Convention validator loaded"
