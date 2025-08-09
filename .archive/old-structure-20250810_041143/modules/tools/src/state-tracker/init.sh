#\!/bin/bash
# State Tracker Module Component

MODULE_DIR="$(dirname ${BASH_SOURCE[0]})"
source "$MODULE_DIR/core.sh"

# Export state management functions
export -f show_state
export -f update_stage
export -f add_completed
export -f record_error
export -f show_log
export -f show_metrics
export -f create_checkpoint
export -f list_archives

echo "TOOLS: State tracker loaded"
