

```
import React from 'react';
import { useQuery } from '@tanstack/react-query';

// 1. 定義 API 函數
async function fetchTodoById(id) {
  console.log(🔍 Fetching todo with id=${id} from API...);
  const response = await fetch(https://jsonplaceholder.typicode.com/todos/${id});
  if (!response.ok) {
    throw new Error('Network response was not ok');
  }
  return response.json();
}

// 2. 沒有變數的情況
function TodoWithoutVar({ todoId }) {
  const { data, isLoading } = useQuery({
    queryKey: ['todos'], // 沒有放 todoId
    queryFn: () => fetchTodoById(todoId),
  });

  if (isLoading) return <div>載入中...</div>;
  return (
    <div>
      <h3>沒有變數的情況</h3>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </div>
  );
}

// 3. 有變數的情況
function TodoWithVar({ todoId }) {
  const { data, isLoading } = useQuery({
    queryKey: ['todos', todoId], // 有放 todoId
    queryFn: () => fetchTodoById(todoId),
  });

  if (isLoading) return <div>載入中...</div>;
  return (
    <div>
      <h3>有變數的情況</h3>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </div>
  );
}

// 4. 父組件
function App() {
  const [selectedTodoId, setSelectedTodoId] = React.useState(1);

  return (
    <div>
      <h1>React Query 快取比較</h1>
      <div>
        <button onClick={() => setSelectedTodoId(1)}>查看待辦事項 1</button>
        <button onClick={() => setSelectedTodoId(2)}>查看待辦事項 2</button>
        <button onClick={() => setSelectedTodoId(3)}>查看待辦事項 3</button>
      </div>

      <TodoWithoutVar todoId={selectedTodoId} />
      <TodoWithVar todoId={selectedTodoId} />
    </div>
  );
}

export default App;
```

---

使用效果

- 沒有變數的情況  
  每次切換 todoId 都會觸發 fetchTodoById，因為快取 key 永遠是 ['todos']，所以資料會被覆蓋。  
  在 console 你會看到：  
  `
  🔍 Fetching todo with id=1 from API...
  🔍 Fetching todo with id=2 from API...
  🔍 Fetching todo with id=3 from API...
  `
  每次都重新打 API。

- 有變數的情況  
  第一次切換某個 todoId 會打 API，之後再切回同一個 todoId 就直接命中快取，不會再打 API。  
  在 console 你會看到：  
  `
  🔍 Fetching todo with id=1 from API...
  🔍 Fetching todo with id=2 from API...
  🔍 Fetching todo with id=3 from API...
  `
  但如果再切回 id=1，就不會再出現 log，因為快取已經有資料。

---

這樣你就能清楚看到差異：  
- 沒有變數 → 共用快取，資料覆蓋，每次切換都重新打 API。  
- 有變數 → 獨立快取，切換時直接命中快取，效能更好

---

📌 業界 PM 需求場景：為什麼要用變數快取

1. 多使用者資料切換
- 需求：CRM 系統或後台管理平台，PM 要求能快速切換不同使用者的詳細資料。
- 原因：每個使用者都有獨立的快取，避免資料互相覆蓋，切換時能立即顯示快取結果。
- 例子：queryKey: ['userProfile', userId]

---

2. 多商品 / 多資源查詢
- 需求：電商平台，PM 要求商品頁面切換時不要每次都重新打 API。
- 原因：商品 ID 不同，快取要分開，才能在使用者切換商品時快速顯示。
- 例子：queryKey: ['product', productId]

---

3. 分頁 / 篩選結果
- 需求：PM 要求列表頁支援分頁、篩選、排序，並且在切換回某一頁時能立即顯示快取。
- 原因：每個分頁或篩選條件都需要獨立快取，否則會覆蓋。
- 例子：queryKey: ['todos', { page: 2, filter: 'completed' }]

---

4. 多語言 / 多地區內容
- 需求：國際化產品，PM 要求同一篇文章在不同語言版本能快取並快速切換。
- 原因：語言是變數，快取要分開，避免顯示錯誤語言。
- 例子：queryKey: ['article', articleId, locale]

---

5. 即時互動場景
- 需求：聊天系統或即時通知，PM 要求不同聊天室能獨立快取，切換時不用重新打 API。
- 原因：聊天室 ID 是變數，快取必須分開。
- 例子：queryKey: ['chatRoom', roomId]

---

✅ 總結
PM 的需求通常是：
- 避免資料覆蓋（不同使用者/商品/聊天室要獨立快取）  
- 提升切換速度（快取命中，不用重新打 API）  
- 支援複雜場景（分頁、篩選、多語言、多地區）  
---
