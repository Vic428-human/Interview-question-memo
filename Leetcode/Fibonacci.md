

這個寫法 dp = {0: 0, 1: 1} 運用到了存儲已經
遍歷過數據的概念去記錄樹的過程

```
class Solution:
    def fib(self, n: int) -> int:

        # Base case aka stop condition
        dp = {0: 0, 1: 1}

        def getFib(i):

            # look-up DP Table
            if i in dp:
                return dp[i]

            # General cases
            dp[i] = getFib(i-1) + getFib(i-2)
            return dp[i]

        # --------------------------------------------
        return getFib(n)
```

下面這個寫法沒有考量到樹的節點紀錄
```
class Solution:
    def fib(self, n: int) -> int:

        # Base case aka stop condition
        if n <= 1:
            return n

        # General cases
        return self.fib(n-1) + self.fib(n-2)


```
