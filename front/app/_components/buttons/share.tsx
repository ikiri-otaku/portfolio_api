import { ShareIcon } from '@/app/_components/icons/shareIcon';
import { Button } from '@mantine/core';

export default function Share() {
  return (
    <Button
      leftSection={<ShareIcon width='30px' height='30px' />}
      variant="outline"
      color="violet.7"
      size="md"
      radius="xl"
    >
    シェア
    </Button>
  );
}
