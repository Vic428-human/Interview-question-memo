## 前言 
> 在頁面載入時，顯示一個 skeleton 載入畫面，等候 3 秒後顯示真正內容（目前是空的）。

---
這是 page 元件，是預設匯出的頁面元件，
通常是用在 Next.js 的 App Router 中：

使用 <Suspense> 包裹 UserWorkflows，
在資料載入時會顯示 UserWorkflowsSkeleton 作為載入骨架。

Suspense 是 React 的一種延遲元件顯示的方式，
通常與 async/await 或 React.lazy() 一起使用。
```
function page() {
  return (
    <div>
      <div>
        <Suspense fallback={<UserWorkflowsSkeleton />}>
          <UserWorkflows />
        </Suspense>
      </div>
    </div>
  );
}
```

---

### 這是載入時顯示的骨架元件

會顯示 4 個高度為 h-32、寬度為 w-full 的 <Skeleton /> 元件。

space-y-2 讓每個 <Skeleton /> 元件之間有垂直間距。

```
function UserWorkflowsSkeleton() {
  return (
    <div className="space-y-2">
      {[1, 2, 3, 4].map((i) => (
        <Skeleton key={i} className="h-32 w-full" />
      ))}
    </div>
  );
}
```

---

## 模擬資料延遲的主元件：

waitFor(3000) 暫停 3 秒模擬載入。
```
async function UserWorkflows() {
  await waitFor(3000); // 假設 waitFor 是個延遲函式，延遲 3 秒
  return <div></div>;
}
```

```
function waitFor(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}
```
---


