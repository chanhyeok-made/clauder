#!/usr/bin/env python3
"""참조 자동 수정 스크립트"""

import os
import re

# 참조 매핑 테이블
ref_mappings = [
    # 존재하지 않는 파일 제거
    (r'@\.claude/project/clauder-overview\.md', ''),
    (r'@\.clauder-dev/guides/', '@.learning/development/'),
    (r'@\.clauder-dev/learning/system\.sh', ''),
    
    # 아카이브된 참조 제거
    (r'@ARCHITECTURE\.md', ''),
    (r'@FEATURE_MAP\.md', ''),
    (r'@\.claude/docs/design/HOOKS\.md', ''),
    
    # learning 관련
    (r'@\.claude/learning/INDEX\.md', '@.learning/INDEX.md'),
    
    # workflow 관련
    (r'@\.claude/workflow/', '@.workflow/core/'),
    
    # tools 관련
    (r'@\.claude/tools/', '@.tools/'),
    
    # principles 관련
    (r'@\.claude/principles/', '@.principles/usage/'),
    
    # 빈 참조 라인 정리
    (r'\n- *\n', '\n'),
]

updated_files = 0

for root, dirs, files in os.walk('.'):
    if '.git' in root or '.backup' in root:
        continue
        
    for file in files:
        if file.endswith('.md'):
            filepath = os.path.join(root, file)
            
            try:
                with open(filepath, 'r') as f:
                    content = f.read()
                
                original = content
                for old_pattern, new_pattern in ref_mappings:
                    content = re.sub(old_pattern, new_pattern, content)
                
                # 빈 줄 정리
                content = re.sub(r'\n{3,}', '\n\n', content)
                
                if content != original:
                    with open(filepath, 'w') as f:
                        f.write(content)
                    updated_files += 1
                    print(f"✓ {filepath}")
                    
            except Exception as e:
                print(f"✗ 실패: {filepath} - {e}")

print(f"\n총 {updated_files}개 파일 업데이트 완료")