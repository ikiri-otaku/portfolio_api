import { PlusIcon } from '@/app/_components/icons/plusIcon';
import { Button } from '@mantine/core';

export default function Submission() {
  return (
    <Button
      leftSection={<PlusIcon width='20px' height='20px' />}
      variant="gradient"
      gradient={{ from: 'violet.7', to: 'violet.3', deg: 70 }}
      size="md"
      radius="xl"
    >
    アプリを投稿する
    </Button>
  );
}
