---
doc_id: 719
---

#!/usr/bin/env python3
"""
doc_id 마이그레이션 도구
- 모든 .md 파일에 doc_id 추가
- 구 버전 메타데이터 제거
- 버전 트리 업데이트
"""

import os
import re
import yaml
from pathlib import Path
from datetime import datetime

# 프로젝트 루트
PROJECT_ROOT = Path(__file__).parent.parent.parent.parent
VERSION_TREE_PATH = PROJECT_ROOT / ".claude" / "version-tree.yaml"

def load_version_tree():
    """버전 트리 로드"""
    with open(VERSION_TREE_PATH, 'r', encoding='utf-8') as f:
        content = f.read()
        # YAML 파싱을 위해 주석 제거
        lines = content.split('\n')
        yaml_lines = []
        for line in lines:
            if not line.strip().startswith('#'):
                yaml_lines.append(line)
        return yaml.safe_load('\n'.join(yaml_lines))

def get_doc_id_from_path(tree, file_path):
    """경로로 doc_id 찾기"""
    rel_path = "/" + str(file_path.relative_to(PROJECT_ROOT))
    path_to_id = tree.get('path_to_id', {})
    return path_to_id.get(rel_path)

def has_doc_id(content):
    """doc_id 존재 여부 확인"""
    return bool(re.search(r'^doc_id:\s*\d+', content, re.MULTILINE))

def has_old_metadata(content):
    """구 버전 메타데이터 존재 여부 확인"""
    return bool(re.search(r'^version:', content, re.MULTILINE))

def remove_old_metadata(content):
    """구 버전 메타데이터 제거"""
    # --- 사이의 YAML front matter 찾기
    pattern = r'^---\n(.*?)^---\n'
    match = re.search(pattern, content, re.MULTILINE | re.DOTALL)
    
    if match and 'version:' in match.group(1):
        # 전체 front matter 제거
        return re.sub(pattern, '', content, count=1, flags=re.MULTILINE | re.DOTALL)
    return content

def add_doc_id(content, doc_id):
    """doc_id 추가"""
    doc_id_block = f"---\ndoc_id: {doc_id}\n---\n\n"
    
    # 기존 front matter가 있으면 제거
    content = remove_old_metadata(content)
    
    # 맨 앞에 doc_id 추가
    return doc_id_block + content.lstrip()

def migrate_file(file_path, tree, dry_run=False):
    """파일 마이그레이션"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 이미 doc_id가 있으면 스킵
    if has_doc_id(content):
        return "already_migrated"
    
    # 버전 트리에서 doc_id 찾기
    doc_id = get_doc_id_from_path(tree, file_path)
    if not doc_id:
        return "not_in_tree"
    
    # 마이그레이션 수행
    new_content = add_doc_id(content, doc_id)
    
    if not dry_run:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
    
    return "migrated"

def main():
    """메인 함수"""
    print("🚀 doc_id 마이그레이션 시작")
    
    # 버전 트리 로드
    tree = load_version_tree()
    
    # 통계
    stats = {
        'total': 0,
        'already_migrated': 0,
        'migrated': 0,
        'not_in_tree': 0,
        'errors': 0
    }
    
    not_in_tree_files = []
    
    # 모든 .md 파일 처리
    for md_file in PROJECT_ROOT.rglob("*.md"):
        # 제외할 디렉토리
        if any(part in str(md_file) for part in ['.git', 'node_modules', '.resonation']):
            continue
            
        stats['total'] += 1
        
        try:
            result = migrate_file(md_file, tree, dry_run=False)
            stats[result] += 1
            
            if result == "not_in_tree":
                not_in_tree_files.append(md_file)
            elif result == "migrated":
                print(f"✅ 마이그레이션 완료: {md_file.relative_to(PROJECT_ROOT)}")
                
        except Exception as e:
            print(f"❌ 오류 발생: {md_file.relative_to(PROJECT_ROOT)} - {e}")
            stats['errors'] += 1
    
    # 결과 출력
    print("\n📊 마이그레이션 결과:")
    print(f"  총 파일 수: {stats['total']}")
    print(f"  이미 마이그레이션됨: {stats['already_migrated']}")
    print(f"  마이그레이션 완료: {stats['migrated']}")
    print(f"  버전 트리에 없음: {stats['not_in_tree']}")
    print(f"  오류 발생: {stats['errors']}")
    
    if not_in_tree_files:
        print("\n⚠️ 버전 트리에 추가 필요한 파일:")
        for f in not_in_tree_files[:10]:  # 처음 10개만 표시
            print(f"  - {f.relative_to(PROJECT_ROOT)}")
        if len(not_in_tree_files) > 10:
            print(f"  ... 외 {len(not_in_tree_files) - 10}개")

if __name__ == "__main__":
    main()