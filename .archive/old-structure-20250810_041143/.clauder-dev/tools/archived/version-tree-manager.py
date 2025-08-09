#!/usr/bin/env python3
"""
버전 트리 관리 스크립트
중앙 버전 트리를 사용하여 문서 버전과 참조를 효율적으로 관리
"""

import yaml
import os
import sys
import subprocess
from pathlib import Path
from typing import Dict, List, Set, Tuple

class VersionTreeManager:
    def __init__(self, tree_path: str = ".claude/version-tree.yaml"):
        self.tree_path = tree_path
        self.tree = self._load_tree()
        
    def _load_tree(self) -> Dict:
        """버전 트리 로드"""
        if not os.path.exists(self.tree_path):
            return self._create_empty_tree()
        
        with open(self.tree_path, 'r') as f:
            return yaml.safe_load(f)
            
    def _save_tree(self):
        """버전 트리 저장"""
        with open(self.tree_path, 'w') as f:
            yaml.dump(self.tree, f, default_flow_style=False, sort_keys=False)
            
    def _create_empty_tree(self) -> Dict:
        """빈 트리 생성"""
        return {
            'metadata': {
                'last_update': self._get_date(),
                'last_commit': self._get_commit_hash(),
                'total_documents': 0
            },
            'documents': {},
            'path_to_id': {}
        }
        
    def _get_commit_hash(self) -> str:
        """현재 커밋 해시 가져오기"""
        try:
            result = subprocess.run(['git', 'log', '-1', '--format=%h'], 
                                  capture_output=True, text=True)
            return result.stdout.strip()
        except:
            return "unknown"
            
    def _get_date(self) -> str:
        """현재 날짜 가져오기"""
        from datetime import datetime
        return datetime.now().strftime("%Y-%m-%d")
        
    def update_document(self, file_path: str, modified: bool = True):
        """문서 업데이트"""
        # 경로 정규화
        if not file_path.startswith('/'):
            file_path = '/' + file_path
            
        # ID 찾기 또는 생성
        doc_id = self.tree['path_to_id'].get(file_path)
        if doc_id is None:
            doc_id = self._assign_new_id(file_path)
            
        # 문서 정보 업데이트
        if doc_id not in self.tree['documents']:
            self.tree['documents'][doc_id] = {
                'path': file_path,
                'created': self._get_date(),
                'updated': self._get_date(),
                'commit': self._get_commit_hash(),
                'depends_on': [],
                'referenced_by': []
            }
        else:
            if modified:
                self.tree['documents'][doc_id]['updated'] = self._get_date()
                self.tree['documents'][doc_id]['commit'] = self._get_commit_hash()
                
        # 메타데이터 업데이트
        self.tree['metadata']['last_update'] = self._get_date()
        self.tree['metadata']['last_commit'] = self._get_commit_hash()
        self.tree['metadata']['total_documents'] = len(self.tree['documents'])
        
        return doc_id
        
    def _assign_new_id(self, file_path: str) -> int:
        """새 ID 할당"""
        # ID 할당 규칙에 따라 적절한 범위에서 할당
        if 'principles' in file_path:
            start, end = 1, 99
        elif 'commands' in file_path:
            start, end = 100, 199
        elif 'design' in file_path:
            start, end = 200, 299
        elif 'guides' in file_path:
            start, end = 300, 399
        elif 'templates' in file_path:
            start, end = 400, 499
        elif file_path.count('/') <= 2:  # 루트에 가까운 파일
            start, end = 1000, 1999
        else:
            start, end = 500, 599
            
        # 사용 가능한 ID 찾기
        used_ids = set(self.tree['documents'].keys())
        for i in range(start, end + 1):
            if i not in used_ids:
                self.tree['path_to_id'][file_path] = i
                return i
                
        # 범위가 꽉 찬 경우 다음 범위 사용
        return max(used_ids) + 1 if used_ids else start
        
    def add_dependency(self, from_path: str, to_path: str):
        """의존성 추가"""
        from_id = self.update_document(from_path, modified=False)
        to_id = self.update_document(to_path, modified=False)
        
        # 의존성 추가
        if to_id not in self.tree['documents'][from_id]['depends_on']:
            self.tree['documents'][from_id]['depends_on'].append(to_id)
            
        # 역참조 추가
        if from_id not in self.tree['documents'][to_id]['referenced_by']:
            self.tree['documents'][to_id]['referenced_by'].append(from_id)
            
    def check_circular_dependency(self) -> List[List[int]]:
        """순환 참조 검사"""
        def dfs(node: int, visited: Set[int], path: List[int]) -> List[List[int]]:
            if node in path:
                # 순환 발견
                cycle_start = path.index(node)
                return [path[cycle_start:] + [node]]
                
            if node in visited:
                return []
                
            visited.add(node)
            path.append(node)
            
            cycles = []
            doc = self.tree['documents'].get(node, {})
            for dep in doc.get('depends_on', []):
                cycles.extend(dfs(dep, visited.copy(), path.copy()))
                
            return cycles
            
        all_cycles = []
        for doc_id in self.tree['documents']:
            cycles = dfs(doc_id, set(), [])
            for cycle in cycles:
                if cycle not in all_cycles:
                    all_cycles.append(cycle)
                    
        return all_cycles
        
    def get_affected_documents(self, file_path: str) -> List[str]:
        """특정 문서 수정 시 영향받는 문서 목록"""
        doc_id = self.tree['path_to_id'].get(file_path)
        if doc_id is None:
            return []
            
        affected = []
        doc = self.tree['documents'].get(doc_id, {})
        
        # 이 문서를 참조하는 모든 문서
        for ref_id in doc.get('referenced_by', []):
            ref_doc = self.tree['documents'].get(ref_id, {})
            if ref_doc:
                affected.append(ref_doc['path'])
                
        return affected
        
    def print_status(self):
        """현재 상태 출력"""
        print(f"\n📊 버전 트리 상태")
        print(f"총 문서: {self.tree['metadata']['total_documents']}")
        print(f"마지막 업데이트: {self.tree['metadata']['last_update']}")
        print(f"커밋: {self.tree['metadata']['last_commit']}")
        
        # 순환 참조 검사
        cycles = self.check_circular_dependency()
        if cycles:
            print(f"\n❌ 순환 참조 발견: {len(cycles)}개")
            for cycle in cycles:
                paths = [self.tree['documents'][id]['path'] for id in cycle]
                print(f"  - {' → '.join(paths)}")
        else:
            print("\n✅ 순환 참조 없음")

# CLI 인터페이스
if __name__ == "__main__":
    manager = VersionTreeManager()
    
    if len(sys.argv) < 2:
        print("사용법: python version-tree-manager.py <command> [args]")
        print("Commands:")
        print("  update <file>     - 파일 업데이트")
        print("  depend <from> <to> - 의존성 추가")
        print("  affected <file>   - 영향받는 파일 목록")
        print("  status           - 상태 확인")
        sys.exit(1)
        
    command = sys.argv[1]
    
    if command == "update" and len(sys.argv) >= 3:
        file_path = sys.argv[2]
        doc_id = manager.update_document(file_path)
        manager._save_tree()
        print(f"✅ 업데이트됨: {file_path} (ID: {doc_id})")
        
    elif command == "depend" and len(sys.argv) >= 4:
        from_path = sys.argv[2]
        to_path = sys.argv[3]
        manager.add_dependency(from_path, to_path)
        manager._save_tree()
        print(f"✅ 의존성 추가: {from_path} → {to_path}")
        
    elif command == "affected" and len(sys.argv) >= 3:
        file_path = sys.argv[2]
        affected = manager.get_affected_documents(file_path)
        if affected:
            print(f"\n📝 {file_path} 수정 시 영향받는 문서:")
            for doc in affected:
                print(f"  - {doc}")
        else:
            print(f"영향받는 문서 없음")
            
    elif command == "status":
        manager.print_status()
        
    else:
        print(f"알 수 없는 명령: {command}")
        sys.exit(1)