import { Button } from '@mantine/core';
import { IoDesktopOutline } from "react-icons/io5";

export default function List() {
  return (
    <Button
      leftSection={<IoDesktopOutline size={20} />}
      variant="gradient"
      gradient={{ from: 'violet.7', to: 'violet.3', deg: 70 }}
      size="md"
      radius="xl"
    >
    アプリ一覧
    </Button>
  );
}
