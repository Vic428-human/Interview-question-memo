
這種寫法的主要問題有以下幾點：

1. 濫用 key 觸發強制重渲染
你在 <div key={key}> 上動態改變 key，這會讓 React 以為這個 <div> 是全新的元素，因此每次 key 變動時，React 會整個卸載並重新掛載這個 DOM 節點，而不是單純更新內容。這樣會造成不必要的 DOM 操作，降低效能，也可能導致組件的狀態（例如 input focus、動畫等）被重置。

正確做法：
key 應該只用於列表渲染時，幫助 React 識別元素，而不是用來強制重建單一元素。
如果只是要讓畫面每秒更新，直接用 useState 控制 re-render 即可，不需要動 key。

```
const TimeNow = () => {
  const [key, setKey] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => setKey((prevKey) => prevKey + 1), 1000);
    return () => clearInterval(interval);
  }, []);

  return <div key={key}>{new Date()}</div>;
};
```

2. 每次渲染都產生新的 Date 物件
{new Date()} 會在每次渲染時產生新的時間，但這不是問題的根本。
真正的問題是：你沒有將時間作為 state 儲存，而是用 key 來強制刷新組件，這會導致組件的所有子樹都被重建。

建議寫法：
直接用 state 儲存時間，這樣只會更新你想要的部分，效能更好，邏輯更清楚：

```
const TimeNow = () => {
  const [now, setNow] = useState(new Date());

  useEffect(() => {
    const interval = setInterval(() => setNow(new Date()), 1000);
    return () => clearInterval(interval);
  }, []);

  return <div>{now.toLocaleTimeString()}</div>;
};
```
