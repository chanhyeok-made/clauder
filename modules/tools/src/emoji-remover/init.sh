#\!/bin/bash
# Emoji Remover Module Component

MODULE_DIR="$(dirname ${BASH_SOURCE[0]})"
source "$MODULE_DIR/core.sh"

# Export main function
export -f remove_emojis_from_file
export -f main

echo "TOOLS: Emoji remover loaded"
