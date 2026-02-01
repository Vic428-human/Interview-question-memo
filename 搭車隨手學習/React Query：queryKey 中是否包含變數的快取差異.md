完整範例程式碼

`jsx
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
`

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
- 有變數 → 獨立快取，切換時直接命中快取，效能更好。  
