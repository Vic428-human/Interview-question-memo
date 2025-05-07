Event Loop 

20250508更新
```js
console.log(1);

setTimeout(function () {
  console.log(2);
}, 0);

Promise.resolve()
  .then(function () {
    console.log(3);
  })
  .then(function () {
    console.log(4);
  });
```
Promise 會進到微任務列隊,
setTimeout 會是在宏任務列隊,
會先去看微任務列隊，
不斷提取到執行棧中直到微任務列隊為空,
因此這邊會先執行 Promise ，
然後才是setTimeout。
