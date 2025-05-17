


### 規劃class 層級的observer pattern 

## 應用場景

假設現在有多個按鈕，可能是Switch toggle，也可能是一般的按鈕，不管哪一種，我都希望點擊後，能夠出現一個toast彈窗，等於說這兩個handleClick都會觸發notify這個共通function，可以想像成這是一個觀察者，觀察著這兩種按鈕的調用，而同時我希望按鈕被調用的時候，能同時觀察log的紀錄，所以另外獨立出來logger，這麼做可以簡化function的重複出現

```
class Observable {
  constructor() {
    this.observers = [];
  }

  subscribe(func) {
    this.observers.push(func);
  }

  unsubscribe(func) {
    this.observers = this.observers.filter((observer) => observer !== func);
  }

  notify(data) {
    this.observers.forEach((observer) => observer(data));
  }
}

// 建立 Observable 實例
const observable = new Observable();

// 定義兩個觀察者
function observer1(data) {
  console.log('Observer 1 received:', data);
}

function observer2(data) {
  console.log('Observer 2 received:', data);
}

// 觀察者訂閱
observable.subscribe(observer1);
observable.subscribe(observer2);

// 用假數據通知觀察者
observable.notify('Mock data 1');
observable.notify('Mock data 2');

// 取消 observer1 訂閱
observable.unsubscribe(observer1);

// 再次通知，只剩 observer2 會收到
observable.notify('Mock data 3');

```

```
import React from "react";
import { Button, Switch, FormControlLabel } from "@material-ui/core";
import { ToastContainer, toast } from "react-toastify";
import observable from "./Observable";

function handleClick() {
  observable.notify("User clicked button!");
}

function handleToggle() {
  observable.notify("User toggled switch!");
}

function logger(data) {
  console.log(`${Date.now()} ${data}`);
}

function toastify(data) {
  toast(data, {
    position: toast.POSITION.BOTTOM_RIGHT,
    closeButton: false,
    autoClose: 2000
  });
}

observable.subscribe(logger);
observable.subscribe(toastify);

export default function App() {
  return (
    <div className="App">
      <Button variant="contained" onClick={handleClick}>
        Click me!
      </Button>
      <FormControlLabel
        control={<Switch name="" onChange={handleToggle} />}
        label="Toggle me!"
      />
      <ToastContainer />
    </div>
  );
}

```


![observer pattern 示意圖](https://github.com/Vic428-human/Interview-question-memo/blob/4616c1eb67f8d9aef2294d44f6becda2c905b79b/JavaScript/Screenshot_2025-05-17-16-11-12-051_com.google.android.youtube-edit.jpg).


基本用法，基於上面這個圖的架構

```
// MIXIN that will implement Observer Pattern
const observerMixin = {
    observers: new Set(),
    addObserver(obs) { this.observers.add(obs); },
    removeObserver(obs) { this.observers.delete(obs); },
    notify() { this.observers.forEach(obs => obs()); }
}

observerMixin.addObserver(() => {

})

observerMixin.addObserver(() => {

})

```

### 先了解 set 怎麼使用

```
const set = new Set();
set.add(1);
set.add(2);
set.add(2); // 重複的值會被忽略
set.add('apple');
set.add({ name: 'Tom' });

console.log(set); 
// 輸出：Set(3) { 1, 2, 'apple', { name: 'Tom' } }
```

現在嘗試基於剛才的observerMixin物件，去使用
如果把這個 Set 的內容（例如：Set(4) { 1, 2, 'apple', { name: 'Tom' } }）當作 observers，然後執行：

### 這時會發生什麼？

notify() 會嘗試對 Set 裡的每一個元素呼叫 obs()。

但只有「函數」型別的元素可以被呼叫（即 obs 必須是 function）。

如果 Set 裡面有數字、字串或物件（像 1, 2, 'apple', { name: 'Tom' }），這些都不是函數，執行 obs() 會直接拋出 TypeError 錯誤。

所以，set()的內容需要是物件裡有function才行

例如添加的時候加一個 arrow function 
```
const observers = new Set([
  () => { console.log('observer 1'); },
  () => { console.log('observer 2'); },
  () => { console.log('observer 3'); }
]);
```

