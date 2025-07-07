### icon 閃爍效果 

```
import { RxArrowRight } from "react-icons/rx";
// 寫法1 跟 2挑一種來用即可
// tailwind v3 config 
extend: {
   // 寫法１
  animation: {
    blink: 'blink 0.4s linear 6',
 // 寫法２
  keyframes: {
    blink: {
      '0%, 100%': { opacity: 1 },
      '50%': { opacity: 0 },
    },

<div className="absolute right-0 top-0 text-[16px]">
  {/* animate-[blink_0.4s_linear_6] => Tailwind v3.2+ 中是合法語法 */}
  <RxTriangleUp className="text-green-risk absolute -right-1 -top-1 animate-[blink_0.4s_linear_6]" style={{ transform: 'rotate(37.5deg)' }} />
</div>
```
