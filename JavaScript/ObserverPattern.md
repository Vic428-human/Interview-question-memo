
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

