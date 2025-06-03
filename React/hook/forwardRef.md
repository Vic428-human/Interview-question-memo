forwardRef 是什麼

在 React 裡，forwardRef 是一個高階函數（Higher-Order Function），
它允許你把 ref 往下傳遞到子組件。
通常 ref 只能直接綁定到 DOM 元素或 class component，
function component 不能直接接收 ref，所以才需要 forwardRef。


---

📘 範本 1
```
import React, { forwardRef } from 'react';

const MyComponent = forwardRef((props, ref) => {
  // 你可以把 ref 綁在你想要的元素上
  return <div ref={ref}>Hello</div>;
});
```

---

✨ 解構賦值

function 的第一個參數是這樣寫的：
```
const MyComponent = forwardRef(({
  props1,
  props2 = undefined,
}, fromParentRef) => {
  // 這裡可以用 props1,props2的值
  // ...
  return (
      <div ref={fromParentRef}>
        <p>initData: {JSON.stringify(props1)}</p>
        <p>updatePrice: {String(props2)}</p>
      </div>
    );
});
```
📌 說明：

都是 props 的一部分。
第二個參數 fromParentRef 
就是 forwardRef 幫你傳進來的 ref。

---

使用方式：
```
<MyComponent
  props1={fake1}
  props2={fake2}
/>
```

---
