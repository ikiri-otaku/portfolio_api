import { MantineProvider } from '@mantine/core';
import List from './_components/buttons/list';
import Submission from './_components/buttons/submission';
import theme from './_constants/customTheme';
import AuthButtons from './_layouts/nav/auth_buttons';
import { getProtectedMessage } from './_services/testAuthMessage';
import TestPostUI from './_services/testPost';

export default async function Home() {
  const { text } = await getProtectedMessage();

  return (
    <MantineProvider theme={theme}>
      <AuthButtons />
      <Submission />
      <List />
      <TestPostUI />
      <hr />
      {text}
    </MantineProvider>
  );
}
