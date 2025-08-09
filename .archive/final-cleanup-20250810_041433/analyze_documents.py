#!/usr/bin/env python3
"""
Clauder 문서 분석 및 마이그레이션 매핑 생성
"""

import os
import re
import json
import hashlib
from collections import defaultdict
from datetime import datetime
from pathlib import Path

class DocumentAnalyzer:
    def __init__(self, root_dir='.'):
        self.root_dir = root_dir
        self.documents = []
        self.duplicates = defaultdict(list)
        self.similar = defaultdict(list)
        self.categories = defaultdict(list)
        
    def analyze(self):
        """전체 분석 프로세스"""
        print("📊 문서 분석 시작...")
        self.scan_documents()
        self.detect_duplicates()
        self.categorize_documents()
        self.find_similar_content()
        self.generate_migration_map()
        
    def scan_documents(self):
        """모든 마크다운 문서 스캔"""
        exclude_dirs = {'.git', 'node_modules', '.archive', '.vscode'}
        
        for root, dirs, files in os.walk(self.root_dir):
            # 제외 디렉토리 건너뛰기
            dirs[:] = [d for d in dirs if d not in exclude_dirs]
            
            for file in files:
                if file.endswith('.md'):
                    filepath = os.path.join(root, file)
                    doc_info = self.analyze_document(filepath)
                    if doc_info:
                        self.documents.append(doc_info)
        
        print(f"✓ {len(self.documents)}개 문서 스캔 완료")
        
    def analyze_document(self, filepath):
        """개별 문서 분석"""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # 빈 파일 건너뛰기
            if not content.strip():
                return None
                
            # 메타데이터 추출
            metadata = self.extract_metadata(content)
            
            # 내용 해시 생성
            content_hash = hashlib.md5(content.encode()).hexdigest()
            
            # 참조 추출
            references = re.findall(r'@[./\w-]+\.md', content)
            
            # 카테고리 추측
            category = self.guess_category(filepath, content)
            
            return {
                'path': filepath,
                'relative_path': os.path.relpath(filepath, self.root_dir),
                'size': len(content),
                'lines': content.count('\n'),
                'hash': content_hash,
                'metadata': metadata,
                'references': references,
                'category': category,
                'title': self.extract_title(content),
                'has_code': '```' in content,
                'has_yaml': content.startswith('---'),
            }
            
        except Exception as e:
            print(f"⚠️ 분석 실패: {filepath} - {e}")
            return None
            
    def extract_metadata(self, content):
        """YAML front matter 추출"""
        metadata = {}
        if content.startswith('---'):
            try:
                yaml_match = re.search(r'^---\n(.*?)\n---', content, re.DOTALL)
                if yaml_match:
                    yaml_content = yaml_match.group(1)
                    for line in yaml_content.split('\n'):
                        if ':' in line:
                            key, value = line.split(':', 1)
                            metadata[key.strip()] = value.strip()
            except:
                pass
        return metadata
        
    def extract_title(self, content):
        """문서 제목 추출"""
        title_match = re.search(r'^# (.+)$', content, re.MULTILINE)
        if title_match:
            return title_match.group(1)
        return None
        
    def guess_category(self, filepath, content):
        """문서 카테고리 추측"""
        path_lower = filepath.lower()
        
        # 경로 기반 카테고리
        if 'principle' in path_lower:
            return 'principles'
        elif 'workflow' in path_lower:
            return 'workflow'
        elif 'learn' in path_lower or 'analysis' in path_lower:
            return 'learning'
        elif 'tool' in path_lower or 'hook' in path_lower or 'validator' in path_lower:
            return 'tools'
        elif 'template' in path_lower:
            return 'templates'
        elif 'doc' in path_lower or 'guide' in path_lower:
            return 'documentation'
        elif 'test' in path_lower or 'example' in path_lower:
            return 'examples'
        
        # 내용 기반 카테고리
        content_lower = content.lower()
        if 'principle' in content_lower or '원칙' in content_lower:
            return 'principles'
        elif 'workflow' in content_lower or '워크플로' in content_lower:
            return 'workflow'
        elif 'learn' in content_lower or '학습' in content_lower:
            return 'learning'
        
        return 'misc'
        
    def detect_duplicates(self):
        """중복 문서 감지"""
        hash_map = defaultdict(list)
        
        for doc in self.documents:
            hash_map[doc['hash']].append(doc['path'])
            
        for hash_val, paths in hash_map.items():
            if len(paths) > 1:
                self.duplicates[hash_val] = paths
                
        print(f"✓ {len(self.duplicates)}개 중복 그룹 발견")
        
    def categorize_documents(self):
        """카테고리별 분류"""
        for doc in self.documents:
            self.categories[doc['category']].append(doc['relative_path'])
            
        print("✓ 카테고리별 분류:")
        for category, docs in sorted(self.categories.items()):
            print(f"  - {category}: {len(docs)}개")
            
    def find_similar_content(self):
        """유사 내용 찾기 (제목 기반)"""
        title_map = defaultdict(list)
        
        for doc in self.documents:
            if doc['title']:
                # 제목 정규화
                normalized = re.sub(r'[^a-zA-Z0-9가-힣]', '', doc['title'].lower())
                title_map[normalized].append(doc['path'])
                
        for title, paths in title_map.items():
            if len(paths) > 1:
                self.similar[title] = paths
                
        print(f"✓ {len(self.similar)}개 유사 문서 그룹 발견")
        
    def generate_migration_map(self):
        """마이그레이션 맵 생성"""
        migration_map = {
            'timestamp': datetime.now().isoformat(),
            'total_documents': len(self.documents),
            'categories': {},
            'duplicates': [],
            'similar': [],
            'migrations': []
        }
        
        # 카테고리별 마이그레이션 경로
        category_mapping = {
            'principles': '.principles/',
            'workflow': '.workflow/',
            'learning': '.learning/',
            'tools': '.tools/',
            'templates': '.templates/',
            'documentation': '.docs/',
            'examples': '.examples/',
            'misc': '.archive/misc/'
        }
        
        # 카테고리별 집계
        for category, docs in self.categories.items():
            migration_map['categories'][category] = {
                'count': len(docs),
                'target': category_mapping.get(category, '.archive/'),
                'documents': docs
            }
            
        # 중복 문서 처리
        for hash_val, paths in self.duplicates.items():
            migration_map['duplicates'].append({
                'hash': hash_val,
                'paths': paths,
                'action': 'merge',
                'keep': paths[0],  # 첫 번째 것 유지
                'remove': paths[1:]
            })
            
        # 유사 문서 처리
        for title, paths in self.similar.items():
            migration_map['similar'].append({
                'title': title,
                'paths': paths,
                'action': 'review',  # 수동 검토 필요
            })
            
        # 개별 마이그레이션 계획
        for doc in self.documents:
            old_path = doc['relative_path']
            new_dir = category_mapping.get(doc['category'], '.archive/')
            
            # 디렉토리 구조 개선
            if 'clauder-dev' in old_path:
                new_dir += 'development/'
            elif '.claude/' in old_path:
                new_dir += 'usage/'
            elif '.base-principles/' in old_path:
                new_dir += 'base/'
                
            new_path = new_dir + os.path.basename(old_path)
            
            migration_map['migrations'].append({
                'old': old_path,
                'new': new_path,
                'category': doc['category'],
                'size': doc['size'],
                'has_references': len(doc['references']) > 0
            })
            
        # JSON 파일로 저장
        with open('migration_map.json', 'w', encoding='utf-8') as f:
            json.dump(migration_map, f, indent=2, ensure_ascii=False)
            
        print("\n📋 마이그레이션 맵 생성 완료: migration_map.json")
        
        # 요약 출력
        print("\n📊 마이그레이션 요약:")
        print(f"- 총 문서: {len(self.documents)}개")
        print(f"- 중복 제거 가능: {sum(len(p)-1 for p in self.duplicates.values())}개")
        print(f"- 병합 검토 필요: {len(self.similar)}개 그룹")
        print(f"- 카테고리: {len(self.categories)}개")
        
        # 추천 사항
        print("\n💡 추천 사항:")
        if self.duplicates:
            print("- 중복 문서를 자동으로 병합할 수 있습니다")
        if self.similar:
            print("- 유사 문서는 수동 검토 후 병합을 고려하세요")
        if 'misc' in self.categories and len(self.categories['misc']) > 10:
            print("- 'misc' 카테고리 문서들을 재분류하세요")
            
        return migration_map

if __name__ == '__main__':
    analyzer = DocumentAnalyzer()
    analyzer.analyze()
    
    print("\n✅ 분석 완료!")
    print("다음 단계: ./execute_migration.sh migration_map.json")