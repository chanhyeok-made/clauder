#!/usr/bin/env python3
"""참조 검증 스크립트"""

import os
import re

broken_refs = []
total_refs = 0

for root, dirs, files in os.walk('.'):
    if '.git' in root or '.backup' in root:
        continue
    
    for file in files:
        if file.endswith('.md'):
            filepath = os.path.join(root, file)
            try:
                with open(filepath, 'r') as f:
                    content = f.read()
                    
                # Find all references
                refs = re.findall(r'@([./\w-]+\.md)', content)
                for ref in refs:
                    total_refs += 1
                    # Check if target exists
                    if ref.startswith('./'):
                        target = os.path.join(os.path.dirname(filepath), ref[2:])
                    elif ref.startswith('/'):
                        target = '.' + ref
                    else:
                        target = ref
                    
                    if not os.path.exists(target):
                        broken_refs.append(f"{filepath} → @{ref}")
            except:
                pass

print(f"총 참조: {total_refs}개")
print(f"깨진 참조: {len(broken_refs)}개")

if broken_refs:
    print("\n깨진 참조 목록 (상위 20개):")
    for ref in broken_refs[:20]:
        print(f"  - {ref}")