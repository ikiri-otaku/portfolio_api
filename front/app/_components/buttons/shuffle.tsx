import { ShuffleIcon } from "@/app/_components/icons/shuffleIcon";
import { Button } from "@mantine/core";

export default function ShuffleButton() {
  return (
    <Button
      color="violet.7"
      size="xs"
      radius="xl"
      rightSection={<ShuffleIcon width='15px' height='15px' />}
      style={{ 
      }}
    >
      シャッフル
    </Button>
  );
}
