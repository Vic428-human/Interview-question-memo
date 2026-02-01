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
  const [title, setTitle] = useState('');
  const mutation = useMutation({
    mutationFn: (formData) => {
      // 注意：這裡接收的是已經提取好的 formData，不是 event
      return fetch("/api/todos", {
        method: 'POST',
        body: formData,
      });
    },
    onSuccess: () => {
      alert('Todo created successfully!');
      setTitle(''); // 清空表單
    },
    onError: (error) => {
      alert(`Error: ${error.message}`);
    },
  });
  
  const onSubmit = (event) => {
    event.preventDefault();
    // ✅ 在同步階段立即提取數據
    const formData = new FormData(event.target);
    
    // ✅ 傳遞純數據，不是 event 物件
    mutation.mutate(formData);
  };

  return (
    <form onSubmit={onSubmit}>
      <input
        type="text"
        name="title"
        value={title}
        onChange={(e) => setTitle(e.target.value)}
        placeholder="Enter todo title"
        required
      />
      <button type="submit" disabled={mutation.isLoading}>
        {mutation.isLoading ? 'Creating...' : 'Create Todo'}
      </button>
      
      {mutation.isError && (
        <div style={{ color: 'red' }}>
          Error: {mutation.error.message}
        </div>
      )}
    </form>
  );
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
