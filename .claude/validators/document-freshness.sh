#!/bin/bash
# Document Freshness Validator
# 문서 최신성을 검증하고 오래된 문서 경고

VALIDATOR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$(dirname "$VALIDATOR_DIR")"
PROJECT_ROOT="$(dirname "$CLAUDE_DIR")"

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# 설정
STALE_DAYS=30  # 30일 이상 미갱신 시 경고
CRITICAL_DAYS=60  # 60일 이상 미갱신 시 심각

# 통계
total_docs=0
fresh_docs=0
stale_docs=0
critical_docs=0
missing_date_docs=0

# 현재 날짜 (초 단위)
current_date=$(date +%s)

# 문서 최신성 검사
check_document_freshness() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    
    ((total_docs++))
    
    # last_updated 추출
    local last_updated=$(grep "^last_updated:" "$file" | head -1 | sed 's/last_updated: *//')
    
    if [ -z "$last_updated" ]; then
        echo -e "${RED}NO_DATE:${NC} $relative_path"
        ((missing_date_docs++))
        return 1
    fi
    
    # 날짜 변환 (초 단위)
    local update_date=$(date -d "$last_updated" +%s 2>/dev/null)
    
    if [ -z "$update_date" ]; then
        echo -e "${RED}INVALID_DATE:${NC} $relative_path ($last_updated)"
        ((missing_date_docs++))
        return 1
    fi
    
    # 경과 일수 계산
    local days_old=$(( (current_date - update_date) / 86400 ))
    
    if [ $days_old -ge $CRITICAL_DAYS ]; then
        echo -e "${RED}CRITICAL:${NC} $relative_path (${days_old}일 경과)"
        ((critical_docs++))
    elif [ $days_old -ge $STALE_DAYS ]; then
        echo -e "${YELLOW}STALE:${NC} $relative_path (${days_old}일 경과)"
        ((stale_docs++))
    else
        # 정상 (출력하지 않음, 요약에만 포함)
        ((fresh_docs++))
    fi
}

# 참조 무결성 검사
check_reference_integrity() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    local broken_refs=0
    
    # @ 로 시작하는 참조 찾기
    grep -o "@[./a-zA-Z0-9_-]*\.md" "$file" 2>/dev/null | while read ref; do
        # @ 제거하고 경로 추출
        local ref_path="${ref#@}"
        
        # 상대 경로 처리
        if [[ "$ref_path" == ./* ]]; then
            local dir=$(dirname "$file")
            ref_path="$dir/${ref_path#./}"
        elif [[ "$ref_path" == /* ]]; then
            ref_path="$PROJECT_ROOT${ref_path}"
        else
            ref_path="$PROJECT_ROOT/$ref_path"
        fi
        
        # 파일 존재 확인
        if [ ! -f "$ref_path" ]; then
            echo -e "${RED}BROKEN_REF:${NC} $relative_path → $ref"
            ((broken_refs++))
        fi
    done
    
    return $broken_refs
}

# 역참조 완전성 검사
check_back_references() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    
    # 이 파일이 참조하는 문서들
    grep "^references:" "$file" -A 10 | grep "^  - @" | while read ref_line; do
        local ref=$(echo "$ref_line" | sed 's/^  - //')
        local ref_file="${ref#@}"
        
        # 참조된 파일에서 역참조 확인
        if [ -f "$PROJECT_ROOT/$ref_file" ]; then
            if ! grep -q "$relative_path" "$PROJECT_ROOT/$ref_file"; then
                echo -e "${YELLOW}MISSING_BACKREF:${NC} $ref_file ← $relative_path"
            fi
        fi
    done
}

# 메타데이터 완전성 검사
check_metadata_completeness() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    local missing=()
    
    # 필수 메타데이터 확인
    if ! grep -q "^doc_id:" "$file"; then
        missing+=("doc_id")
    fi
    
    if ! grep -q "^last_updated:" "$file"; then
        missing+=("last_updated")
    fi
    
    if [ ${#missing[@]} -gt 0 ]; then
        echo -e "${YELLOW}MISSING_META:${NC} $relative_path: ${missing[*]}"
        return 1
    fi
    
    return 0
}

# 메인 검증 함수
validate_all_documents() {
    echo "======================================"
    echo "Document System Validation"
    echo "======================================"
    echo ""
    
    echo -e "${BLUE}Checking document freshness...${NC}"
    echo "-------------------------------------"
    
    # 모든 마크다운 파일 검사
    find "$PROJECT_ROOT" -name "*.md" -type f \
        -not -path "*/node_modules/*" \
        -not -path "*/.git/*" \
        -not -path "*/coverage/*" \
        -not -path "*/dist/*" | while read file; do
        check_document_freshness "$file"
    done
    
    echo ""
    echo -e "${BLUE}Checking reference integrity...${NC}"
    echo "-------------------------------------"
    
    # 참조 무결성 검사
    find "$PROJECT_ROOT" -name "*.md" -type f \
        -not -path "*/node_modules/*" \
        -not -path "*/.git/*" | while read file; do
        check_reference_integrity "$file"
    done
    
    echo ""
    echo "======================================"
    echo "Summary"
    echo "======================================"
    echo -e "Total documents: $total_docs"
    echo -e "${GREEN}Fresh:${NC} $fresh_docs (< ${STALE_DAYS}일)"
    echo -e "${YELLOW}Stale:${NC} $stale_docs (${STALE_DAYS}-${CRITICAL_DAYS}일)"
    echo -e "${RED}Critical:${NC} $critical_docs (> ${CRITICAL_DAYS}일)"
    echo -e "${RED}No date:${NC} $missing_date_docs"
    
    # 건전성 점수 계산
    local health_score=$(( (fresh_docs * 100) / total_docs ))
    echo ""
    echo -e "Document Health Score: ${health_score}%"
    
    if [ $health_score -ge 90 ]; then
        echo -e "${GREEN}✓ Excellent${NC}"
    elif [ $health_score -ge 70 ]; then
        echo -e "${YELLOW}⚠ Needs attention${NC}"
    else
        echo -e "${RED}✗ Critical state${NC}"
    fi
    
    echo "======================================"
    
    # 실패 조건
    if [ $critical_docs -gt 0 ] || [ $missing_date_docs -gt 0 ]; then
        return 1
    fi
    
    return 0
}

# 오래된 문서 자동 갱신 제안
suggest_updates() {
    echo ""
    echo "======================================"
    echo "Update Suggestions"
    echo "======================================"
    
    # 60일 이상 된 문서들
    find "$PROJECT_ROOT" -name "*.md" -type f | while read file; do
        local last_updated=$(grep "^last_updated:" "$file" | head -1 | sed 's/last_updated: *//')
        if [ ! -z "$last_updated" ]; then
            local update_date=$(date -d "$last_updated" +%s 2>/dev/null)
            if [ ! -z "$update_date" ]; then
                local days_old=$(( (current_date - update_date) / 86400 ))
                if [ $days_old -ge $CRITICAL_DAYS ]; then
                    local relative_path="${file#$PROJECT_ROOT/}"
                    echo "git add $relative_path  # Review and update"
                fi
            fi
        fi
    done
}

# 실행
if [ "$1" = "--suggest" ]; then
    validate_all_documents
    suggest_updates
elif [ "$1" = "--fix" ]; then
    # 자동 수정 모드 (last_updated만 갱신)
    find "$PROJECT_ROOT" -name "*.md" -type f | while read file; do
        if grep -q "^last_updated:" "$file"; then
            sed -i.bak "s/^last_updated:.*/last_updated: $(date +%Y-%m-%d)/" "$file"
            echo "Updated: $file"
        fi
    done
else
    validate_all_documents
fi

exit $?