
1. Promise 是一個建構函式，可以用來建立新的 Promise 物件。
2. Promise 本身有靜態方法（如 all、race、resolve、reject 等），可直接透過 Promise 調用。
3. Promise 的 prototype 上有 then、catch 等方法，這些是每個 Promise 實例都能使用的方法。

### 此promise構造函數，會顯示什麼結果？

因為經歷reject ，所以不會觸發到then，而是直接執行catch，
又因catch 有成功執行，所以接下來的then也跟著觸發，
所以log的結果是，Error 1跟 Success 4。
```
function job() {
  return new Promise(function(resolve, reject) {
    reject();
  });
}

let promise = job();

promise
  .then(function () {
    console.log("Success 1");
  })
  .then(function () {
    console.log("Success 2");
  })
  .then(function () {
    console.log("Success 3");
  })
  .catch(function () {
    console.log("Error 1");
  })
  .then(function () {
    console.log("Success 4");
  });
```

### promise構造函數在異步的範例
執行這段程式碼，會在 2 秒後輸出「執行完成」。
我只是 new 了一個物件，並沒有呼叫它，
但傳進去的函式就已經執行了，這是一個需要注意的細節。

```
//做一些非同步操作
setTimeout(function(){
    console.log('執行完成');
    resolve('隨便什麼資料');
}, 2000);
```
所以我們用 Promise 的時候，通常會把它包在一個函式中，
在需要的時候才去執行這個函式。

```
function runAsync(){
    var p = new Promise(function(resolve, reject){
        //做一些异步操作
        setTimeout(function(){
            console.log('执完成');
            resolve('随便');
        }, 2000);
    });
    return p;            
}
runAsync()
```

### envent loop當運用到 microtask queue 與 promise 同步時

執行順序分析

同步代碼先執行

console.log("start") 直接輸出 start。

宣告 fn 函式（這步不會有輸出）。

console.log("middle") 輸出 middle。

呼叫 fn()，執行 Promise executor（同步）

執行 fn() 時，會立即執行 Promise 的 executor function，所以 console.log(1) 會馬上輸出 1。

resolve("success") 會將 Promise 狀態設為 fulfilled，但 .then 的回呼（callback）不會立刻執行，而是被加入「microtask queue」。

繼續執行同步代碼

console.log("end") 輸出 end。

主線程（call stack）清空後，執行 microtask queue（Promise 的 then）

這時，Event Loop 會檢查 microtask queue，發現有一個 .then 的回呼，所以執行 console.log(res)，輸出 success。

```
console.log("start");

const fn = () => 
  new Promise((resolve, reject) => {
    console.log(1);
    resolve("success");
  });

console.log("middle");

fn().then((res) => {
  console.log(res);
});

console.log("end");

```
