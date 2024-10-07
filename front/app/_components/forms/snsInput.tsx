import { TextInput } from "@mantine/core";
import classes from "./profileForm.module.css";

interface SnsInputProps {
  width: number;
  placeholder?: string;
}

export default function SnsInput({ width, placeholder = "Search" }: SnsInputProps) {
  return (
    <TextInput
      size="md"
      placeholder={placeholder}
      classNames={{ input: classes.input }}
      style={{ width }}
    />
  );
}
