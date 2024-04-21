import { MantineProvider, Button } from '@mantine/core';
import theme from '../customColor';

export default function SigninButton() {
  return (
    <MantineProvider theme={theme}>
      <Button variant="outline" color="violet.7" size="sm" radius="xl">ログイン</Button>
    </MantineProvider>
  );
}
