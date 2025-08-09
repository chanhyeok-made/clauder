#!/bin/bash
# Clauder 워크플로우 자동 시작 스크립트
# 이 스크립트는 작업 시작 시 자동으로 워크플로우를 설정합니다.

# 워크플로우 잠금 파일 경로
WORKFLOW_LOCK=".claude/state/.workflow.lock"
STATE_DIR=".claude/state"

# 상태 디렉토리 생성
mkdir -p "$STATE_DIR"

# 워크플로우가 이미 시작되었는지 확인
if [ ! -f "$WORKFLOW_LOCK" ]; then
    echo "🚀 워크플로우 자동 시작..."
    
    # 현재 시간 기록
    echo "$(date '+%Y-%m-%d %H:%M:%S')" > "$WORKFLOW_LOCK"
    
    # 초기 상태 설정
    cat > "$STATE_DIR/current.json" << EOF
{
    "session_id": "$(date '+%Y%m%d-%H%M%S')",
    "stage": "analysis",
    "completed_steps": [],
    "current_files": [],
    "start_time": "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
}
EOF
    
    echo "✅ 워크플로우 준비 완료"
    echo "🔍 현재 단계: 분석"
    echo ""
    echo "📋 TodoWrite로 11개 워크플로우 항목을 생성하세요:"
    echo "   1.1 분석: 무엇을 해야 하는지 명확한가?"
    echo "   1.2 분석: 작업 크기와 접근 방법 결정"
    echo "   ... (CLAUDE.md 참조)"
else
    # 기존 상태 읽기
    if [ -f "$STATE_DIR/current.json" ]; then
        STAGE=$(grep '"stage"' "$STATE_DIR/current.json" | cut -d'"' -f4)
        echo "🔍 현재 단계: $STAGE"
    fi
fi

# 작업 종료 시 실행할 정리 함수
cleanup() {
    if [ -f "$WORKFLOW_LOCK" ]; then
        echo ""
        echo "🏁 워크플로우 종료 중..."
        # 상태 백업
        cp "$STATE_DIR/current.json" "$STATE_DIR/last-session.json" 2>/dev/null
        # 잠금 해제
        rm "$WORKFLOW_LOCK"
        echo "✅ 다음 작업을 위한 준비 완료"
    fi
}

# 스크립트 종료 시 cleanup 실행
trap cleanup EXIT