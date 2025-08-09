#!/bin/bash
# State Tracking and Management Tool
# Version 2.0 - Enhanced state management for Clauder

STATE_DIR=".claude/state"
CURRENT_STATE="$STATE_DIR/current.json"
SESSION_LOG="$STATE_DIR/session.log"
METRICS_FILE="$STATE_DIR/metrics.json"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function: Display current state
show_state() {
    echo "======================================"
    echo "Current Workflow State"
    echo "======================================"
    
    if [ ! -f "$CURRENT_STATE" ]; then
        echo -e "${RED}ERROR:${NC} No active session found"
        echo "Run workflow initialization first"
        return 1
    fi
    
    # Parse state file
    SESSION_ID=$(grep '"session_id"' "$CURRENT_STATE" | cut -d'"' -f4)
    STAGE=$(grep '"stage"' "$CURRENT_STATE" | cut -d'"' -f4)
    SUBSTAGE=$(grep '"substage"' "$CURRENT_STATE" | cut -d'"' -f4)
    START_TIME=$(grep '"start_time"' "$CURRENT_STATE" | cut -d'"' -f4)
    COMPLIANCE=$(grep '"compliance_rate"' "$CURRENT_STATE" | cut -d':' -f2 | cut -d',' -f1 | tr -d ' ')
    
    echo -e "${BLUE}Session ID:${NC} $SESSION_ID"
    echo -e "${BLUE}Current Stage:${NC} $STAGE"
    echo -e "${BLUE}Substage:${NC} $SUBSTAGE"
    echo -e "${BLUE}Started:${NC} $START_TIME"
    echo -e "${BLUE}Compliance:${NC} ${COMPLIANCE}%"
    echo ""
}

# Function: Update stage
update_stage() {
    local new_stage="$1"
    local new_substage="$2"
    
    if [ ! -f "$CURRENT_STATE" ]; then
        echo -e "${RED}ERROR:${NC} No active session"
        return 1
    fi
    
    # Update using sed (works everywhere)
    sed -i.bak "s/\"stage\": \"[^\"]*\"/\"stage\": \"$new_stage\"/" "$CURRENT_STATE"
    sed -i.bak "s/\"substage\": \"[^\"]*\"/\"substage\": \"$new_substage\"/" "$CURRENT_STATE"
    
    # Update checkpoint
    TIMESTAMP=$(date -u '+%Y-%m-%dT%H:%M:%SZ')
    sed -i.bak "s/\"last_checkpoint\": \"[^\"]*\"/\"last_checkpoint\": \"$TIMESTAMP\"/" "$CURRENT_STATE"
    
    # Log the update
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Stage updated: $new_stage/$new_substage" >> "$SESSION_LOG"
    
    echo -e "${GREEN}DONE:${NC} Stage updated to $new_stage ($new_substage)"
}

# Function: Add completed step
add_completed() {
    local step="$1"
    
    if [ ! -f "$CURRENT_STATE" ]; then
        echo -e "${RED}ERROR:${NC} No active session"
        return 1
    fi
    
    # This is simplified - in production would use jq
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completed: $step" >> "$SESSION_LOG"
    echo -e "${GREEN}DONE:${NC} Step marked as completed: $step"
}

# Function: Record error
record_error() {
    local error="$1"
    local solution="$2"
    
    if [ ! -f "$CURRENT_STATE" ]; then
        echo -e "${RED}ERROR:${NC} No active session"
        return 1
    fi
    
    # Log error and solution
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $error" >> "$SESSION_LOG"
    if [ -n "$solution" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] SOLUTION: $solution" >> "$SESSION_LOG"
    fi
    
    echo -e "${YELLOW}RECORDED:${NC} Error logged with solution"
}

# Function: Show session log
show_log() {
    if [ ! -f "$SESSION_LOG" ]; then
        echo -e "${RED}ERROR:${NC} No session log found"
        return 1
    fi
    
    echo "======================================"
    echo "Session Log"
    echo "======================================"
    
    # Show last N lines or all
    if [ "$1" = "--all" ]; then
        cat "$SESSION_LOG"
    else
        tail -n "${1:-20}" "$SESSION_LOG"
    fi
}

# Function: Show metrics
show_metrics() {
    if [ ! -f "$METRICS_FILE" ]; then
        echo -e "${RED}ERROR:${NC} No metrics file found"
        return 1
    fi
    
    echo "======================================"
    echo "Workflow Metrics"
    echo "======================================"
    
    cat "$METRICS_FILE" | python3 -m json.tool 2>/dev/null || cat "$METRICS_FILE"
}

# Function: Create checkpoint
create_checkpoint() {
    local name="${1:-checkpoint}"
    
    if [ ! -f "$CURRENT_STATE" ]; then
        echo -e "${RED}ERROR:${NC} No active session"
        return 1
    fi
    
    TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
    CHECKPOINT_FILE="$STATE_DIR/checkpoints/${name}-${TIMESTAMP}.json"
    
    mkdir -p "$STATE_DIR/checkpoints"
    cp "$CURRENT_STATE" "$CHECKPOINT_FILE"
    
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Checkpoint created: $name" >> "$SESSION_LOG"
    echo -e "${GREEN}DONE:${NC} Checkpoint saved: $CHECKPOINT_FILE"
}

# Function: List archives
list_archives() {
    echo "======================================"
    echo "Archived Sessions"
    echo "======================================"
    
    if [ -d "$STATE_DIR/archives" ]; then
        ls -la "$STATE_DIR/archives/"*.json 2>/dev/null | tail -10
    else
        echo "No archives found"
    fi
}

# Main command handler
case "$1" in
    "show"|"status")
        show_state
        ;;
    "update")
        update_stage "$2" "$3"
        ;;
    "complete")
        add_completed "$2"
        ;;
    "error")
        record_error "$2" "$3"
        ;;
    "log")
        show_log "$2"
        ;;
    "metrics")
        show_metrics
        ;;
    "checkpoint")
        create_checkpoint "$2"
        ;;
    "archives")
        list_archives
        ;;
    *)
        echo "State Tracker - Workflow State Management"
        echo ""
        echo "Usage: $0 <command> [options]"
        echo ""
        echo "Commands:"
        echo "  show/status         - Show current state"
        echo "  update <s> <sub>    - Update stage and substage"
        echo "  complete <step>     - Mark step as completed"
        echo "  error <e> [sol]     - Record error with optional solution"
        echo "  log [n|--all]       - Show last n lines of log (default 20)"
        echo "  metrics             - Show workflow metrics"
        echo "  checkpoint [name]   - Create named checkpoint"
        echo "  archives            - List archived sessions"
        echo ""
        echo "Examples:"
        echo "  $0 show"
        echo "  $0 update implementation coding"
        echo "  $0 complete \"Added rate limiting\""
        echo "  $0 error \"Type mismatch\" \"Fixed imports\""
        ;;
esac