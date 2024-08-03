import { Textarea } from "@mantine/core";
import classes from "./searchForm.module.css";

export default function UserInput({ width, height }: { width: number, height: number }) {
  return (
    <Textarea
      size="md"
      placeholder="簡単な経歴やこれから挑戦したいことなど..."
      classNames={{ input: classes.input }}
      style={{ width, height }}
      autosize
      minRows={5}
    />
  );
}
