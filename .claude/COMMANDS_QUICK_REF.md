---
v: 2025-08-02|2025-08-02|initial
---

# 🚀 Clauder 명령어 빠른 참조

## 필수 명령어
| 명령어 | 용도 | 주요 옵션 |
|--------|------|-----------|
| `/clauder start` | 프로젝트 완전 초기화 | - |
| `/clauder daily` | 일일 상태 체크 | `--auto-sync` |
| `/clauder track` | 버전 관리 | `add`, `update`, `check`, `sync` |

## 관리 명령어
| 명령어 | 용도 | 주요 옵션 |
|--------|------|-----------|
| `/clauder check` | 시스템 점검 | - |
| `/clauder generate` | CLAUDE.md 생성 | - |
| `/clauder hooks` | Git hooks 관리 | `install`, `remove`, `status` |
| `/clauder ref` | 참조 관리 | `check`, `update`, `migrate` |

## 설정 명령어
| 명령어 | 용도 | 주요 옵션 |
|--------|------|-----------|
| `/clauder add` | 요소 추가 | `context`, `override`, `alias` |
| `/clauder update` | 설정 변경 | `project`, `settings` |
| `/clauder optimize` | 토큰 최적화 | `analyze`, `compress` |

## 사용 예시
```bash
# 새 프로젝트 시작
/clauder start

# 매일 아침
/clauder daily --auto-sync

# 문제 발생 시
/clauder check
/clauder track check
```

## 🔗 상세 문서
각 명령어 상세 정보: `.claude/commands/optimized/`