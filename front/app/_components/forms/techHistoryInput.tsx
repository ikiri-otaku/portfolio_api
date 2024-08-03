import { Select } from "@mantine/core";
import { useState } from "react";
import classes from "./searchForm.module.css";

const techHisories = [
  { value: 'oneToTwoYears', label: '1〜2年' },
  { value: 'twoToThreeYears', label: '2〜3年' },
  { value: 'threeToFiveYears', label: '3〜5年' },
  { value: 'fiveYearsOver', label: '5年以上' },
];

export default function TechHistorySelect({ width }: { width: number }) {
  const [value, setValue] = useState<string | null>(null);

  return (
    <Select
      placeholder="選択してください"
      data={techHisories}
      value={value}
      onChange={setValue}
      classNames={{ input: classes.input }}
      style={{ width }}
    />
  );
}
