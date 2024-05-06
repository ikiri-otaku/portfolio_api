import { DesktopIcon } from '@/app/components/icons/desktopIcon';
import { Button } from '@mantine/core';

export default function List() {
  return (
    <Button
      leftSection={<DesktopIcon width="30px" height="30px" />}
      variant="gradient"
      gradient={{ from: 'violet.7', to: 'violet.3', deg: 70 }}
      size="md"
      radius="xl"
    >
    アプリ一覧
    </Button>
  );
}
