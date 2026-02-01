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
const CreateTodo = () => {
  const mutation = useMutation({
    mutationFn: (formData) => { 
      // 注意：這裡的 mutationFn 本身是【非同步】的，它包含 fetch 請求
      return fetch("/api", formData); // fetch 返回 Promise，是典型的非同步操作
    },
  });
  
  const onSubmit = (event) => {
    // 🔵【同步操作】瀏覽器觸發 submit 事件時立即執行，阻塞當前執行緒
    // 作用：阻止瀏覽器默認的表單提交行為，避免頁面跳轉
    event.preventDefault(); 
    
    // 🔴【非同步操作開始】mutate() 被調用，但實際的網路請求是非同步進行的
    // 1. new FormData(event.target) 是【同步】提取數據（事件對象尚未被清空）
    // 2. mutate() 將請求任務排入隊列，不阻塞後續代碼執行
    // 3. 稍後，React Query 會非同步地執行上面定義的 mutationFn
    mutation.mutate(new FormData(event.target)); 
    
    // ⏰ 時間點說明：到這裡時，mutationFn 中的 fetch 請求可能還沒發出去
    // 網路請求在瀏覽器的非同步任務隊列中等待執行
  };

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
