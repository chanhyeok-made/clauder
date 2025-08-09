#!/usr/bin/env python3
"""
488개 문서에서 핵심 인사이트 추출
"""

import os
import re
from collections import defaultdict
from datetime import datetime

class InsightExtractor:
    def __init__(self):
        self.insights = {
            'errors_solved': [],      # 해결한 에러들
            'patterns_found': [],      # 발견한 패턴들
            'principles': [],          # 핵심 원칙들
            'lessons_learned': [],     # 배운 교훈들
            'best_practices': [],      # 모범 사례들
            'anti_patterns': [],       # 피해야 할 패턴
            'tools_created': [],       # 만든 도구들
            'workflows': [],           # 워크플로우 개선
        }
        
        # 키워드 매핑
        self.keywords = {
            'errors_solved': ['해결', 'fixed', 'solution', 'error', 'bug', '오류'],
            'patterns_found': ['패턴', 'pattern', 'discovered', '발견'],
            'principles': ['원칙', 'principle', 'rule', 'must', '필수'],
            'lessons_learned': ['배운', 'learned', 'lesson', '교훈', '깨달음'],
            'best_practices': ['best', 'practice', '모범', '추천', 'recommend'],
            'anti_patterns': ['avoid', 'don\'t', '금지', '하지마', 'antipattern'],
            'tools_created': ['tool', 'script', '도구', '스크립트', 'automation'],
            'workflows': ['workflow', 'process', '프로세스', '단계', 'step']
        }
        
    def extract_from_file(self, filepath):
        """파일에서 인사이트 추출"""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # 빈 파일 건너뛰기
            if not content.strip() or len(content) < 100:
                return
                
            # 각 카테고리별로 인사이트 추출
            for category, keywords in self.keywords.items():
                for keyword in keywords:
                    if keyword.lower() in content.lower():
                        # 키워드 주변 문맥 추출
                        insights = self.extract_context(content, keyword, filepath)
                        if insights:
                            self.insights[category].extend(insights)
                        break  # 카테고리당 한 번만
                        
        except Exception as e:
            pass
            
    def extract_context(self, content, keyword, filepath):
        """키워드 주변의 의미 있는 문맥 추출"""
        insights = []
        lines = content.split('\n')
        
        for i, line in enumerate(lines):
            if keyword.lower() in line.lower():
                # 제목이나 중요한 문장 추출
                if line.startswith('#') or line.startswith('-') or ':' in line:
                    insight = {
                        'text': line.strip(),
                        'file': os.path.relpath(filepath),
                        'context': self.get_surrounding_context(lines, i)
                    }
                    
                    # 중복 제거 (유사한 텍스트)
                    if not self.is_duplicate(insight['text'], insights):
                        insights.append(insight)
                        
        return insights[:3]  # 파일당 최대 3개
        
    def get_surrounding_context(self, lines, index):
        """주변 2줄의 컨텍스트 가져오기"""
        start = max(0, index - 1)
        end = min(len(lines), index + 2)
        return '\n'.join(lines[start:end])
        
    def is_duplicate(self, text, insights_list):
        """중복 체크"""
        text_lower = text.lower().strip()
        for insight in insights_list:
            if isinstance(insight, dict):
                if text_lower in insight.get('text', '').lower():
                    return True
            elif text_lower in str(insight).lower():
                return True
        return False
        
    def scan_all_files(self):
        """모든 마크다운 파일 스캔"""
        exclude_dirs = {'.git', '.backup', '.archive', 'node_modules'}
        
        file_count = 0
        for root, dirs, files in os.walk('.'):
            dirs[:] = [d for d in dirs if d not in exclude_dirs]
            
            for file in files:
                if file.endswith('.md'):
                    filepath = os.path.join(root, file)
                    self.extract_from_file(filepath)
                    file_count += 1
                    
        print(f"✓ {file_count}개 파일 스캔 완료")
        
    def deduplicate_insights(self):
        """인사이트 중복 제거 및 정리"""
        for category in self.insights:
            # 텍스트만 추출하여 중복 제거
            unique_texts = []
            seen = set()
            
            for item in self.insights[category]:
                if isinstance(item, dict):
                    text = item.get('text', '')
                else:
                    text = str(item)
                    
                # 정규화
                normalized = re.sub(r'[^a-zA-Z0-9가-힣]', '', text.lower())
                
                if normalized and normalized not in seen:
                    seen.add(normalized)
                    unique_texts.append({
                        'text': text,
                        'file': item.get('file', '') if isinstance(item, dict) else ''
                    })
                    
            self.insights[category] = unique_texts[:20]  # 카테고리당 최대 20개
            
    def generate_summary(self):
        """인사이트 요약 생성"""
        summary = []
        summary.append("# 🔍 추출된 핵심 인사이트\n")
        summary.append(f"생성 시각: {datetime.now().isoformat()}\n")
        
        # 통계
        total = sum(len(items) for items in self.insights.values())
        summary.append(f"## 📊 통계")
        summary.append(f"- 총 인사이트: {total}개")
        summary.append(f"- 카테고리: {len(self.insights)}개\n")
        
        # 카테고리별 인사이트
        category_names = {
            'errors_solved': '🔧 해결한 문제들',
            'patterns_found': '🔍 발견한 패턴들',
            'principles': '📏 핵심 원칙들',
            'lessons_learned': '💡 배운 교훈들',
            'best_practices': '✅ 모범 사례들',
            'anti_patterns': '❌ 피해야 할 것들',
            'tools_created': '🛠️ 만든 도구들',
            'workflows': '🔄 워크플로우'
        }
        
        for category, items in self.insights.items():
            if items:
                summary.append(f"\n## {category_names.get(category, category)}")
                summary.append(f"*{len(items)}개 발견*\n")
                
                for i, item in enumerate(items[:10], 1):  # 상위 10개만
                    if isinstance(item, dict):
                        text = item.get('text', '').strip()
                        file = item.get('file', '')
                        if text:
                            # 마크다운 헤더 제거
                            text = re.sub(r'^#+\s*', '', text)
                            summary.append(f"{i}. {text}")
                            if file:
                                summary.append(f"   *(from: {file})*")
                    else:
                        summary.append(f"{i}. {item}")
                        
        return '\n'.join(summary)
        
    def save_insights(self):
        """인사이트를 파일로 저장"""
        # 1. 전체 요약
        with open('EXTRACTED_INSIGHTS.md', 'w', encoding='utf-8') as f:
            f.write(self.generate_summary())
            
        # 2. 10개 핵심 파일에 통합할 내용
        self.create_consolidated_files()
        
        print("✓ 인사이트 추출 완료: EXTRACTED_INSIGHTS.md")
        
    def create_consolidated_files(self):
        """핵심 파일에 통합할 내용 생성"""
        
        # LESSONS.md - 모든 교훈 통합
        lessons_content = "# 📚 축적된 지식\n\n"
        lessons_content += "## 해결한 문제들\n"
        for item in self.insights['errors_solved'][:10]:
            if isinstance(item, dict):
                lessons_content += f"- {item.get('text', '')}\n"
                
        lessons_content += "\n## 발견한 패턴들\n"
        for item in self.insights['patterns_found'][:10]:
            if isinstance(item, dict):
                lessons_content += f"- {item.get('text', '')}\n"
                
        with open('LESSONS.md', 'w', encoding='utf-8') as f:
            f.write(lessons_content)
            
        # PRINCIPLES_CONSOLIDATED.md - 모든 원칙 통합
        principles_content = "# 🎯 통합 원칙\n\n"
        for item in self.insights['principles'][:15]:
            if isinstance(item, dict):
                principles_content += f"- {item.get('text', '')}\n"
                
        with open('PRINCIPLES_CONSOLIDATED.md', 'w', encoding='utf-8') as f:
            f.write(principles_content)
            
        print("✓ 통합 파일 생성: LESSONS.md, PRINCIPLES_CONSOLIDATED.md")

if __name__ == '__main__':
    extractor = InsightExtractor()
    print("📊 인사이트 추출 시작...")
    extractor.scan_all_files()
    extractor.deduplicate_insights()
    extractor.save_insights()
    print("✅ 완료!")