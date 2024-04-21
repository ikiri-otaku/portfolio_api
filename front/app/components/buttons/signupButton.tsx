import { MantineProvider, Button } from '@mantine/core';
import theme from '../customColor';

export default function SignupButton() {
  return (
    <MantineProvider theme={theme}>
      <Button variant="filled" color="violet.7" size="sm" radius="xl">新規登録</Button>
    </MantineProvider>
  );
}
