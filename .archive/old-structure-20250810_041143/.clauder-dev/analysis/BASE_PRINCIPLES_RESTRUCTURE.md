---
doc_id: 741
---

# 🏗️ 기반 원칙 구조 개편 제안

## 현재 문제점
기반 원칙(CORE-BASE-PRINCIPLES.md)이 `.clauder-dev/principles/` 안에 있음
→ 이는 "Clauder 개발용"으로 보이는 문제

## 제안하는 새 구조

```
clauder/
├── .base-principles/              # 🎯 최상위 기반 원칙
│   ├── README.md                 # 기반 원칙 소개
│   ├── 01-structured-knowledge.md
│   ├── 02-progressive-learning.md
│   ├── 03-explicit-automation.md
│   ├── 04-modular-extensibility.md
│   └── 05-version-transparency.md
│
├── .clauder-dev/                 # Clauder 개발 (기반 원칙 적용)
│   └── principles/               # Clauder 특화 원칙
│       ├── 00-CONTINUOUS-LEARNING.md
│       ├── 01-REFERENCE-STRUCTURE.md
│       └── ...
│
└── .claude/                      # 사용자 템플릿 (기반 원칙 적용)
    └── templates/                # 범용 템플릿
```

## 계층 구조

```
         기반 원칙 (Base Principles)
         /.base-principles/
              ↙          ↘
   Clauder 개발 원칙    사용자 프로젝트 원칙
   /.clauder-dev/       /.claude/templates/
```

## 장점

1. **명확한 계층**: 기반 → 적용의 관계가 디렉토리 구조로 표현
2. **독립성**: 기반 원칙이 특정 용도에 종속되지 않음
3. **재사용성**: 다른 프로젝트에서도 기반 원칙만 참조 가능
4. **확장성**: 새로운 적용 영역 추가 용이

## 대안 구조들

### 대안 1: /principles/ (루트에 직접)
```
/principles/                      # 기반 원칙
├── base/                        # 공통 기반
├── clauder-dev/                 # 개발용
└── templates/                   # 템플릿용
```

### 대안 2: /core/ 
```
/core/                           # 핵심 가치
├── principles/                  # 기반 원칙
├── architecture/                # 핵심 구조
└── values/                      # 가치 정의
```

### 대안 3: 문서로만 분리
```
/.clauder-dev/principles/
├── BASE-PRINCIPLES.md           # 상위 개념
├── DEV-PRINCIPLES.md            # 개발 원칙
└── USER-PRINCIPLES.md           # 사용자 원칙
```

## 추천: .base-principles/

이유:
1. **`.`으로 시작**: 시스템 레벨임을 명시
2. **최상위 위치**: 모든 것의 기반임을 표현
3. **독립 디렉토리**: 특정 용도에 종속되지 않음
4. **명확한 이름**: 역할이 즉시 이해됨

## 마이그레이션 계획

1. `.base-principles/` 디렉토리 생성
2. 기반 원칙들을 개별 파일로 분리
3. 기존 참조 업데이트
4. CLAUDE.md와 템플릿에서 참조
5. 문서에 계층 구조 명시

이렇게 하면 Clauder의 핵심 가치가 구조적으로도 명확하게 표현됩니다.