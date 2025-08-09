#!/bin/bash
# Safe emoji removal tool with backup and verification

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to remove emojis from a single file
remove_emojis_from_file() {
    local file="$1"
    local backup_dir=".emoji-backup-$(date +%Y%m%d)"
    
    # Create backup directory if not exists
    mkdir -p "$backup_dir/$(dirname "$file")"
    
    # Backup original file
    cp "$file" "$backup_dir/$file.backup"
    
    echo "Processing: $file"
    
    # Common emoji replacements
    sed -i.tmp \
        -e 's/🔴/CRITICAL:/g' \
        -e 's/🟡/IMPORTANT:/g' \
        -e 's/🟢/NORMAL:/g' \
        -e 's/🔄/CYCLE:/g' \
        -e 's/⚡/QUICK:/g' \
        -e 's/🔍/CURRENT:/g' \
        -e 's/🛠️/TOOLS:/g' \
        -e 's/📌/NOTE:/g' \
        -e 's/📝/DOCUMENT:/g' \
        -e 's/📋/CHECKLIST:/g' \
        -e 's/🚨/ALERT:/g' \
        -e 's/❌/FORBIDDEN:/g' \
        -e 's/✅/DONE:/g' \
        -e 's/⚠️/WARNING:/g' \
        -e 's/💡/TIP:/g' \
        -e 's/🎯/TARGET:/g' \
        -e 's/🚀/START:/g' \
        -e 's/🏁/COMPLETE:/g' \
        -e 's/✨/NEW:/g' \
        -e 's/⭐/FEATURE:/g' \
        -e 's/❓/QUESTION:/g' \
        -e 's/❗/IMPORTANT:/g' \
        -e 's/➡️/->/g' \
        -e 's/↗️/LINK:/g' \
        -e 's/📊/STATS:/g' \
        -e 's/🏗️/BUILD:/g' \
        -e 's/👀/REVIEW:/g' \
        -e 's/📂/FOLDER:/g' \
        -e 's/📄/FILE:/g' \
        -e 's/🌱/GROWTH:/g' \
        -e 's/💬/DISCUSS:/g' \
        -e 's/🎨/STYLE:/g' \
        -e 's/🔧/CONFIG:/g' \
        -e 's/📈/METRICS:/g' \
        -e 's/🔔/NOTIFY:/g' \
        -e 's/🏆/ACHIEVEMENT:/g' \
        -e 's/🎉/CELEBRATE:/g' \
        -e 's/🔀/MERGE:/g' \
        -e 's/🔟/10./g' \
        -e 's/0️⃣/0./g' \
        -e 's/1️⃣/1./g' \
        -e 's/2️⃣/2./g' \
        -e 's/3️⃣/3./g' \
        -e 's/4️⃣/4./g' \
        -e 's/5️⃣/5./g' \
        -e 's/6️⃣/6./g' \
        -e 's/7️⃣/7./g' \
        -e 's/8️⃣/8./g' \
        -e 's/9️⃣/9./g' \
        "$file"
    
    # Remove temp file
    rm -f "$file.tmp"
    
    echo -e "${GREEN}✓${NC} Processed $file"
}

# Main function
main() {
    echo "======================================"
    echo "Safe Emoji Removal Tool"
    echo "======================================"
    
    # Check for dry-run mode
    if [[ "$1" == "--dry-run" ]]; then
        echo "DRY RUN MODE - Showing what would be changed"
        echo ""
        
        for file in "${@:2}"; do
            if [[ -f "$file" ]]; then
                echo "Would process: $file"
                grep -E "[🔴🟡🟢🔄⚡🔍🛠️📌📝📋🚨❌✅⚠️💡🎯🚀🏁✨⭐❓❗➡️↗️📊🏗️👀📂📄🌱💬🎨🔧📈🔔🏆🎉🔀0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣🔟]" "$file" | head -3
            fi
        done
        exit 0
    fi
    
    # Build file list
    files_to_process=()
    for item in "$@"; do
        if [[ -f "$item" ]]; then
            files_to_process+=("$item")
        elif [[ -d "$item" ]]; then
            # Find all .md files in directory
            while IFS= read -r -d '' file; do
                files_to_process+=("$file")
            done < <(find "$item" -name "*.md" -type f -print0)
        fi
    done
    
    if [[ ${#files_to_process[@]} -eq 0 ]]; then
        echo "No markdown files found."
        exit 0
    fi
    
    # Confirm before proceeding
    echo -e "${YELLOW}WARNING:${NC} This will modify the following files:"
    for file in "${files_to_process[@]}"; do
        echo "  - $file"
    done
    
    echo ""
    read -p "Continue? (y/N): " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo "Aborted."
        exit 0
    fi
    
    # Process each file
    for file in "${files_to_process[@]}"; do
        if [[ -f "$file" ]]; then
            remove_emojis_from_file "$file"
        else
            echo -e "${RED}X${NC} File not found: $file"
        fi
    done
    
    echo ""
    echo "======================================"
    echo "Summary"
    echo "======================================"
    echo "Files processed: $#"
    echo "Backups saved in: .emoji-backup-$(date +%Y%m%d)/"
}

# Don't run automatically when sourced - only when executed directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi