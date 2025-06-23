`useSuspenseQuery` 是 React Query（或 TanStack Query）中的一個功能，主要用於結合 React 的 `Suspense` 特性來處理數據加載的場景。它的用途是簡化異步數據獲取的邏輯，同時利用 `Suspense` 提供更流暢的用戶體驗。

以下是它的主要用途和特點：

---

### 1. **自動處理加載狀態**  
`useSuspenseQuery` 會自動拋出一個 `Promise`，當數據尚未加載完成時，React 會暫停渲染當前組件，直到數據加載完成。這意味著你不需要手動管理 `isLoading` 或 `isFetching` 狀態。

### 2. **簡化代碼邏輯**  
傳統的 React Query 使用 `useQuery` 時，你需要顯式地處理加載狀態和錯誤狀態，例如：

```jsx
const { data, isLoading, error } = useQuery({ queryKey: ['todos'], queryFn: fetchTodos });

if (isLoading) return <div>Loading...</div>;
if (error) return <div>Error: {error.message}</div>;

return <div>{data}</div>;
```

而使用 `useSuspenseQuery` 時，你不需要手動檢查這些狀態，代碼更簡潔：

```jsx
const { data } = useSuspenseQuery({ queryKey: ['todos'], queryFn: fetchTodos });

return <div>{data}</div>;
```

### 3. **與 React Suspense 無縫集成**  
`useSuspenseQuery` 會自動與外層的 `<Suspense>` 組件配合，當數據加載時，會顯示 `fallback` 內容（例如加載動畫），而數據加載完成後再渲染實際內容：

```jsx
<Suspense fallback={<div>Loading...</div>}>
  <MyComponent />
</Suspense>
```

### 4. **錯誤處理更優雅**  
如果查詢失敗，`useSuspenseQuery` 會拋出錯誤，你可以使用 React 的 `Error Boundary` 來捕獲並處理錯誤，而不是在每個組件中手動檢查 `error` 狀態。

### 5. **適用於需要同步代碼風格的場景**  
由於 `Suspense` 的機制，你可以編寫更接近同步風格的代碼，而不需要嵌套回調或 `async/await`，這在某些場景下（如服務器渲染 SSR）特別有用。

---

### 使用範例：
```jsx
import { useSuspenseQuery } from '@tanstack/react-query';
import { Suspense } from 'react';

function TodoList() {
  const { data } = useSuspenseQuery({
    queryKey: ['todos'],
    queryFn: () => fetch('/api/todos').then(res => res.json()),
  });

  return (
    <ul>
      {data.map(todo => (
        <li key={todo.id}>{todo.title}</li>
      ))}
    </ul>
  );
}

function App() {
  return (
    <Suspense fallback={<div>Loading todos...</div>}>
      <TodoList />
    </Suspense>
  );
}
```

---

### 注意事項：
- 必須在外層包裹 `<Suspense>` 組件，否則會報錯。
- 需要搭配 React 18 或更高版本使用。
- 錯誤處理需依賴 `Error Boundary`（錯誤邊界），而不是傳統的 `try/catch`。

總之，`useSuspenseQuery` 適合希望簡化數據加載邏輯、並利用 React Suspense 實現更流暢 UI 的場景。
