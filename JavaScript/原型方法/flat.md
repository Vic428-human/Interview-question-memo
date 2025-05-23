

### flat() 方法用途教學
flat() 是 JavaScript 陣列的方法，
用來「攤平」多層巢狀的陣列，
將其轉換為較淺層甚至一維的陣列
```

// Flat
const flatEx = [1, [2, 3], [[4, 5], 6]];
// 會攤平兩層
const flattenedArray = flatEx.flat(2);
console.log(flattenedArray);
```
