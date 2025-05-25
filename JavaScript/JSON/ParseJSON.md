前言：
parse 5GB Json file,
下面分別有 python跟javascript版本的用法

### python版本

```
with open(path, 'r') as file:
    for line in file:
        try:
            paper = json.loads(line)
            # Check if 'hep' is in the categories string
            if 'categories' in paper and re.search(r'\bhep\b', paper['categories']):
                hep_papers.append(paper)
        except json.JSONDecodeError:
            continue
```

主要講得是parse大筆的json耗時過長問題點
把上面的例子，改成simdjson套件的版本

```python
import simdjson
import re

hep_papers = []
parser = simdjson.Parser()

with open(path, 'rb') as file:  # simdjson 建議以 binary 方式讀取
    for line in file:
        try:
            paper = parser.parse(line)
            # 檢查 'categories' 欄位是否存在且包含 'hep'
            if 'categories' in paper and re.search(r'\bhep\b', paper['categories']):
                hep_papers.append(paper)
        except simdjson.JSONException:
            continue
```

**主要差異與注意事項：**
- `simdjson` 解析時建議直接用 binary 模式（`'rb'`）讀檔。
- 解析單行 JSON 使用 `parser.parse(line)`，不用 `json.loads`。
- 例外處理需改 catch `simdjson.JSONException`，而不是 `json.JSONDecodeError`。
- 其餘邏輯與原本一致。

這樣就能利用 `simdjson` 的高效能來處理大量 JSON 行資料。


### JavaScript 版本
#### 基本用法
```
const simdjson = require('simdjson');

const jsonString = '{"categories":"hep-th math-ph","title":"Example"}';

// 驗證 JSON 格式
const valid = simdjson.isValid(jsonString);
console.log(valid); // true

// 懶解析（lazy parsing），取得 key 路徑的值
const JSONbuffer = simdjson.lazyParse(jsonString);
console.log(JSONbuffer.valueForKeyPath("categories")); // "hep-th math-ph"

```

#### 檢查 'categories' 欄位是否存在且包含 'hep'
重點說明：

使用 fs.createReadStream 與 readline 逐行讀取大型檔案，避免一次載入全部內容。

每一行用 simdjson.parse(line) 解析，效能優於標準 JSON.parse。

檢查 key 是否存在用 'categories' in paper 或 paper.hasOwnProperty('categories')。

判斷字串是否有 "hep" 用 /\bhep\b/.test(...)，與 Python 的 re.search(r'\bhep\b', ...) 等效。

解析錯誤時直接略過該行。
```
const fs = require('fs');
const readline = require('readline');
const simdjson = require('simdjson');

const hepPapers = [];

const rl = readline.createInterface({
    input: fs.createReadStream(path), // 預設為 'utf8'，simdjson 也接受 string
    crlfDelay: Infinity
});

rl.on('line', (line) => {
    try {
        // 這裡用 simdjson.parse 直接解析每一行 JSON 字串
        const paper = simdjson.parse(line);

        // 檢查 'categories' 欄位是否存在且包含 'hep'
        if (
            'categories' in paper &&
            /\bhep\b/.test(paper['categories'])
        ) {
            hepPapers.push(paper);
        }
    } catch (e) {
        // 解析失敗就跳過該行
    }
});

rl.on('close', () => {
    // 處理完畢，可在這裡使用 hepPapers
    console.log(`共找到 ${hepPapers.length} 筆資料`);
});
```
