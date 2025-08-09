#!/bin/bash
# Remove emojis from markdown files and replace with keywords

# Emoji to keyword mapping
declare -A emoji_map=(
    ["🔴"]="CRITICAL:"
    ["🟡"]="IMPORTANT:"
    ["🟢"]="NORMAL:"
    ["❌"]="FORBIDDEN:"
    ["✅"]="DONE:"
    ["✓"]="YES"
    ["✗"]="NO"
    ["⚠️"]="WARNING:"
    ["🚨"]="ALERT:"
    ["📌"]="NOTE:"
    ["📝"]="DOCUMENT:"
    ["📋"]="CHECKLIST:"
    ["🛠️"]="TOOLS:"
    ["💡"]="TIP:"
    ["🎯"]="TARGET:"
    ["🔍"]="CURRENT:"
    ["⚡"]="QUICK:"
    ["🚀"]="START:"
    ["➡️"]="->"
    ["⬆️"]="UP"
    ["⬇️"]="DOWN"
    ["↗️"]="LINK:"
    ["🏁"]="COMPLETE:"
    ["✨"]="NEW:"
    ["⭐"]="FEATURE:"
    ["🔶"]="*"
    ["🔷"]="*"
    ["❓"]="QUESTION:"
    ["❗"]="IMPORTANT:"
    ["1️⃣"]="1."
    ["2️⃣"]="2."
    ["3️⃣"]="3."
    ["4️⃣"]="4."
    ["5️⃣"]="5."
)

# Function to process a single file
process_file() {
    local file="$1"
    local temp_file="${file}.tmp"
    local changed=false
    
    echo "Processing: $file"
    
    # Copy original file to temp
    cp "$file" "$temp_file"
    
    # Replace each emoji with keyword
    for emoji in "${!emoji_map[@]}"; do
        keyword="${emoji_map[$emoji]}"
        if grep -q "$emoji" "$temp_file"; then
            sed -i.bak "s/$emoji/$keyword/g" "$temp_file"
            changed=true
            echo "  Replaced $emoji with $keyword"
        fi
    done
    
    # Remove any remaining emojis (catch-all)
    # This regex removes most common emoji ranges
    if perl -i -pe 's/[\x{1F300}-\x{1F9FF}]//g' "$temp_file" 2>/dev/null; then
        changed=true
    fi
    
    # If file changed, replace original
    if [ "$changed" = true ]; then
        mv "$temp_file" "$file"
        rm -f "${temp_file}.bak"
        echo "  ✓ Updated $file"
    else
        rm "$temp_file"
        echo "  - No changes needed"
    fi
}

# Main execution
main() {
    echo "======================================"
    echo "Emoji Removal Tool"
    echo "======================================"
    echo ""
    
    # Check if dry-run mode
    DRY_RUN=false
    if [[ "$1" == "--dry-run" ]]; then
        DRY_RUN=true
        echo "DRY RUN MODE - No files will be modified"
        echo ""
    fi
    
    # Process specific directories
    directories=(
        ".claude"
        ".base-principles"
        ".clauder-dev/principles"
    )
    
    total=0
    processed=0
    
    for dir in "${directories[@]}"; do
        if [[ -d "$dir" ]]; then
            echo "Scanning directory: $dir"
            while IFS= read -r -d '' file; do
                if [[ "$DRY_RUN" == false ]]; then
                    process_file "$file"
                    ((processed++))
                else
                    echo "Would process: $file"
                fi
                ((total++))
            done < <(find "$dir" -name "*.md" -type f -print0)
            echo ""
        fi
    done
    
    # Summary
    echo "======================================"
    echo "Summary"
    echo "======================================"
    if [[ "$DRY_RUN" == false ]]; then
        echo "Files processed: $processed/$total"
    else
        echo "Files found: $total (dry run - no changes made)"
    fi
}

# Run with arguments
main "$@"