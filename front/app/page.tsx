"use client";
import { MantineProvider } from '@mantine/core';
import ButtonCopy from "./components/buttons/signupButton";
import SigninButton from "./components/buttons/signinButton";
import Submission from "./components/buttons/submission";
import List from './components/buttons/list';
import theme from './constants/customTheme';

export default function Home() {
  return (
    <MantineProvider theme={theme}>
      <ButtonCopy />
      <SigninButton />
      <Submission />
      <List />
    </MantineProvider>  
  );
}
