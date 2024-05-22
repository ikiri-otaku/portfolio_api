import { ProfileIcon } from '@/app/components/icons/profileIcon';
import { Button } from '@mantine/core';

export default function EditProfile() {
  return (
    <Button
      leftSection={<ProfileIcon width='25px' height='25px' />}
      variant="outline"
      color="violet.7"
      size="md"
      radius="xl"
    >
    プロフィール編集
    </Button>
  );
}
