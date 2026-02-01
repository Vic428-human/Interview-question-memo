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
    mutationFn: (formData) => { // 注意：参数改为formData
      return fetch("/api", formData);
    },
  });
  
  const onSubmit = (event) => {
    event.preventDefault(); // 在事件被清空前同步执行
    mutation.mutate(new FormData(event.target)); // 立即提取并传递所需数据
  };

  return <form onSubmit={onSubmit}>...</form>;
};
```
