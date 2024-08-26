import { ShuffleIcon } from "../icons/shuffleIcon";
import { Button } from "@mantine/core";

export default function ShuffleButton() {
  return (
    <Button
      color="violet.7"
      size="xs"
      radius="xl"
      rightSection={<ShuffleIcon width='10px' height='10px' />}
      style={{ 
        width: '86px', 
        height: '18px', 
        fontSize: '10px',
        paddingLeft: '6px',
        paddingRight: '6px',
      }}
    >
      シャッフル
    </Button>
  );
}
