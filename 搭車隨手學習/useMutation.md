// 現代 React (16+) 可以直接這樣寫：

```
// ✅ React Query 的 useMutation 設計就是這樣用的：
const mutation = useMutation({
  mutationFn: (newTodo) => axios.post('/todos', newTodo)
});

// ✅ 完全正確的用法 - 直接調用 mutate
<button onClick={() => {
  mutation.mutate({ id: new Date(), title: 'Do Laundry' })
}}>
```
// ✅ 早期正确做法：将mutate包装在同步函数中
```
const onSubmit = (event) => {
    event.preventDefault();
    // ✅ 關鍵一步：在同步階段立即提取數據
    const formData = new FormData(event.target);
    
    // ✅ 傳遞的是純數據（formData），而不是會“過期”的 event 物件
    mutation.mutate(formData);
}；
  return <form onSubmit={onSubmit}>...</form>;
};
```

🚫 不正確做法示例（React 16 及之前）
錯誤一：直接將 mutate 作為事件處理器
```
const CreateTodo = () => {
  const mutation = useMutation({
    mutationFn: (event) => { // ❌ 參數預期是 event 物件
      // 問題：當 React Query 稍後執行此函數時，event 已被重置為 null
      event.preventDefault(); // 🕳️ 這裡會出錯：event 是 null 或已被清空
      return fetch("/api", new FormData(event.target));
    },
  });

  // ❌ 錯誤：直接將非同步的 mutate 函數傳給 onSubmit
  // 在 React 16 中，事件物件會在回調執行後被立即清空重用
  return <form onSubmit={mutation.mutate}> 
    <button type="submit">提交</button>
  </form>;
};
```
