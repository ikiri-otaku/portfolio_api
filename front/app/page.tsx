"use client";
import { MantineProvider } from '@mantine/core';
import List from './_components/buttons/list';
import SigninButton from './_components/buttons/signinButton';
import SignupButton from './_components/buttons/signupButton';
import Submission from './_components/buttons/submission';
import theme from './_constants/customTheme';

export default function Home() {
  return (
    <MantineProvider theme={theme}>
      <SignupButton />
      <SigninButton />
      <Submission />
      <List />
    </MantineProvider>
  );
}
