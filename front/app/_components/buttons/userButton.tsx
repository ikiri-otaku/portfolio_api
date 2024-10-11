import { UserIcon } from "../icons/userIcon";
import { Button } from '@mantine/core';

export default function UserButton() {
  return (
    <Button
      leftSection={<UserIcon width='20px' height='20px' />}
      variant="subtle"
      color="gray"
      size="xs"
      p={0}
    >
      ユーザーネーム
    </Button>
  );
}
