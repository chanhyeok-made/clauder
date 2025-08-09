#!/usr/bin/env python3
"""
Clauder Context Compressor
토큰 사용을 최적화하기 위한 컨텍스트 압축 도구
"""

import re
import yaml
from pathlib import Path

class ContextCompressor:
    def __init__(self, config_path=".claude/config.yaml"):
        with open(config_path, 'r') as f:
            self.config = yaml.safe_load(f)
    
    def compress_metadata(self, content):
        """YAML 메타데이터를 압축 형식으로 변환"""
        # 기존 형식 찾기
        pattern = r'---\s*\nversion:\s*\n\s*created:\s*"([^"]+)"\s*\n\s*updated:\s*"([^"]+)"\s*\n\s*commit:\s*"([^"]+)"\s*\n.*?---'
        
        def replacer(match):
            created, updated, commit = match.groups()
            return f'---\nv: {created}|{updated}|{commit}\n---'
        
        return re.sub(pattern, replacer, content, flags=re.DOTALL)
    
    def compress_references(self, content):
        """긴 참조를 별칭으로 변환"""
        # 별칭 로드
        aliases = {}
        for alias_file in self.config.get('aliases', []):
            if Path(alias_file).exists():
                with open(alias_file, 'r') as f:
                    alias_content = yaml.safe_load(f)
                    if alias_content:
                        aliases.update(alias_content)
        
        # 긴 경로를 별칭으로 교체
        for alias, path in aliases.items():
            content = content.replace(f'@[{path}]', f'@[{alias}]')
            content = content.replace(f'@{path}', f'@[{alias}]')
        
        return content
    
    def compress_content(self, content):
        """내용 압축"""
        if not self.config.get('compression', {}).get('content_compression'):
            return content
        
        settings = self.config['compression']['content_compression']
        
        # 주석 제거
        if settings.get('remove_comments'):
            content = re.sub(r'<!--.*?-->', '', content, flags=re.DOTALL)
        
        # 빈 줄 제거
        if settings.get('remove_empty_lines'):
            content = re.sub(r'\n\s*\n', '\n', content)
        
        # 목록 압축
        if settings.get('compact_lists'):
            content = re.sub(r'\n\s*-\s+', '\n- ', content)
            content = re.sub(r'\n\s*\*\s+', '\n* ', content)
            content = re.sub(r'\n\s*\d+\.\s+', lambda m: m.group(0).strip() + ' ', content)
        
        return content.strip()
    
    def truncate_code_blocks(self, content):
        """긴 코드 블록 축약"""
        settings = self.config.get('compression', {}).get('code_blocks', {})
        max_lines = settings.get('max_lines', 20)
        
        def truncate_block(match):
            lines = match.group(2).strip().split('\n')
            if len(lines) <= max_lines:
                return match.group(0)
            
            truncated = '\n'.join(lines[:max_lines//2])
            truncated += '\n... (생략) ...\n'
            truncated += '\n'.join(lines[-(max_lines//2):])
            
            return f'{match.group(1)}\n{truncated}\n```'
        
        pattern = r'(```[^\n]*)\n(.*?)\n```'
        return re.sub(pattern, truncate_block, content, flags=re.DOTALL)
    
    def compress_file(self, filepath):
        """파일 압축"""
        with open(filepath, 'r') as f:
            content = f.read()
        
        # 순차적으로 압축 적용
        content = self.compress_metadata(content)
        content = self.compress_references(content)
        content = self.compress_content(content)
        content = self.truncate_code_blocks(content)
        
        return content
    
    def estimate_tokens(self, text):
        """대략적인 토큰 수 추정"""
        # 간단한 추정: 4자 = 1토큰
        return len(text) // 4

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python context-compressor.py <file>")
        sys.exit(1)
    
    compressor = ContextCompressor()
    
    filepath = sys.argv[1]
    original = Path(filepath).read_text()
    compressed = compressor.compress_file(filepath)
    
    orig_tokens = compressor.estimate_tokens(original)
    comp_tokens = compressor.estimate_tokens(compressed)
    
    print(f"Original: {orig_tokens} tokens")
    print(f"Compressed: {comp_tokens} tokens")
    print(f"Saved: {orig_tokens - comp_tokens} tokens ({(1 - comp_tokens/orig_tokens)*100:.1f}%)")
    print("\n--- Compressed Content ---")
    print(compressed)