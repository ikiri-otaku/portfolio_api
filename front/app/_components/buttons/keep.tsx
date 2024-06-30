import { Button } from '@mantine/core';

export default function Keep() {
  return (
    <Button
      variant="gradient"
      gradient={{ from: 'violet.7', to: 'violet.3', deg: 70 }}
      size="md"
      radius="xl"
    >
    <span style={{ margin: '0 15px' }}>保存する</span>
    </Button>
  );
}
