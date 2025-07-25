
### as const 用法
使用 as const 在這段 logicToViewModeMap 宣告中，
目的是讓 TypeScript 更「精確地」推斷這個物件的型別，
避免過度寬鬆的推論。
```
const logicToViewModeMap = {
    STATIC_VIEW: 'static_mode',
    INTERACTIVE_VIEW: 'interactive_mode',
    CUSTOM_VIEW: 'custom_mode',
  } as const;
```

🔍 沒有 as const 的情況

如果你寫：

`ts
const logicToViewModeMap = {
  STATICVIEW: 'staticmode',
  INTERACTIVEVIEW: 'interactivemode',
  CUSTOMVIEW: 'custommode',
};
`

TypeScript 會推論成：

`ts
{
  STATIC_VIEW: string;
  INTERACTIVE_VIEW: string;
  CUSTOM_VIEW: string;
}
`

也就是說，值的型別是「string」，太寬鬆了，後續無法精準比對或做類型縮窄。

---

🧠 使用 as const 的好處

當你寫：

`ts
const logicToViewModeMap = {
  STATICVIEW: 'staticmode',
  INTERACTIVEVIEW: 'interactivemode',
  CUSTOMVIEW: 'custommode',
} as const;
`

TypeScript 會推論成：

`ts
{
  readonly STATICVIEW: 'staticmode';
  readonly INTERACTIVEVIEW: 'interactivemode';
  readonly CUSTOMVIEW: 'custommode';
}
`

這意味著：
- 每個值是 特定字串字面值類型（例如 'static_mode' 而不是一般的 string）
- 每個鍵與值都是 readonly，不可再被改動

---

✨ 實用場景

你可能會這樣使用：

`ts
type ViewMode = typeof logicToViewModeMap[keyof typeof logicToViewModeMap];
// ➜ ViewMode 推斷為：'staticmode' | 'interactivemode' | 'custom_mode'
`

這樣可以保證：
- 你的函式只接受這三種值
- IDE 自動補全超方便
- 不會誤用其他字串
