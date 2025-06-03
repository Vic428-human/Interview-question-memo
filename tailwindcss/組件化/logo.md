

```
import { cn } from "@lib/utils";
import Link from "next/link";
import React from "react";
import { SquareDashedMousePointer } from "lucide-react";

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
       <div className="rounded-md bg-gradient-to-r from-purple-500 to-indigo-500 p-1">
        <SquareDashedMousePointer className="h-6 w-6 stroke-white" />
      </div>
      <div className="font-bold text-lg">
        <span className="bg-gradient-to-r from-purple-500 to-indigo-500 bg-clip-text text-transparent">Flow</span>
        <span className="text-lime-400">Scrape</span>
      </div>
    </Link>
  );
}
```
