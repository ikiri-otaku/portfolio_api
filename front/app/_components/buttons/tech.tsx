import { PlusIcon } from '@/app/_components/icons/plusIcon';
import { Button } from '@mantine/core';

export default function Tech() {
  return (
    <Button
      leftSection={<PlusIcon width='25px' height='25px' stroke='#632BAD' />}
      variant="outline"
      color="violet.7"
      size="md"
      radius="xl"
    >
    技術歴を追加する
    </Button>
  );
}
