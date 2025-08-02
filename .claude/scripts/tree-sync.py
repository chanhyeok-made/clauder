#!/usr/bin/env python3
"""
버전 트리 동기화 스크립트
모든 .md 파일이 트리에 포함되도록 보장
"""

import os
import re
import yaml
from pathlib import Path
from typing import Dict, List, Tuple

class TreeSynchronizer:
    def __init__(self, root_path: str = ".", tree_path: str = ".claude/version-tree.yaml"):
        self.root_path = Path(root_path)
        self.tree_path = tree_path
        self.tree = self._load_tree()
        
    def _load_tree(self) -> Dict:
        """트리 로드"""
        if not os.path.exists(self.tree_path):
            print(f"❌ 트리 파일 없음: {self.tree_path}")
            return {}
        
        with open(self.tree_path, 'r') as f:
            return yaml.safe_load(f) or {}
            
    def _save_tree(self):
        """트리 저장"""
        with open(self.tree_path, 'w') as f:
            yaml.dump(self.tree, f, default_flow_style=False, sort_keys=False)
            
    def find_all_md_files(self) -> List[Path]:
        """모든 .md 파일 찾기"""
        md_files = []
        for file_path in self.root_path.rglob("*.md"):
            # 제외할 디렉토리
            if any(part in str(file_path) for part in ['.git', 'node_modules', '.resonation']):
                continue
            md_files.append(file_path)
        return md_files
        
    def extract_metadata(self, file_path: Path) -> Dict:
        """파일에서 메타데이터 추출"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # YAML front matter 추출
            match = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
            if match:
                metadata = yaml.safe_load(match.group(1))
                return metadata or {}
        except:
            pass
        return {}
        
    def sync_file_to_tree(self, file_path: Path) -> Tuple[str, bool]:
        """파일을 트리에 동기화"""
        # 상대 경로로 변환
        try:
            rel_path = "/" + str(file_path.relative_to(self.root_path))
        except:
            rel_path = "/" + str(file_path)
            
        # 이미 트리에 있는지 확인
        path_to_id = self.tree.get('path_to_id', {})
        if rel_path in path_to_id:
            return f"✅ 이미 존재: {rel_path}", False
            
        # 메타데이터 추출
        metadata = self.extract_metadata(file_path)
        
        # doc_id가 이미 있는지 확인
        doc_id = metadata.get('doc_id')
        if doc_id and doc_id in self.tree.get('documents', {}):
            # doc_id는 있지만 path_to_id에 없는 경우
            self.tree['path_to_id'][rel_path] = doc_id
            return f"🔗 경로 매핑 추가: {rel_path} → {doc_id}", True
            
        # 새 ID 할당 필요
        from version_tree_manager import VersionTreeManager
        manager = VersionTreeManager(self.tree_path)
        new_id = manager._assign_new_id(rel_path)
        
        # 트리에 추가
        version_info = metadata.get('version', {})
        self.tree.setdefault('documents', {})[new_id] = {
            'path': rel_path,
            'created': version_info.get('created', 'unknown'),
            'updated': version_info.get('updated', 'unknown'),
            'commit': version_info.get('commit', 'unknown'),
            'depends_on': [],
            'referenced_by': []
        }
        
        self.tree.setdefault('path_to_id', {})[rel_path] = new_id
        
        # 파일에 doc_id 추가 제안
        if not doc_id:
            return f"➕ 새로 추가: {rel_path} (ID: {new_id}) - 파일에 doc_id: {new_id} 추가 필요", True
        
        return f"➕ 새로 추가: {rel_path} (ID: {new_id})", True
        
    def migrate_references(self):
        """기존 참조 정보를 트리로 마이그레이션"""
        updates = 0
        
        for doc_id, doc_info in self.tree.get('documents', {}).items():
            file_path = self.root_path / doc_info['path'].lstrip('/')
            metadata = self.extract_metadata(file_path)
            
            # dependencies 마이그레이션
            dependencies = metadata.get('dependencies', [])
            for dep in dependencies:
                dep_path = "/" + dep.get('file', '').lstrip('/')
                dep_id = self.tree.get('path_to_id', {}).get(dep_path)
                if dep_id and dep_id not in doc_info['depends_on']:
                    doc_info['depends_on'].append(dep_id)
                    updates += 1
                    
            # references 마이그레이션
            references = metadata.get('references', [])
            for ref in references:
                ref_path = "/" + ref.get('file', '').lstrip('/')
                ref_id = self.tree.get('path_to_id', {}).get(ref_path)
                if ref_id and ref_id not in doc_info['referenced_by']:
                    doc_info['referenced_by'].append(ref_id)
                    updates += 1
                    
        return updates
        
    def validate_tree(self) -> List[str]:
        """트리 검증 - 순환 참조, 누락된 ID 등"""
        issues = []
        
        # 모든 참조가 유효한지 확인
        for doc_id, doc_info in self.tree.get('documents', {}).items():
            for dep_id in doc_info.get('depends_on', []):
                if dep_id not in self.tree['documents']:
                    issues.append(f"❌ 문서 {doc_id}: 존재하지 않는 의존성 {dep_id}")
                    
            for ref_id in doc_info.get('referenced_by', []):
                if ref_id not in self.tree['documents']:
                    issues.append(f"❌ 문서 {doc_id}: 존재하지 않는 역참조 {ref_id}")
                    
        return issues
        
    def run_full_sync(self):
        """전체 동기화 실행"""
        print("🔄 버전 트리 동기화 시작...\n")
        
        # 1. 모든 .md 파일 찾기
        md_files = self.find_all_md_files()
        print(f"📁 발견된 .md 파일: {len(md_files)}개\n")
        
        # 2. 각 파일을 트리에 동기화
        added_count = 0
        for file_path in md_files:
            message, added = self.sync_file_to_tree(file_path)
            print(message)
            if added:
                added_count += 1
                
        print(f"\n📊 동기화 결과: {added_count}개 추가/업데이트")
        
        # 3. 기존 참조 정보 마이그레이션
        print("\n🔄 참조 정보 마이그레이션...")
        ref_updates = self.migrate_references()
        print(f"✅ {ref_updates}개 참조 관계 마이그레이션")
        
        # 4. 트리 검증
        print("\n🔍 트리 검증...")
        issues = self.validate_tree()
        if issues:
            print("⚠️  발견된 문제:")
            for issue in issues:
                print(f"  {issue}")
        else:
            print("✅ 검증 통과")
            
        # 5. 트리 저장
        if added_count > 0 or ref_updates > 0:
            self._save_tree()
            print(f"\n💾 트리 저장 완료: {self.tree_path}")
            
        # 6. doc_id 추가 필요한 파일 목록
        print("\n📝 다음 파일들에 doc_id 추가 필요:")
        for file_path in md_files:
            metadata = self.extract_metadata(file_path)
            if 'doc_id' not in metadata:
                rel_path = "/" + str(file_path.relative_to(self.root_path))
                doc_id = self.tree['path_to_id'].get(rel_path)
                if doc_id:
                    print(f"  - {rel_path}: doc_id: {doc_id}")

if __name__ == "__main__":
    syncer = TreeSynchronizer()
    syncer.run_full_sync()