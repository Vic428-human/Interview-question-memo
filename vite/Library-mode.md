這份代碼是一個用於 Vite 的配置檔案，目的是將一個 JavaScript 函式庫（library）
打包成可供其他專案重複使用的格式。以下是各部分的詳細解釋與使用情境：

#### 1. 主要用途
用於開發 JavaScript 函式庫（Library）：這份配置不是用來打包一般應用程式（如 SPA），
而是針對要發佈給其他人使用的函式庫，像是 UI 元件庫。
支援多種模組格式（如 UMD, ESM）：方便其他專案以不同方式引入這個函式庫。

#### 2. 主要配置說明
路徑處理
這些是 Node.js 的 API，用來處理檔案路徑，確保在不同作業系統下都能正確找到檔案。
__dirname 是取得目前檔案所在目錄的絕對路徑。

```
import { dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'
```

#### 3. import.meta.url
```
const __dirname = dirname(fileURLToPath(import.meta.url));
```

### 註
- SPA
> Single-Page Application（SPA）是一種網頁應用的架構，在 SPA 中，整個應用程式的所有內容都在一個頁面中呈現。 Gmail 就是一個很好的例子，
> 使用者可以在同一個頁面查看不同信件、回覆和編輯信件，而這全部操作都不需要刷新重整頁面。
> 當使用者在查看一封新郵件時，應用程式只需要動態載入和顯示所需要的新數據，而不是加載整個新頁面。


- import.meta.url 
是一個在 JavaScript ES 模組（ESM）中提供的特殊屬性。
它代表目前模組的完整 URL 路徑。在 Node.js 中，這通常是一個 file:// 開頭的本地檔案 URL。
在瀏覽器中，這會是模組的實際載入網址。

- 實際用途
import.meta.url 主要用來：
取得目前模組的檔案位置（不論是在本地還是網路上）。
動態載入資源，例如根據目前模組的位置動態載入其他檔案。
與 Node.js 路徑 API 結合，取得目錄路徑（如你的範例程式碼所示）。

```javascript
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);

new URL('file:///C:/path/').pathname;      // 不正確: /C:/path/
fileURLToPath('file:///C:/path/');         // 正確:   C:\path\ (Windows)

new URL('file://nas/foo.txt').pathname;    // 不正確: /foo.txt
fileURLToPath('file://nas/foo.txt');       // 正確:   \\nas\foo.txt (Windows)

new URL('file:///你好.txt').pathname;      // 不正確: /%E4%BD%A0%E5%A5%BD.txt
fileURLToPath('file:///你好.txt');         // 正確:   /你好.txt (POSIX)

new URL('file:///hello world').pathname;   // 不正確: /hello%20world
fileURLToPath('file:///hello world');      // 正確:   /hello world (POSIX)
```
