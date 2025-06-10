
## refetchInterval 用法

這段 useQuery 的寫法屬於 TanStack Query v5 的語法。
在 v5 之後，refetchInterval 支援傳入一個函式，
該函式可根據 data 動態決定間隔時間（或是否啟用自動 refetch）。

在 v4，refetchInterval 只能是固定的數值（如 5000），不能是函式。

### 假設 useQuery 的回傳data如下
```
// 模擬取得下注賠率的 API
const fetchOdds = async () => {
  // 這裡可替換為實際 API 呼叫
  // 假設每次取得最新賠率
  return {
    odds: [
      { id: 1, name: '隊伍A', value: Math.random() * 10 + 1 },
      { id: 2, name: '隊伍B', value: Math.random() * 10 + 1 },
      { id: 3, name: '和局', value: Math.random() * 5 + 1 },
    ],
    updatedAt: Date.now(),
  };
};
```

### refetchInterval 在術語上就叫做「polling」（輪詢）
> 這裡以下注賠率做參考，賠率這種東西都是每秒刷新，所以不用特別在 refetchInterval 下判斷。

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
    queryKey: ['odds'],
    queryFn: fetchOdds,
    refetchInterval: 1000, // 每秒自動 refetch 一次
    refetchIntervalInBackground: true, // 即使視窗非焦點也持續 polling（可選）
  });

  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  return (
    <div>
      <h3>最新下注賠率</h3>
      <ul>
        {data.odds.map((item) => (
          <li key={item.id}>
            {item.name}：{item.value.toFixed(2)}
          </li>
        ))}
      </ul>
      <small>更新時間：{new Date(data.updatedAt).toLocaleTimeString()}</small>
    </div>
  );
}
```
