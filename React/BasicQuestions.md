Event Loop 

### 同步異步說明生活話例子
需了解同步跟異步的區別，可以設想同步就像是現場餐點排隊，一個餐點完成才能給下一位客人，但任務多的時候非常耗時，對於等待的客人來說。

所以異步且像是號碼牌，時間上雖然都是需要等待，但是有多位客人可以先透過號碼牌領取的方式通知餐廳，我已經拿到號碼牌了，然後我先去做其他事情，等餐廳煮完餐點再通知我取餐，與先前的狀況不同在於，下一位客人不會因為前一位客人沒取餐，而繼續排隊等待。


### 微列隊跟宏列隊執行順序
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

### event loop示意圖
![event loop示意圖](https://github.com/Vic428-human/Interview-question-memo/blob/8e76d1fa25b1c0739d984a71da2d58e60a5334d5/Screenshot_2025-05-08-10-15-48-734_com.google.android.youtube-edit.jpg).

console.log會先進入call stack，然後跳出來，代表執行過，下一段執行db查詢，會先進入到call stack然後再跳出後進到libuv api，待稍後執行。

至於這個db查詢什麼時後執行？會在libuv api處理完後，先形成一個callback，進入到event queue,在event queue的特點是FIFO，假設有多比db查詢，將來就會有多筆跟db查詢有關的callback進入到event queue裡，根據特性，先進的callback先出來，所以最一開始db查詢會先變成callback後進入到stack裡然後再透過pop彈出執行。


