這是關於useEffect中的一種訂閱用途
https://blog.csdn.net/nibabaoo/article/details/137011047

一、什麼是 IntersectionObserver？  
IntersectionObserver 是一個原生的 JavaScript API，用於非同步地觀察目標元素與其祖先元素（或視口）交叉的情況。  

它可以檢測一個元素是否進入或離開視口。  
它是懶加載圖片、滾動觸發動畫等功能的理想選擇。
https://blog.csdn.net/xiaohua0708day/article/details/144199076

下面這個做法避免了：

避免 onIntersect 的 reference 改變就造成 useEffect 重新執行。

但當 onIntersect 改變時，依然要更新 useEffect 中的 onIntersect 資料

利用 useRef 創建 onIntersectRef 儲存 onIntersect

在 new IntersectionObserver 中，使用 onIntersectRef.current 替代 onIntersect，如此就不需依賴 onIntersect

新增一個 useEffect 確保 onIntersect 改變時，要更新 onIntersectRef.current 內容

https://www.programfarmer.com/zh-TW/articles/2025/react-understand-useEffect-fetching-and-subscription

```
const useIntersectionObserver = ({ 
  rootMargin = "0px", 
  threshold = 0, 
  onIntersect 
}) => {
  const rootRef = useRef(null);
  const targetRef = useRef(null);
  // 利用 useRef 儲存 onIntersect
  const onIntersectRef = useRef(onIntersect);

  // 讓 onIntersectRef.current 同步最新的 onIntersect
  useEffect(() => {
    onIntersectRef.current = onIntersect;
  }, [onIntersect]);

  useEffect(() => {
    const target = targetRef.current;
    if (!target) return;

    const observer = new IntersectionObserver(
      (entries) => {
        const entry = entries[0];
        if (entry) {
          // 使用 ref 儲存的 onIntersect 資料
          onIntersectRef.current(entry.isIntersecting);
        }
      },
      {
        root: rootRef.current,
        rootMargin,
        threshold
      }
    );

    observer.observe(target);

    return () => {
      observer.unobserve(target);
      observer.disconnect();
    };
  }, [rootMargin, threshold]); 
  // ✅ onIntersect 不再是依賴，不再導致不必要的重新訂閱

  return { rootRef, targetRef };
};
```

threshold用途，從options觀察

https://blog.csdn.net/zhudapeng929/article/details/141924340?utm_medium=distribute.wap_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-0-141924340-blog-144199076.237^v3^wap_relevant_t0_download&spm=1001.2101.3001.4242.1

```
let options = {
  root: null, // 观察元素的根元素，null表示视窗
  rootMargin: '0px', // 根元素的边界
  threshold: 0.5 // 交叉比例的阈值，0.5表示元素一半进入视窗时触发回调
};
```
