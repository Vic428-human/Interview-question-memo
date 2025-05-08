Event Loop 

### 同步異步說明生活話例子
需了解同步跟異步的區別，可以設想同步就像是現場餐點排隊，一個餐點完成才能給下一位客人，但任務多的時候非常耗時，對於等待的客人來說。

所以異步且像是號碼牌，時間上雖然都是需要等待，但是有多位客人可以先透過號碼牌領取的方式通知餐廳，我已經拿到號碼牌了，然後我先去做其他事情，等餐廳煮完餐點再通知我取餐，與先前的狀況不同在於，下一位客人不會因為前一位客人沒取餐，而繼續排隊等待。


### 簡易代碼案例
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


