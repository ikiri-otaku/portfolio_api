import { MantineProvider, Button } from '@mantine/core';
import { IoAddCircleOutline } from "react-icons/io5";
import theme from '../customColor';

export default function Submission() {
  return (
    <MantineProvider theme={theme}>
      <Button
        leftSection={<IoAddCircleOutline size={20} />}
        variant="gradient"
        gradient={{ from: 'violet.7', to: 'violet.3', deg: 70 }}
        size="md"
        radius="xl"
      >
      アプリを投稿する
      </Button>
    </MantineProvider>
  );
}
