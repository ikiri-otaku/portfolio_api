import { MantineProvider } from '@mantine/core';
import List from './_components/buttons/list';
import Submission from './_components/buttons/submission';
import theme from './_constants/customTheme';

export default function Home() {
  return (
    <MantineProvider theme={theme}>
      <Submission />
      <List />
    </MantineProvider>
  );
}
