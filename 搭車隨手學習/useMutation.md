// 現代 React (16+) 可以直接這樣寫：

```
const mutation = useMutation({
    mutationFn: (newTodo) => {
      return axios.post('/todos', newTodo)
    },
  })

<button onClick={() => {
  mutation.mutate({ id: new Date(), title: 'Do Laundry' })
}}>
```
