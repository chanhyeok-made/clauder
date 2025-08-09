#!/bin/bash
# Clauder Enhanced Workflow State Management System
# Version 2.0 - Token optimized, state tracking enhanced

# Configuration
WORKFLOW_LOCK=".claude/state/.workflow.lock"
STATE_DIR=".claude/state"
ARCHIVE_DIR="$STATE_DIR/archives"
SESSION_LOG="$STATE_DIR/session.log"
METRICS_FILE="$STATE_DIR/metrics.json"

# Create necessary directories
mkdir -p "$STATE_DIR" "$ARCHIVE_DIR"

# Function: Archive previous session
archive_session() {
    if [ -f "$STATE_DIR/current.json" ]; then
        local session_id=$(grep '"session_id"' "$STATE_DIR/current.json" | cut -d'"' -f4)
        if [ -n "$session_id" ]; then
            mv "$STATE_DIR/current.json" "$ARCHIVE_DIR/session-$session_id.json"
            echo "ARCHIVED: Session $session_id"
        fi
    fi
}

# Function: Initialize metrics
init_metrics() {
    if [ ! -f "$METRICS_FILE" ]; then
        cat > "$METRICS_FILE" << EOF
{
    "total_sessions": 0,
    "tasks_completed": 0,
    "errors_fixed": 0,
    "compliance_rate": 95,
    "token_efficiency": "optimized",
    "last_updated": "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
}
EOF
    fi
}

# Function: Update session state
update_state() {
    local field="$1"
    local value="$2"
    
    if [ -f "$STATE_DIR/current.json" ]; then
        # Use jq if available, otherwise use sed
        if command -v jq &> /dev/null; then
            jq ".${field} = \"${value}\"" "$STATE_DIR/current.json" > "$STATE_DIR/current.json.tmp"
            mv "$STATE_DIR/current.json.tmp" "$STATE_DIR/current.json"
        else
            sed -i.bak "s/\"${field}\": \"[^\"]*\"/\"${field}\": \"${value}\"/" "$STATE_DIR/current.json"
        fi
    fi
}

# Check if workflow is already started
if [ ! -f "$WORKFLOW_LOCK" ]; then
    echo "START: Initializing enhanced workflow management"
    
    # Archive any previous session
    archive_session
    
    # Create lock file
    echo "$(date '+%Y-%m-%d %H:%M:%S')" > "$WORKFLOW_LOCK"
    
    # Initialize metrics
    init_metrics
    
    # Generate session ID
    SESSION_ID="$(date '+%Y%m%d-%H%M%S')"
    
    # Create enhanced state file
    cat > "$STATE_DIR/current.json" << EOF
{
    "session_id": "$SESSION_ID",
    "stage": "analysis",
    "substage": "requirements_clarification",
    "completed_steps": [],
    "pending_tasks": [],
    "current_files": [],
    "errors_encountered": [],
    "solutions_applied": [],
    "start_time": "$(date -u '+%Y-%m-%dT%H:%M:%SZ')",
    "last_checkpoint": "$(date -u '+%Y-%m-%dT%H:%M:%SZ')",
    "workflow_version": "2.0",
    "compliance_rate": 95,
    "token_optimization": true,
    "state_tracking": "enhanced",
    "auto_recovery": true
}
EOF
    
    # Initialize session log
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Session $SESSION_ID initialized" > "$SESSION_LOG"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Workflow version: 2.0" >> "$SESSION_LOG"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Compliance rate: 95%" >> "$SESSION_LOG"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Token optimization: ENABLED" >> "$SESSION_LOG"
    
    echo "DONE: Workflow ready (Session: $SESSION_ID)"
    echo "CURRENT: Stage - Analysis (Requirements Clarification)"
    echo "COMPLIANCE: 95% keyword-based documentation"
    echo "OPTIMIZATION: Token efficiency enabled"
    echo ""
    echo "REQUIRED: Generate workflow TODOs using TodoWrite:"
    echo "   1.1 Analysis: Clarify requirements"
    echo "   1.2 Analysis: Determine approach"
    echo "   ... (See CLAUDE.md for full list)"
else
    # Resume existing session
    if [ -f "$STATE_DIR/current.json" ]; then
        STAGE=$(grep '"stage"' "$STATE_DIR/current.json" | cut -d'"' -f4)
        SUBSTAGE=$(grep '"substage"' "$STATE_DIR/current.json" | cut -d'"' -f4)
        SESSION_ID=$(grep '"session_id"' "$STATE_DIR/current.json" | cut -d'"' -f4)
        
        echo "RESUME: Session $SESSION_ID"
        echo "CURRENT: Stage - $STAGE ($SUBSTAGE)"
        
        # Log resumption
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Session resumed: $STAGE/$SUBSTAGE" >> "$SESSION_LOG"
        
        # Update last checkpoint
        update_state "last_checkpoint" "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
    else
        echo "WARNING: State file missing, reinitializing..."
        rm -f "$WORKFLOW_LOCK"
        exec "$0" "$@"
    fi
fi

# Function: Enhanced cleanup with state preservation
cleanup() {
    if [ -f "$WORKFLOW_LOCK" ]; then
        echo ""
        echo "COMPLETE: Finalizing workflow session"
        
        # Update final state
        if [ -f "$STATE_DIR/current.json" ]; then
            update_state "end_time" "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
            
            # Calculate session duration
            START_TIME=$(grep '"start_time"' "$STATE_DIR/current.json" | cut -d'"' -f4)
            END_TIME=$(date -u '+%Y-%m-%dT%H:%M:%SZ')
            
            # Log completion
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] Session completed" >> "$SESSION_LOG"
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] Duration: $START_TIME to $END_TIME" >> "$SESSION_LOG"
            
            # Archive current session
            cp "$STATE_DIR/current.json" "$STATE_DIR/last-session.json"
        fi
        
        # Remove lock
        rm "$WORKFLOW_LOCK"
        echo "DONE: Ready for next session"
    fi
}

# Register cleanup on exit
trap cleanup EXIT

# Export environment variables for other tools
export CLAUDER_STATE_DIR="$STATE_DIR"
export CLAUDER_SESSION_ID="${SESSION_ID:-unknown}"
export CLAUDER_WORKFLOW_VERSION="2.0"