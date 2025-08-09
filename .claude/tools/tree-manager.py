#!/usr/bin/env python3
"""
Version Tree Manager
문서화 단계에서 version-tree.yaml을 안전하게 관리
"""

import yaml
import sys
import os
from datetime import datetime
import subprocess
from pathlib import Path

TREE_FILE = ".claude/version-tree.yaml"

class VersionTreeManager:
    def __init__(self, tree_file=TREE_FILE):
        self.tree_file = tree_file
        self.tree = self.load_tree()
    
    def load_tree(self):
        """YAML 파일 로드"""
        if not os.path.exists(self.tree_file):
            return {
                "metadata": {
                    "last_update": datetime.now().strftime("%Y-%m-%d"),
                    "total_documents": 0
                },
                "documents": {},
                "path_to_id": {}
            }
        
        with open(self.tree_file, 'r') as f:
            return yaml.safe_load(f)
    
    def save_tree(self):
        """YAML 파일 저장"""
        # 메타데이터 업데이트
        self.tree["metadata"]["last_update"] = datetime.now().strftime("%Y-%m-%d")
        self.tree["metadata"]["total_documents"] = len(self.tree["documents"])
        
        with open(self.tree_file, 'w') as f:
            yaml.dump(self.tree, f, default_flow_style=False, sort_keys=False)
    
    def get_current_commit(self):
        """현재 Git 커밋 해시 가져오기"""
        try:
            result = subprocess.run(
                ['git', 'log', '-1', '--format=%h'],
                capture_output=True, text=True
            )
            return result.stdout.strip()
        except:
            return "uncommitted"
    
    def get_next_id(self, category="other"):
        """다음 사용 가능한 ID 찾기"""
        ranges = {
            "principle": (1, 99),
            "command": (100, 199),
            "design": (200, 299),
            "guide": (300, 399),
            "template": (400, 499),
            "other": (500, 999),
            "root": (1000, 1999),
            "workflow": (2000, 2999),
            "learning": (3000, 3999),
            "tool": (4000, 4999),
            "state": (5000, 5999)
        }
        
        start, end = ranges.get(category, (6000, 9999))
        
        # 해당 범위에서 사용된 ID 찾기
        used_ids = set()
        for doc_id in self.tree["documents"].keys():
            if start <= int(doc_id) <= end:
                used_ids.add(int(doc_id))
        
        # 다음 사용 가능한 ID 찾기
        for i in range(start, end + 1):
            if i not in used_ids:
                return i
        
        raise ValueError(f"No available ID in range {start}-{end}")
    
    def add_document(self, path, category="other", depends_on=None, referenced_by=None):
        """새 문서 추가"""
        # 이미 존재하는지 확인
        if path in self.tree.get("path_to_id", {}):
            print(f"Document already exists: {path}")
            return self.tree["path_to_id"][path]
        
        doc_id = self.get_next_id(category)
        
        self.tree["documents"][doc_id] = {
            "path": path,
            "created": datetime.now().strftime("%Y-%m-%d"),
            "updated": datetime.now().strftime("%Y-%m-%d"),
            "commit": self.get_current_commit(),
            "depends_on": depends_on or [],
            "referenced_by": referenced_by or []
        }
        
        # path_to_id 매핑 업데이트
        if "path_to_id" not in self.tree:
            self.tree["path_to_id"] = {}
        self.tree["path_to_id"][path] = doc_id
        
        print(f"✓ Added document: {path} (ID: {doc_id})")
        return doc_id
    
    def update_document(self, path):
        """문서 업데이트 (날짜와 커밋 해시)"""
        doc_id = self.tree.get("path_to_id", {}).get(path)
        if not doc_id:
            print(f"Document not found: {path}")
            return False
        
        if doc_id in self.tree["documents"]:
            self.tree["documents"][doc_id]["updated"] = datetime.now().strftime("%Y-%m-%d")
            self.tree["documents"][doc_id]["commit"] = self.get_current_commit()
            print(f"✓ Updated document: {path}")
            return True
        
        return False
    
    def add_reference(self, from_path, to_path, ref_type="depends"):
        """참조 관계 추가"""
        from_id = self.tree.get("path_to_id", {}).get(from_path)
        to_id = self.tree.get("path_to_id", {}).get(to_path)
        
        if not from_id or not to_id:
            print(f"Document not found: {from_path if not from_id else to_path}")
            return False
        
        if ref_type == "depends":
            # from이 to에 의존
            if to_id not in self.tree["documents"][from_id]["depends_on"]:
                self.tree["documents"][from_id]["depends_on"].append(to_id)
            
            # to가 from에 의해 참조됨
            if from_id not in self.tree["documents"][to_id]["referenced_by"]:
                self.tree["documents"][to_id]["referenced_by"].append(from_id)
        
        print(f"✓ Added reference: {from_path} -> {to_path}")
        return True
    
    def auto_update(self):
        """Git 변경사항 기반 자동 업데이트"""
        try:
            # 변경된 파일 목록 가져오기
            result = subprocess.run(
                ['git', 'diff', '--name-only', 'HEAD^', 'HEAD'],
                capture_output=True, text=True
            )
            changed_files = result.stdout.strip().split('\n')
            
            for file in changed_files:
                if file and (file.endswith('.md') or file.endswith('.sh') or file.endswith('.yaml')):
                    full_path = f"/{file}" if not file.startswith('/') else file
                    
                    # 카테고리 추론
                    category = self.infer_category(full_path)
                    
                    if full_path in self.tree.get("path_to_id", {}):
                        self.update_document(full_path)
                    else:
                        self.add_document(full_path, category)
            
            print("✓ Auto-update complete")
            return True
        except Exception as e:
            print(f"Auto-update failed: {e}")
            return False
    
    def infer_category(self, path):
        """경로에서 카테고리 추론"""
        if "principle" in path:
            return "principle"
        elif "command" in path:
            return "command"
        elif "design" in path:
            return "design"
        elif "guide" in path:
            return "guide"
        elif "template" in path:
            return "template"
        elif "workflow" in path:
            return "workflow"
        elif "learning" in path:
            return "learning"
        elif "tool" in path:
            return "tool"
        elif "state" in path:
            return "state"
        elif path.startswith("/CLAUDE") or path.startswith("/README"):
            return "root"
        else:
            return "other"
    
    def validate(self):
        """트리 구조 검증"""
        errors = []
        
        # 중복 ID 확인
        ids = list(self.tree["documents"].keys())
        if len(ids) != len(set(ids)):
            errors.append("Duplicate IDs found")
        
        # 중복 경로 확인
        paths = [doc["path"] for doc in self.tree["documents"].values()]
        if len(paths) != len(set(paths)):
            errors.append("Duplicate paths found")
        
        # 참조 무결성 확인
        for doc_id, doc in self.tree["documents"].items():
            for dep_id in doc.get("depends_on", []):
                if dep_id not in self.tree["documents"]:
                    errors.append(f"Invalid dependency: {doc_id} -> {dep_id}")
            
            for ref_id in doc.get("referenced_by", []):
                if ref_id not in self.tree["documents"]:
                    errors.append(f"Invalid reference: {ref_id} -> {doc_id}")
        
        if errors:
            print("Validation errors:")
            for error in errors:
                print(f"  ❌ {error}")
            return False
        else:
            print("✓ Validation passed")
            return True

def main():
    if len(sys.argv) < 2:
        print("Usage: python tree-manager.py <command> [args...]")
        print("\nCommands:")
        print("  add <path> [category]      - Add new document")
        print("  update <path>              - Update document")
        print("  ref <from> <to>            - Add reference")
        print("  auto                       - Auto-update from git")
        print("  validate                   - Validate tree")
        sys.exit(1)
    
    manager = VersionTreeManager()
    command = sys.argv[1]
    
    if command == "add":
        path = sys.argv[2]
        category = sys.argv[3] if len(sys.argv) > 3 else "other"
        manager.add_document(path, category)
        manager.save_tree()
    
    elif command == "update":
        path = sys.argv[2]
        manager.update_document(path)
        manager.save_tree()
    
    elif command == "ref":
        from_path = sys.argv[2]
        to_path = sys.argv[3]
        manager.add_reference(from_path, to_path)
        manager.save_tree()
    
    elif command == "auto":
        manager.auto_update()
        manager.save_tree()
    
    elif command == "validate":
        manager.validate()
    
    else:
        print(f"Unknown command: {command}")
        sys.exit(1)

if __name__ == "__main__":
    main()