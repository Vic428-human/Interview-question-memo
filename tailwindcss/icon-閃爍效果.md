### icon 閃爍效果 

```
import { RxArrowRight } from "react-icons/rx";

// tailwind v3 config 
extend: {
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
