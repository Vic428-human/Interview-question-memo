push
push 是 Array 物件的原型方法（Array.prototype.push），屬於陣列（Array）的內建方法，用來將一或多個元素加入到陣列的尾端，並回傳新的陣列長度。

它本質上是「陣列方法」的一種，但由於 JavaScript 的彈性，push 也可以透過 call 或 apply 應用在「類陣列物件」上。

apply
apply 是 Function 物件的原型方法（Function.prototype.apply），屬於函式（Function）的內建方法，用來指定函式執行時的 this 值，並以「陣列（或類陣列物件）」的形式傳入參數。

它屬於「函式方法」，常用於動態改變函式的執行上下文（this），以及參數的批次傳遞。

### 不用apply的情況
說明：會變成把整個陣列放進另一個陣列中
```
// Call, Bind and Apply in Javascript
// Question 8 - Append an array to a

const array = ["a", "b"];
const elements = [0, 1, 2];

array.push(elements);

console.log(array); // ["a", "b", [0, 1, 2]]

```

### push 搭配 apply使用時
說明：才能把兩個數組間的元素，都放在同個陣列裡

```
const array = ["a", "b"];
const elements = [0, 1, 2];

array.push.apply(array,elements);

console.log(array);
