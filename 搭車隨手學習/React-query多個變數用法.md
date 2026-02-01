
PM需求：
後台多個查詢，外加可能需要反覆切換分頁的時候，會用得上
```
import React from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import { Select, Pagination, Radio, Card, Spin, Alert } from 'antd';

// 模擬 API 函數
async function fetchTodos({ userId, page, filter }) {
  console.log(`🔍 Fetching todos for user=${userId}, page=${page}, filter=${filter}`);
  
  const response = await fetch(
    `https://jsonplaceholder.typicode.com/todos?_page=${page}&_limit=5&userId=${userId}`
  );
  if (!response.ok) {
    throw new Error('Network response was not ok');
  }
  const todos = await response.json();

  // 模擬 filter 行為
  if (filter === 'completed') {
    return todos.filter(todo => todo.completed);
  } else if (filter === 'incomplete') {
    return todos.filter(todo => !todo.completed);
  }
  return todos;
}

// TodoList 組件
function TodoList({ userId, page, filter }) {
  const { data, isLoading, isError, error } = useQuery({
    queryKey: ['todos', { userId, page, filter }], // 複合型快取 key
    queryFn: () => fetchTodos({ userId, page, filter }),
    staleTime: 5 * 60 * 1000, // 5 分鐘快取
  });

  if (isLoading) return <Spin tip="載入中..." />;
  if (isError) return <Alert type="error" message={`錯誤: ${error.message}`} />;

  return (
    <Card title={`使用者 ${userId} 的待辦事項（第 ${page} 頁, 篩選: ${filter || '全部'}）`}>
      <ul>
        {data.map(todo => (
          <li key={todo.id}>
            {todo.title} - {todo.completed ? '✅ 已完成' : '❌ 未完成'}
          </li>
        ))}
      </ul>
    </Card>
  );
}

// 父組件
function App() {
  const [userId, setUserId] = React.useState(1);
  const [page, setPage] = React.useState(1);
  const [filter, setFilter] = React.useState('');

  return (
    <div style={{ padding: 24 }}>
      <h1>待辦事項查看器</h1>

      {/* 使用者選擇 */}
      <div style={{ marginBottom: 16 }}>
        <span style={{ marginRight: 8 }}>使用者：</span>
        <Select
          value={userId}
          onChange={setUserId}
          options={[
            { label: '使用者 1', value: 1 },
            { label: '使用者 2', value: 2 },
            { label: '使用者 3', value: 3 },
          ]}
          style={{ width: 120 }}
        />
      </div>

      {/* 分頁控制 */}
      <div style={{ marginBottom: 16 }}>
        <Pagination
          current={page}
          onChange={setPage}
          total={10} // 假設總共 10 筆
          pageSize={5}
        />
      </div>

      {/* 篩選條件 */}
      <div style={{ marginBottom: 16 }}>
        <Radio.Group value={filter} onChange={e => setFilter(e.target.value)}>
          <Radio.Button value="">全部</Radio.Button>
          <Radio.Button value="completed">已完成</Radio.Button>
          <Radio.Button value="incomplete">未完成</Radio.Button>
        </Radio.Group>
      </div>

      {/* 待辦清單 */}
      <TodoList userId={userId} page={page} filter={filter} />
    </div>
  );
}

export default App;

```
