iframe 的 srcdoc 是一個 HTML 屬性，
用來直接在 iframe 中嵌入 HTML 內容，
而不是從外部網址載入內容（像 src="https://example.com" 那樣）。

---

✅ 用法範例：
```
<iframe srcdoc="<p>Hello, <strong>world!</strong></p>"></iframe>
```
這會直接在 <iframe> 裡顯示這段 HTML：
> Hello, world!

---

🔍 srcdoc vs src

屬性	說明

src	指定外部網頁的 URL。
srcdoc	直接寫一段 HTML 作為內容（內嵌文檔）。


注意：如果 src 和 srcdoc 同時存在，
srcdoc 會優先顯示（大多數瀏覽器）。

---

🧠 實際用途：

在不需要從外部載入網頁的情況下，快速展示 HTML。
沙盒測試（搭配 sandbox 使用可增加安全性）。
---

🧨 注意事項：

1. srcdoc 的內容必須是HTML 字串，所以要注意引號與 HTML 編碼。


2. 若內容複雜建議使用模板字串（在 JavaScript 裡），避免轉義錯誤。


3. iframe 裡的 srcdoc 內容無法直接與父頁面互動，除非透過 postMessage 等方式。


---

```
import React from "react";

const IframeExample = () => {
  const htmlContent = `
    <!DOCTYPE html>
    <html>
      <head>
        <style>
          body { font-family: sans-serif; background-color: #f9f9f9; padding: 1rem; }
          h2 { color: #4a90e2; }
        </style>
      </head>
      <body>
        <h2>Hello from iframe!</h2>
        <p>This HTML comes from the srcdoc attribute.</p>
        <button onclick="alert('Hi from inside iframe')">Click me</button>
      </body>
    </html>
  `;

  return (
    <div>
      <h1>React Page</h1>
      <iframe
        title="Embedded HTML"
        srcDoc={htmlContent}
        style={{ width: "100%", height: "300px", border: "1px solid #ccc" }}
      />
    </div>
  );
};

export default IframeExample;
```
