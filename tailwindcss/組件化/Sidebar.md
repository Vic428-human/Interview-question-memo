function DesktopSidebar() {
  return (
    <div className="hidden relative md:block min-w-[280px] max-w-[280px] h-screen overflow-hidden w-full bg-primary/5 dark:bg-secondary/30 dark:text-foreground text-muted-foreground border-r-2 border-separate ">
      <div className="flex items-center justify-center gap-2 border-b-[1px] border-separate p-4">
        <Logo />
      </div>
      <div className="flex flex-col p-2">
        {routes.map((route) => (
          <Link key={route.href} href={route.href}>
            <route.icon size={20} />
            {route.label}
          </Link>
        ))}
      </div>
    </div>
  );
}

export default DesktopSidebar;

說明：


最外層 div 設定了一些 Tailwind CSS 的樣式，例如：
僅在 md 尺寸以上顯示 (md:block)，其餘為 hidden
固定寬度 min-w 與 max-w 都是 280px
高度為 100vh（h-screen），以及一些背景與文字顏色設定

- 第一個內層 div 用來放置 <Logo /> 元件
- 第二個內層 div 使用 routes.map 將路由資料（應是來自其他地方定義的 routes 陣列）轉成 Link 元素：
- 每個 Link 根據 route.href 來設定 key 和 href

```
// routes.ts (可以放在 routes 目錄下或直接寫在同一檔案中)
import { FiHome, FiSettings, FiUser } from "react-icons/fi";

export const routes = [
  {
    href: "/",
    label: "Home",
    icon: FiHome,
  },
  {
    href: "/settings",
    label: "Settings",
    icon: FiSettings,
  },
  {
    href: "/profile",
    label: "Profile",
    icon: FiUser,
  },
];
```

