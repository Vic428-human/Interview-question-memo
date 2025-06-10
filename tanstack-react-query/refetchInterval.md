
## refetchInterval 用法

這段 useQuery 的寫法屬於 TanStack Query v5 的語法。
在 v5 之後，refetchInterval 支援傳入一個函式，
該函式可根據 data 動態決定間隔時間（或是否啟用自動 refetch）。

在 v4，refetchInterval 只能是固定的數值（如 5000），不能是函式。

### 假設 useQuery 的回傳data如下
```
// 假資料
const data = {
  todos: [
    { id: 1, text: '買牛奶', completed: false },
    { id: 2, text: '寫作業', completed: true },
    { id: 3, text: '運動30分鐘', completed: false },
  ],
  refetchNeeded: true, // 這裡可以切換 true/false 來測試 refetchInterval
};
```

### refetchInterval 在術語上就叫做「polling」（輪詢）

```
import { useQuery } from '@tanstack/react-query';

const fetchTodos = async () => {
  // 假設從 API 取得 todos
  const response = await fetch('/api/todos');
  if (!response.ok) throw new Error('Network response was not ok');
  return response.json();
};

function TodosComponent() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['todos'],
    queryFn: fetchTodos,
    refetchInterval: (data) => (data?.refetchNeeded ? 5000 : false), // 從 useQuery 回傳的 data傳進來的
  });

  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  return (
    <ul>
      {data.todos.map((todo) => (
        <li key={todo.id}>{todo.text}</li>
      ))}
    </ul>
  );
}
```
