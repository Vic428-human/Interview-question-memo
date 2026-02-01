

```
import React from 'react';
import { useQuery, queryOptions } from '@tanstack/react-query';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';

// 建立 QueryClient 實例
const queryClient = new QueryClient();

// API 函數 - 實際的資料獲取邏輯
async function fetchGroups(id: number) {
  console.log(`Fetching group with id: ${id}`);
  
  // 模擬 API 延遲
  await new Promise(resolve => setTimeout(resolve, 1000));
  
  const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`);
  if (!response.ok) {
    throw new Error('Network response was not ok');
  }
  
  return response.json();
}

// 建立 queryOptions
function groupOptions(id: number) {
  return queryOptions({
    queryKey: ['groups', id],
    queryFn: () => fetchGroups(id),
    staleTime: 5 * 1000, // 5秒內資料被視為新鮮，不會重新獲取
  });
}

// 組件部分
function GroupComponent({ groupId }: { groupId: number }) {
  // 使用 useQuery 並傳入 queryOptions
  const { 
    data, 
    isLoading, 
    isError, 
    error, 
    refetch 
  } = useQuery(groupOptions(groupId));

  if (isLoading) {
    return <div>Loading group {groupId}...</div>;
  }

  if (isError) {
    return <div>Error: {error.message}</div>;
  }

  return (
    <div>
      <h2>Group Details</h2>
      <pre>{JSON.stringify(data, null, 2)}</pre>
      <button onClick={() => refetch()}>Refresh Data</button>
    </div>
  );
}

// 主應用組件
function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <div>
        <h1>React Query Example</h1>
        <GroupComponent groupId={1} />
      </div>
    </QueryClientProvider>
  );
}

export default App;
```
