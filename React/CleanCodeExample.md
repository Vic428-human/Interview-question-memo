

多層if else 範例

錯誤

```
function processUser(user) {
  if (user != null) {
    if (user.hasSubscription) {
      if (user.age >= 18) {
        showFullVersion();
      } else {
        showChildrenVersion();
      }
    }
    // else {
    //   throw new Error('User needs a subscription');
    // }
  } else {
    throw new Error('No user found');
  }
}
```

主要優化重點：

單一職責原則（SRP）：每個 function/元件只負責一件事。

簡化巢狀結構，提升可讀性。

明確錯誤處理，讓錯誤資訊更有意義。

增加可測試性與可重用性。

使用現代 JavaScript/React 語法（如解構賦值、Hooks）。

優化後的程式碼範例
假設你要將這段邏輯寫成 React 可重用的 Hook 與元件：

```
// hooks/useUserAccess.js
export function useUserAccess(user) {
  if (!user) {
    throw new Error('No user found');
  }
  if (!user.hasSubscription) {
    throw new Error('User needs a subscription');
  }
  return user.age >= 18 ? 'full' : 'children';
}
```

```
// components/UserAccessGate.jsx
import React from 'react';
import { useUserAccess } from '../hooks/useUserAccess';

export default function UserAccessGate({ user }) {
  let accessType;
  try {
    accessType = useUserAccess(user);
  } catch (error) {
    return <div>{error.message}</div>;
  }

  if (accessType === 'full') {
    return <FullVersion />;
  }
  return <ChildrenVersion />;
}

// 這裡 FullVersion 與 ChildrenVersion 是單一職責元件
function FullVersion() {
  return <div>Full Version Content</div>;
}

function ChildrenVersion() {
  return <div>Children Version Content</div>;
}
```
