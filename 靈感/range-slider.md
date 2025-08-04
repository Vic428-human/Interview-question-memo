

```
div>
                    <BarWithInput
                      min={0}
                      max={1000}
                      step={1}
                      defaultValue={0}
                      onChange={(value) => {
                        updateSetting(setting.title, value);
                      }}
                      currentValue={Number(globalSelection[setting.title] ?? 0)}
                    />
                  </div>

function BarWithInput({
  min = 0,
  max = 100,
  step = 1,
  defaultValue = 0,
  onChange,
  currentValue,
}: {
  min: number;
  max: number;
  step: number;
  defaultValue: number;
  onChange: (value: number) => void;
  currentValue: number;
}) {
  const [hasMounted, setHasMounted] = useState(false);
  const [value, setValue] = useState(defaultValue);

  useEffect(() => {
  if (!hasMounted) {
    setHasMounted(true);
    return;
  }

  if (typeof onChange === "function") {
    onChange(value);
  }
}, [value]);

  const update = (next: string) => setValue(Number(next));

  return (
    <div className="flex items-center gap-2">
      {/* 滑桿 */}
      <input
        type="range"
        className="w-full h-3 rounded-full accent-[#FFB80C]"
        min={min}
        max={max}
        step={step}
        value={currentValue || 0}
        onChange={(e) => update(e.target.value)}
      />

      {/* 數字輸入框 */}
      <div className="relative w-36">
        <input
          type="number"
          min={min}
          max={max}
          step={step}
          value={currentValue || 0}
          onChange={(e) => update(e.target.value)}
          className="w-full pr-8 px-1 py-0.5 border rounded text-right bg-[#424242] text-white no-spinner focus:outline-none focus:border-gray-500 focus:ring-1 focus:ring-gray-500"
        />
        <span className="absolute right-2 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none">
          px
        </span>
      </div>
    </div>
  );
}

```
