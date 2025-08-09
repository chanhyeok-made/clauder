---
doc_id: 10
---

# 디렉토리 구조 및 참조 규칙

## 핵심 규칙

### 1. 모든 디렉토리는 README.md를 가져야 함
- 디렉토리의 목적과 내용을 설명
- 하위 파일/디렉토리 목록과 설명 포함
- 디렉토리가 비어있다면 최소한 목적이라도 명시

### 2. 참조 규칙

#### 절대 참조 (다른 디렉토리)
```
@.workflow/core/README.md
@.principles/base/README.md
```

#### 상대 참조 (같은 디렉토리 내)
README.md에서 같은 디렉토리의 파일 참조 시:
```
@checklist-template.md  (같은 디렉토리)
@subdirectory/  (하위 디렉토리)
```

#### 디렉토리 참조 시 자동 README.md 가정
```
@.workflow/core/  → .claude/workflow/README.md
@.claude/instructions/  → .claude/instructions/README.md
```

### 3. README.md 필수 내용

```markdown
---
doc_id: [번호]
---

# [디렉토리명] 

> 디렉토리 목적 한 줄 설명

## 📁 구조

- **파일1.md**: 설명
- **파일2.md**: 설명
- **subdirectory/**: 하위 디렉토리 설명

## 🔍 주요 내용

[디렉토리의 핵심 내용 설명]
```

## 실천 방법

1. **디렉토리 생성 시**
   - 즉시 README.md 생성
   - doc_id 할당
   - 버전 트리 업데이트

2. **참조 작성 시**
   - 같은 디렉토리: `@filename.md`
   - 다른 디렉토리: `@.path/to/file.md`
   - 디렉토리: `@.path/to/directory/`

3. **일관성 유지**
   - 모든 디렉토리가 동일한 구조
   - 참조 규칙 엄격히 준수

## 관련 문서
- 참조 구조: @.principles/development/01-REFERENCE-STRUCTURE.md
- 문서 모듈화: @.principles/development/03-DOCUMENT-MODULARITY.md