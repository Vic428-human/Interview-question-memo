parse 5GB Json file,

範例是python的,沒實際用過
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

