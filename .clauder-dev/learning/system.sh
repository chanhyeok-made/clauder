#!/bin/bash
# Clauder Learning System - Resonation 없이 자체 학습
# 프로젝트 사용 패턴을 학습하고 개선

LEARNING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDER_ROOT="$(cd "$(dirname "$(dirname "$LEARNING_DIR")")" && pwd)"

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 학습 데이터 디렉토리
PATTERNS_DIR="$LEARNING_DIR/patterns"
MEMORY_DIR="$LEARNING_DIR/project-memory"
INSIGHTS_DIR="$LEARNING_DIR/insights"

# 디렉토리 초기화
init_learning_dirs() {
    mkdir -p "$PATTERNS_DIR"/{errors,success,optimization}
    mkdir -p "$MEMORY_DIR"/{conventions,preferences,history}
    mkdir -p "$INSIGHTS_DIR"/{automated,manual}
    
    echo -e "${GREEN}LEARNING:${NC} 학습 시스템 초기화 완료"
}

# 에러 패턴 학습
learn_from_error() {
    local error_type="$1"
    local error_msg="$2"
    local solution="$3"
    local files_modified="$4"
    
    local date_stamp=$(date +%Y%m%d)
    local time_stamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    cat >> "$PATTERNS_DIR/errors/$date_stamp.md" << EOF

## [$time_stamp] $error_type
**에러**: $error_msg
**해결**: $solution
**수정 파일**: $files_modified
**컨텍스트**: $(pwd)
---
EOF
    
    echo -e "${BLUE}LEARNED:${NC} 에러 패턴 저장됨"
}

# 성공 패턴 학습
learn_from_success() {
    local task="$1"
    local approach="$2"
    local duration="${3:-unknown}"
    
    local date_stamp=$(date +%Y%m%d)
    local time_stamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    cat >> "$PATTERNS_DIR/success/$date_stamp.md" << EOF

## [$time_stamp] $task
**접근법**: $approach
**소요시간**: $duration
**결과**: 성공
**워크플로우 단계**: $(get_current_stage 2>/dev/null || echo "unknown")
---
EOF
    
    echo -e "${GREEN}LEARNED:${NC} 성공 패턴 저장됨"
}

# 프로젝트 특성 기억
remember_project_trait() {
    local trait_type="$1"  # convention, preference, pattern
    local trait_name="$2"
    local trait_value="$3"
    
    local file="$MEMORY_DIR/$trait_type/$trait_name.txt"
    
    # 기존 값과 비교
    if [ -f "$file" ]; then
        local existing=$(cat "$file")
        if [ "$existing" != "$trait_value" ]; then
            # 변경 이력 저장
            echo "$(date '+%Y-%m-%d'): $existing → $trait_value" >> "$file.history"
        fi
    fi
    
    # 새 값 저장
    echo "$trait_value" > "$file"
    
    echo -e "${BLUE}MEMORY:${NC} $trait_type/$trait_name 기억됨"
}

# 유사 패턴 검색
find_similar_pattern() {
    local current_issue="$1"
    local pattern_type="${2:-errors}"  # errors, success, optimization
    
    echo -e "${BLUE}SEARCHING:${NC} 유사 패턴 검색 중..."
    
    # 패턴 검색
    local matches=$(grep -r "$current_issue" "$PATTERNS_DIR/$pattern_type/" 2>/dev/null | head -5)
    
    if [ ! -z "$matches" ]; then
        echo -e "${GREEN}FOUND:${NC} 유사 패턴 발견:"
        echo "$matches"
        
        # 가장 최근 해결책 제안
        local latest=$(ls -t "$PATTERNS_DIR/$pattern_type/"*.md 2>/dev/null | head -1)
        if [ -f "$latest" ]; then
            echo -e "${YELLOW}SUGGESTION:${NC} 최근 유사 해결책:"
            grep -A 2 "$current_issue" "$latest" | head -5
        fi
    else
        echo -e "${YELLOW}INFO:${NC} 유사 패턴 없음 (새로운 문제)"
    fi
}

# 커밋 스타일 학습
learn_commit_style() {
    local recent_commits=$(git log --format='%s' -10 2>/dev/null)
    
    if [ ! -z "$recent_commits" ]; then
        # 패턴 분석
        local has_emoji=$(echo "$recent_commits" | grep -c "🤖\|✨\|🔧\|📝")
        local has_type=$(echo "$recent_commits" | grep -c "^feat:\|^fix:\|^docs:\|^refactor:")
        
        local style="unknown"
        if [ $has_type -gt 5 ]; then
            style="conventional"  # feat:, fix:, etc.
        elif [ $has_emoji -gt 3 ]; then
            style="emoji"  # 이모지 사용
        else
            style="simple"  # 단순 메시지
        fi
        
        remember_project_trait "conventions" "commit-style" "$style"
    fi
}

# 파일 구조 패턴 학습
learn_file_structure() {
    # 주요 디렉토리 감지
    local has_src=$([ -d "src" ] && echo "true" || echo "false")
    local has_lib=$([ -d "lib" ] && echo "true" || echo "false")
    local has_components=$([ -d "components" ] && echo "true" || echo "false")
    local has_modules=$([ -d "modules" ] && echo "true" || echo "false")
    
    local structure="standard"
    if [ "$has_src" = "true" ]; then
        structure="src-based"
    elif [ "$has_lib" = "true" ]; then
        structure="lib-based"
    elif [ "$has_components" = "true" ]; then
        structure="component-based"
    elif [ "$has_modules" = "true" ]; then
        structure="modular"
    fi
    
    remember_project_trait "conventions" "file-structure" "$structure"
}

# 자주 사용하는 명령 추적
track_frequent_command() {
    local command="$1"
    local frequency_file="$MEMORY_DIR/preferences/command-frequency.txt"
    
    # 빈도 증가
    if [ -f "$frequency_file" ]; then
        local count=$(grep "^$command:" "$frequency_file" | cut -d: -f2)
        if [ ! -z "$count" ]; then
            # 기존 카운트 업데이트
            sed -i.bak "s/^$command:.*/$command:$((count + 1))/" "$frequency_file"
        else
            # 새 명령 추가
            echo "$command:1" >> "$frequency_file"
        fi
    else
        echo "$command:1" > "$frequency_file"
    fi
    
    # 자주 사용하는 명령 감지 (10회 이상)
    local frequency=$(grep "^$command:" "$frequency_file" | cut -d: -f2)
    if [ "$frequency" -ge 10 ]; then
        echo -e "${YELLOW}TIP:${NC} '$command'을(를) 자주 사용합니다. 별칭 생성을 고려하세요."
    fi
}

# 자동 통찰 생성
generate_insights() {
    local insight_file="$INSIGHTS_DIR/automated/$(date +%Y%m).md"
    
    echo "# 자동 생성 통찰 - $(date '+%Y-%m')" > "$insight_file"
    echo "" >> "$insight_file"
    
    # 가장 많은 에러 타입
    if [ -d "$PATTERNS_DIR/errors" ]; then
        echo "## 자주 발생하는 에러" >> "$insight_file"
        grep "^##" "$PATTERNS_DIR/errors/"*.md 2>/dev/null | \
            cut -d: -f2 | sort | uniq -c | sort -rn | head -5 >> "$insight_file"
        echo "" >> "$insight_file"
    fi
    
    # 성공 패턴
    if [ -d "$PATTERNS_DIR/success" ]; then
        echo "## 성공적인 접근법" >> "$insight_file"
        grep "**접근법**:" "$PATTERNS_DIR/success/"*.md 2>/dev/null | \
            cut -d: -f2- | sort | uniq -c | sort -rn | head -5 >> "$insight_file"
        echo "" >> "$insight_file"
    fi
    
    # 프로젝트 특성
    echo "## 프로젝트 특성" >> "$insight_file"
    for trait_file in "$MEMORY_DIR/conventions/"*.txt; do
        if [ -f "$trait_file" ]; then
            local trait_name=$(basename "$trait_file" .txt)
            local trait_value=$(cat "$trait_file")
            echo "- $trait_name: $trait_value" >> "$insight_file"
        fi
    done
    
    echo -e "${GREEN}INSIGHT:${NC} 통찰 생성 완료: $insight_file"
}

# 학습 상태 표시
show_learning_status() {
    echo "======================================"
    echo "Clauder Learning System Status"
    echo "======================================"
    
    # 에러 패턴 수
    local error_count=$(ls "$PATTERNS_DIR/errors/"*.md 2>/dev/null | wc -l)
    echo "에러 패턴: $error_count개"
    
    # 성공 패턴 수
    local success_count=$(ls "$PATTERNS_DIR/success/"*.md 2>/dev/null | wc -l)
    echo "성공 패턴: $success_count개"
    
    # 프로젝트 메모리
    local memory_count=$(ls "$MEMORY_DIR/conventions/"*.txt 2>/dev/null | wc -l)
    echo "프로젝트 특성: $memory_count개"
    
    # 최근 학습
    local latest_learn=$(ls -t "$PATTERNS_DIR"/*/*.md 2>/dev/null | head -1)
    if [ -f "$latest_learn" ]; then
        echo ""
        echo "최근 학습: $(basename $latest_learn)"
        head -3 "$latest_learn" | tail -1
    fi
    
    echo "======================================"
}

# Export functions
export -f learn_from_error
export -f learn_from_success
export -f remember_project_trait
export -f find_similar_pattern
export -f learn_commit_style
export -f learn_file_structure
export -f track_frequent_command
export -f generate_insights
export -f show_learning_status

# 초기화
if [ ! -d "$PATTERNS_DIR" ]; then
    init_learning_dirs
fi

# 프로젝트 특성 자동 학습 (최초 실행 시)
if [ ! -f "$MEMORY_DIR/conventions/initial-scan.done" ]; then
    echo -e "${BLUE}LEARNING:${NC} 프로젝트 초기 분석 중..."
    learn_commit_style
    learn_file_structure
    touch "$MEMORY_DIR/conventions/initial-scan.done"
fi