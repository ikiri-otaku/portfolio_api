import { MantineProvider } from '@mantine/core';
import List from './_components/buttons/list';
import Submission from './_components/buttons/submission';
import theme from './_constants/customTheme';
import AuthButtons from './_layouts/nav/auth_buttons';

export default function Home() {
  return (
    <MantineProvider theme={theme}>
      <AuthButtons />
      <Submission />
      <List />
    </MantineProvider>
  );
}
