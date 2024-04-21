"use client";
import { MantineProvider } from '@mantine/core';
import ButtonCopy from "./components/buttons/signupButton";
import SigninButton from "./components/buttons/signinButton";
import Submission from "./components/buttons/submission";
import theme from './components/customColor';

export default function Home() {
  return (
    <MantineProvider theme={theme}>
      <ButtonCopy />
      <SigninButton />
      <Submission />
    </MantineProvider>  
  );
}
