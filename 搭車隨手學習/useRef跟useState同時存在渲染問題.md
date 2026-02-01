
Q2: 如果我想要點擊後 walletA 和 walletB 畫面都有顯示加1的結果，在 displayWalletCashB 的 dependencies 中加上 walletCashBRef.current 會有用嗎?

React 都知道 useRef 的值改變並不會觸發 re-render，所以 displayWalletCashB 的 dependencies 即使加了 walletCashBRef.current 應該也不會造成畫面 walletB 的更新，但如果你嘗試加看看，會發現居然也會跟著更新!



Q3: 呈上題，如果有用的話是為什麼?那用 useRef 和 useState 有什麼差別，不都能更新渲染?

A3: 首先我們要先知道 react 的渲染機制，當 re-render 發生時，所有的 useEffect, useMemo, useCallback 等等都一定會執行(這裡說的執行是指這些react hook 本身，而不是我們傳進去的 function)，這些 react hook 執行時會去比較 dependencies 是否有改變，再決定是否呼叫我們傳進去的 function。

以這題為例，當我點擊按鈕時，我同時 setWalletCashA 和改變 walletCashBRef.current 的值，雖然改變 walletCashBRef.current 的值並不會觸發 re-render，但 setWalletCashA 會，所以導致整個元件 re-render，useMemo 又再執行一次，這時候他會再去比較 dependencies 是否有變，結果發現 walletCashBRef.current 的值確實加1改變了，因此重新呼叫我們傳進去的 function 拿到最新的 <span>walletB: 1</span>。

https://medium.com/@lovebuizel/%E9%80%A3-ai-%E9%83%BD%E6%9C%83%E7%AD%94%E9%8C%AF%E7%9A%84-react-%E9%9D%A2%E8%A9%A6%E9%A1%8C-5982bf28963f
