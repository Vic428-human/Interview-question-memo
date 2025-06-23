
### JavaScript 提供的推薦規則
js.configs.recommended
Using Predefined Configurations
```
import js from "@eslint/js";

export default [
    js.configs.recommended,
    {
        // your configuration here
    }
];
```
#### 出自文檔做法
https://eslint.org/docs/latest/use/configure/configuration-files#using-predefined-configurations

這個做法是直接放在plugin 
```
// eslint.config.js
import js from "@eslint/js";
import { defineConfig } from "eslint/config";

export default defineConfig([
	{
		files: ["**/*.js"],
		plugins: {
			js,
		},
		extends: ["js/recommended"],
		rules: {
			"no-unused-vars": "warn",
		},
	},
]);
```
