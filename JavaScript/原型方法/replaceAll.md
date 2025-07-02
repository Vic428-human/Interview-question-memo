以下是一個跟**賠率（odds）**有關的範例，
依照你「移除特殊標記再加上加工結果」
的邏輯來寫：

---

🧠 情境說明：

你有一個原始賠率名稱 last_odds_label，像是：
let last_odds_label ="Over 2.5 Goals (<temp>)";
你想做的事情是：

1. 移除這個賠率名稱裡的 (<temp>)。
2. 再對原始文字進行進一步處理，例如：提取「Over」
3. 或加入一些代碼（用 formatOddsLabel 處理）。
4. 最後組成新的 odds_display_name。

---

✅ 代碼範例：
```
const odds_display_name = `${replaceAll(last_odds_label + '', '(<temp>)', '')}${formatOddsLabel(last_odds_label)}`;
```
---

假設函式實作如下：

function replaceAll(str, search, replacement) {
  return str.split(search).join(replacement);
}

function formatOddsLabel(label) {
  if (label.includes('Over')) {
    return ' 🔼';
  } else if (label.includes('Under')) {
    return ' 🔽';
  }
  return '';
}


---

🔍 輸出示範：

假設：

let last_odds_label = "Over 2.5 Goals (<temp>)";

結果：

odds_display_name // "Over 2.5 Goals 🔼"


---

這段程式碼會：

1. 先移除賠率名稱中的標記 (<temp>)；
2. 根據賠率內容加入提示符號（像是 Over 加上 🔼，Under 加上 🔽）；
3. 組合成一個更乾淨且有提示的賠率顯示名稱。
