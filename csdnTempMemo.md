
初步認識 IntersectionObserver() 

這是關於useEffect中的一種訂閱用途
https://blog.csdn.net/nibabaoo/article/details/137011047

一、什么是 IntersectionObserver？
IntersectionObserver 是一个原生的 JavaScript API，用于异步地观察目标元素与其祖先元素（或视口）交叉的情况。

简单来说：

它可以检测一个元素是否进入或离开视口。
它是懒加载图片、滚动触发动画等功能的理想选择。
https://blog.csdn.net/xiaohua0708day/article/details/144199076


下面這個做法避免了：

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

