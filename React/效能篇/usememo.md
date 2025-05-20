useMemo 是一個 React Hook，
它在每次重新渲染的時候能夠緩存計算的結果


預設情況下，React 會在每次重新渲染時重新執行整個元件。
例如，如果 `TodoList` 更新了 state 或從父元件接收到新的 props，`filterTodos` 
函式將會重新執行

不使用
```
function TodoList({ todos, tab, theme }) {
  const visibleTodos = filterTodos(todos, tab);
  // ...
}
```

使用 useMemo(calculateValue, dependencies)

初次渲染時，從 `useMemo` 獲取的值會是 `calculation` 函式的執行結果。  

在之後的每一次渲染中，React 會比較前後兩次渲染的**所有依賴項**是否相同。如果透過 `Object.is` 比對後，所有依賴項都沒有變化，那麼 `useMemo` 會返回之前已經計算過的值。否則，React 會重新執行 `calculation` 函式並返回一個新的值。  
```
function TodoList({ todos, tab }) {
  const visibleTodos = useMemo(
    () => filterTodos(todos, tab),
      [todos, tab]
  );  
  // ...
}
```

