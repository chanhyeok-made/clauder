---
doc_id: 1000
priority: HIGH
load_when: ALWAYS
---

# Clauder Project Guide

PURPOSE: Essential guide for Clauder development with Claude Code

## IMMEDIATE: Execute on Task Request

### REQUIRED: Generate Workflow TODOs
```
IMMEDIATE TodoWrite with these 11 items:
1.1 Analysis: Is the requirement clear?
1.2 Analysis: Determine task size and approach
2.1 Implementation: Understand codebase and start
2.2 Implementation: Implement and test
2.3 Implementation: Verify requirements met
3.1 Retrospective: Any findings or issues?
3.2 Retrospective: Document if valuable
4.1 Documentation: Assess documentation needs
4.2 Documentation: Write docs and update version tree if needed
5.1 Commit: Review changes
5.2 Commit: Write message and push
```

### REQUIRED: Status Display
```
CURRENT_STAGE: [analysis/implementation/retrospective/documentation/commit]
```

## REFERENCE_IF_NEEDED:
- Workflow details: @.claude/workflow/README.md
- Principles: @.base-principles/README.md | @.clauder-dev/principles/README.md
- Project info: @.claude/project/clauder-overview.md
- Dev guides: @.clauder-dev/guides/

## FORBIDDEN:
- Starting work without workflow
- Implementing without analysis
- Committing without retrospective