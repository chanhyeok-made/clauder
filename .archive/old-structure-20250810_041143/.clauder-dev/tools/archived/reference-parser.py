#!/usr/bin/env python3
"""
Clauder 참조 파서
문서 내 참조를 파싱하고 관리합니다.
"""

import re
import yaml
import os
import sys
from pathlib import Path
from typing import Dict, List, Tuple, Optional

class ReferenceParser:
    def __init__(self, project_root: str = "."):
        self.root = Path(project_root)
        self.aliases = self._load_aliases()
        self.registry = self._load_registry()
        
    def _load_aliases(self) -> Dict:
        """별칭 파일 로드"""
        alias_file = self.root / ".claude" / "aliases.yaml"
        if alias_file.exists():
            with open(alias_file, 'r', encoding='utf-8') as f:
                data = yaml.safe_load(f)
                return data.get('aliases', {})
        return {}
        
    def _load_registry(self) -> Dict:
        """참조 레지스트리 로드"""
        registry_file = self.root / ".claude" / "references.yaml"
        if registry_file.exists():
            with open(registry_file, 'r', encoding='utf-8') as f:
                data = yaml.safe_load(f)
                return data.get('registry', {})
        return {}
        
    def parse_file(self, filepath: str) -> List[Dict]:
        """파일 내 참조 파싱"""
        references = []
        path = Path(filepath)
        
        if not path.exists():
            return references
            
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # 기존 @ 참조 찾기
        old_refs = re.findall(r'@([\w\./\-]+\.md)', content)
        for ref in old_refs:
            references.append({
                'type': 'old',
                'path': ref,
                'line': self._find_line_number(content, f'@{ref}')
            })
            
        # 새 @[] 참조 찾기
        new_refs = re.findall(r'@\[([\w\$/\-\|]+)\](?:#(\w+))?', content)
        for ref, commit in new_refs:
            references.append({
                'type': 'new',
                'path': ref,
                'commit': commit or None,
                'line': self._find_line_number(content, f'@[{ref}]')
            })
            
        # file: 참조 찾기 (YAML)
        yaml_refs = re.findall(r'file:\s*"([^"]+)"', content)
        for ref in yaml_refs:
            references.append({
                'type': 'yaml',
                'path': ref,
                'line': self._find_line_number(content, f'file: "{ref}"')
            })
            
        return references
        
    def _find_line_number(self, content: str, search: str) -> int:
        """텍스트에서 라인 번호 찾기"""
        lines = content.split('\n')
        for i, line in enumerate(lines, 1):
            if search in line:
                return i
        return 0
        
    def resolve_alias(self, path: str) -> str:
        """별칭을 실제 경로로 해석"""
        # 별칭 치환
        for alias, real_path in self.aliases.items():
            if path.startswith(alias):
                path = path.replace(alias, real_path, 1)
                
        # 조건부 참조 처리 (|로 구분)
        if '|' in path:
            paths = path.split('|')
            for p in paths:
                resolved = self.resolve_alias(p.strip())
                if (self.root / resolved).exists():
                    return resolved
            return paths[0].strip()  # 없으면 첫 번째 반환
            
        return path
        
    def get_current_commit(self) -> str:
        """현재 Git 커밋 해시 가져오기"""
        try:
            import subprocess
            result = subprocess.run(
                ['git', 'log', '-1', '--format=%h'],
                capture_output=True,
                text=True,
                cwd=self.root
            )
            return result.stdout.strip()
        except:
            return "unknown"
            
    def update_references(self, filepath: str, dry_run: bool = False) -> Dict:
        """파일의 참조 업데이트"""
        path = Path(filepath)
        if not path.exists():
            return {'error': 'File not found'}
            
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        original = content
        current_commit = self.get_current_commit()
        changes = []
        
        # 기존 @ 참조를 새 형식으로 변환
        old_refs = re.findall(r'@([\w\./\-]+\.md)', content)
        for ref in old_refs:
            # 별칭 확인
            alias_key = None
            for alias, alias_path in self.aliases.items():
                if ref.startswith(alias_path):
                    alias_key = alias
                    break
                    
            if alias_key:
                new_ref = f"@[{alias_key}{ref[len(self.aliases[alias_key]):]}]#{current_commit}"
            else:
                new_ref = f"@[{ref}]#{current_commit}"
                
            content = content.replace(f'@{ref}', new_ref)
            changes.append(f"Updated: @{ref} -> {new_ref}")
            
        # 버전 없는 새 참조에 커밋 추가
        new_refs = re.findall(r'@\[([\w\$/\-\|]+)\](?!#)', content)
        for ref in new_refs:
            old_ref = f"@[{ref}]"
            new_ref = f"@[{ref}]#{current_commit}"
            content = content.replace(old_ref, new_ref)
            changes.append(f"Added version: {old_ref} -> {new_ref}")
            
        if not dry_run and content != original:
            with open(path, 'w', encoding='utf-8') as f:
                f.write(content)
                
        return {
            'file': str(filepath),
            'changes': changes,
            'modified': content != original
        }
        
    def check_references(self, filepath: str) -> Dict:
        """참조 일관성 확인"""
        references = self.parse_file(filepath)
        issues = []
        
        for ref in references:
            path = self.resolve_alias(ref['path'])
            full_path = self.root / path
            
            # 파일 존재 확인
            if not full_path.exists():
                issues.append({
                    'type': 'missing',
                    'reference': ref['path'],
                    'line': ref['line']
                })
                
            # 버전 확인
            if ref['type'] == 'new' and ref.get('commit'):
                # 실제 파일의 최신 커밋과 비교
                # (구현 생략 - Git 명령 필요)
                pass
                
        return {
            'file': str(filepath),
            'references': len(references),
            'issues': issues
        }
        
    def generate_graph(self) -> str:
        """참조 그래프 생성 (Mermaid 형식)"""
        graph = ["graph TD"]
        nodes = set()
        edges = []
        
        # 모든 .md 파일 스캔
        for md_file in self.root.rglob("*.md"):
            if '.git' in str(md_file):
                continue
                
            refs = self.parse_file(md_file)
            if refs:
                source = str(md_file.relative_to(self.root))
                nodes.add(source)
                
                for ref in refs:
                    target = self.resolve_alias(ref['path'])
                    nodes.add(target)
                    edges.append(f'    {source} --> {target}')
                    
        # 노드 정의
        for node in sorted(nodes):
            graph.append(f'    {node}["{node}"]')
            
        # 엣지 추가
        graph.extend(sorted(set(edges)))
        
        return '\n'.join(graph)


def main():
    """CLI 인터페이스"""
    if len(sys.argv) < 2:
        print("Usage: reference-parser.py <command> [args]")
        print("Commands:")
        print("  parse <file>      - Parse references in file")
        print("  update <file>     - Update references to new format")
        print("  check <file>      - Check reference consistency")
        print("  graph             - Generate reference graph")
        return
        
    parser = ReferenceParser()
    command = sys.argv[1]
    
    if command == "parse" and len(sys.argv) > 2:
        refs = parser.parse_file(sys.argv[2])
        for ref in refs:
            print(f"Line {ref['line']}: {ref['type']} -> {ref['path']}")
            
    elif command == "update" and len(sys.argv) > 2:
        result = parser.update_references(sys.argv[2])
        if result.get('changes'):
            for change in result['changes']:
                print(change)
        else:
            print("No changes needed")
            
    elif command == "check" and len(sys.argv) > 2:
        result = parser.check_references(sys.argv[2])
        print(f"File: {result['file']}")
        print(f"References: {result['references']}")
        if result['issues']:
            print("Issues found:")
            for issue in result['issues']:
                print(f"  - Line {issue['line']}: {issue['type']} - {issue['reference']}")
                
    elif command == "graph":
        print(parser.generate_graph())
        
    else:
        print("Invalid command or missing arguments")


if __name__ == "__main__":
    main()