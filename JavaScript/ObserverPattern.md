
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
