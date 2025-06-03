

```
import { cn } from "@lib/utils";
import Link from "next/link";
import React from "react";

function Logo({
  fontSize = "2xl",
  iconSize = 20,
}: {
  fontSize?: string;
  iconSize?: number;
}) {
  return (
    <Link
      href="/"
      className={cn(
        "text-2xl font-extrabold flex items-center gap-2",
        fontSize
      )}
    >
      {/* ... (其他內容) */}
    </Link>
  );
}
```
