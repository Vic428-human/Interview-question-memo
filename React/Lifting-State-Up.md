Lifting State Up（提升狀態）

父元件希望知道子元件輸入的值就會把 state 管理用 callback 傳下來，這是「狀態提升」的概念。
TextInputWithLabel 的 state 跟父元件 ParentComponent 是分開管理，但用 onChange 保持同步。

- 精確掌控輸入狀態	及時取得輸入數值，方便驗證與格式化
- 單向資料流與可預測渲染	明確的資料流向，減少意外狀態不同步
- 狀態提升便於共享	多元件同步狀態及聯動改變
- 簡化複雜交互邏輯	容易實現動態表單、即時反饋
- 遵從 React 設計慣例	適合大型應用，便於維護
- 容易重置及設定初始值	表單狀態集中管理，更直觀

```
import React, { useState, useEffect } from "react";

function TextInputWithLabel({
  label,
  defaultValue = "",
  onChange,
}: {
  label: string;
  defaultValue?: string;
  onChange: (value: string) => void;
}) {
  const [text, setText] = useState(defaultValue);

  // 當 text 更新時，告知父元件
  useEffect(() => {
    if (typeof onChange === "function") onChange(text);
  }, [text]);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setText(e.target.value);
  };

  return (
    <div>
      <label>
        {label}:
        <input type="text" value={text} onChange={handleInputChange} />
      </label>
    </div>
  );
}

// 父元件示例
function ParentComponent() {
  const [inputValue, setInputValue] = useState("");

  return (
    <div>
      <h2>受控元件文字輸入範例</h2>
      <TextInputWithLabel
        label="姓名"
        defaultValue="張三"
        onChange={(val) => setInputValue(val)}
      />
      <p>父元件接收到的值: {inputValue}</p>
    </div>
  );
}
```
