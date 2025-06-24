
配置檔案： ealint.config.js

這個配置強制開發者使用型別安全的 hooks：
- ❌ 不要使用：`useSelector`, `useDispatch` 
- ✅ 應該使用：`useAppSelector`, `useAppDispatch`

## 實際效果

當你寫出這樣的代碼時：
```typescript
import { useSelector, useDispatch } from 'react-redux';
```

ESLint 會顯示警告訊息：
> Use typed hooks `useAppDispatch` and `useAppSelector` instead.

```
"no-restricted-imports": "off",
"@typescript-eslint/no-restricted-imports": [
  "warn",
  {
    "name": "react-redux",
    "importNames": ["useSelector", "useDispatch"],
    "message": "Use typed hooks `useAppDispatch` and `useAppSelector` instead."
  }
],
```
