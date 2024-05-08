"use client";
import { useEffect, useState } from 'react';
import { MantineProvider } from '@mantine/core';
import List from './_components/buttons/list';
import SigninButton from './_components/buttons/signinButton';
import SignupButton from './_components/buttons/signupButton';
import Submission from './_components/buttons/submission';
import theme from './_constants/customTheme';
import { getPosts } from './_test/getPosts';

export default function Home() {
  const [titles, setTitles] = useState([]);

  useEffect(() => {
    async function loadPosts() {
      const titles = await getPosts();
      setTitles(titles);
    }
    loadPosts();
  }, []);

  return (
    <MantineProvider theme={theme}>
      <SignupButton />
      <SigninButton />
      <Submission />
      <List />

      <div>
        <h1>Post Titles</h1>
        <ul>
            {titles.map((title, index) => (
                <li key={index}>{title}</li>
            ))}
        </ul>
      </div>
    </MantineProvider>
  );
}
