---
doc_id: 709
---

이 문서는 개인 코딩 스타일 가이드의 예시입니다.
`.claude/custom/personal/contexts/`에 복사하여 사용하세요.

## 내가 선호하는 코딩 패턴

### 함수 작성
- 함수는 한 가지 일만 수행
- 최대 20줄 이내
- Early return 패턴 선호
- 부작용(side effect) 최소화

```javascript
// 선호하는 스타일
function processUser(user) {
  if (!user) return null;
  if (!user.isActive) return null;
  
  return {
    id: user.id,
    name: user.name,
    email: user.email
  };
}

// 피하는 스타일
function processUser(user) {
  if (user && user.isActive) {
    return {
      id: user.id,
      name: user.name,
      email: user.email
    };
  } else {
    return null;
  }
}
```

### 변수명 규칙
- 의미가 명확한 이름 사용
- 약어 최소화
- 불린: `is`, `has`, `should` 접두사
- 컬렉션: 복수형 또는 `List`, `Array` 접미사

```javascript
// 좋은 예
const isUserActive = true;
const hasPermission = false;
const userList = [];
const userMap = new Map();

// 피하는 예
const active = true;
const perm = false;
const users = [];  // 복수형보다는 List 선호
```

### 에러 처리
- 명시적인 에러 처리
- 에러 메시지는 구체적으로
- 로깅 레벨 구분

```javascript
try {
  await saveUser(userData);
} catch (error) {
  // 구체적인 에러 처리
  if (error.code === 'DUPLICATE_EMAIL') {
    logger.warn('Duplicate email attempt:', userData.email);
    throw new ValidationError('이미 사용 중인 이메일입니다.');
  }
  
  // 예상치 못한 에러
  logger.error('Failed to save user:', error);
  throw new InternalError('사용자 저장 중 오류가 발생했습니다.');
}
```

## 주석 작성 규칙

### 주석은 WHY를 설명
```javascript
// BAD: 무엇을 하는지 설명 (코드를 보면 앎)
// 사용자 ID를 가져온다
const userId = user.id;

// GOOD: 왜 이렇게 하는지 설명
// 레거시 시스템과의 호환성을 위해 문자열로 변환
const userId = String(user.id);
```

### TODO 주석 형식
```javascript
// TODO(김개발): 성능 최적화 필요 - 2024-01-15까지
// TODO(팀명): 에러 처리 로직 추가 필요
// FIXME: 임시 해결책, v2.0에서 수정 예정
```

## 테스트 작성 스타일

### 테스트 구조
- Arrange-Act-Assert 패턴
- 테스트당 하나의 개념만 검증
- 설명적인 테스트 이름

```javascript
describe('UserService', () => {
  describe('createUser', () => {
    it('should create user with valid data', async () => {
      // Arrange
      const userData = {
        name: '김개발',
        email: 'dev@example.com'
      };
      
      // Act
      const user = await userService.createUser(userData);
      
      // Assert
      expect(user).toHaveProperty('id');
      expect(user.name).toBe(userData.name);
      expect(user.email).toBe(userData.email);
    });
    
    it('should throw error when email is duplicate', async () => {
      // 중복 이메일 테스트...
    });
  });
});
```

## Git 커밋 스타일

### 커밋 메시지 형식
```
type(scope): subject

body (optional)

footer (optional)
```

### 자주 사용하는 타입
- `feat`: 새로운 기능
- `fix`: 버그 수정
- `refactor`: 리팩토링 (기능 변경 없음)
- `style`: 코드 포맷팅
- `test`: 테스트 추가/수정
- `docs`: 문서만 수정
- `chore`: 빌드, 설정 등

### 예시
```
feat(auth): 소셜 로그인 기능 추가

- Google OAuth2 연동
- 사용자 정보 자동 매핑
- 첫 로그인 시 추가 정보 입력 화면

Closes #123
```

## 코드 리뷰 시 중점사항

### 체크리스트
- [ ] 비즈니스 로직이 명확한가?
- [ ] 엣지 케이스가 처리되었는가?
- [ ] 테스트가 충분한가?
- [ ] 성능 문제는 없는가?
- [ ] 보안 이슈는 없는가?
- [ ] 문서화가 되었는가?

### 리뷰 코멘트 스타일
```
// 제안
"이 부분은 early return으로 개선하면 가독성이 좋아질 것 같습니다."

// 질문
"이 로직이 필요한 특별한 이유가 있나요?"

// 칭찬
"에러 처리가 꼼꼼하게 잘 되어있네요! 👍"
```

## 디버깅 접근 방법

### 체계적 접근
1. 문제 재현
2. 로그 확인
3. 가설 설정
4. 단계별 검증
5. 해결책 적용
6. 회귀 테스트

### 자주 사용하는 디버깅 도구
- Chrome DevTools
- VS Code Debugger
- `console.log` with labels
- Network tab for API issues

## 개인 개발 환경 최적화

### VS Code 설정
```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "editor.rulers": [100],
  "files.autoSave": "onFocusChange"
}
```

### 자주 사용하는 단축키
- `Cmd+P`: 파일 빠른 열기
- `Cmd+Shift+P`: 명령 팔레트
- `Cmd+D`: 다음 같은 단어 선택
- `Option+Up/Down`: 줄 이동

