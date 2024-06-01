import theme from '@/app/_constants/customTheme';
import Header from '@/app/_layouts/header';
import { UserProvider } from '@auth0/nextjs-auth0/client';
import { MantineProvider } from '@mantine/core';
import { Meta, StoryObj } from '@storybook/react';

const meta: Meta<typeof Header> = {
  title: 'Layout/Header',
  component: Header,
  tags: ['autodocs'],
  decorators: [
    (Story) => (
      <UserProvider>
        <MantineProvider theme={theme}>
          <Story />
        </MantineProvider>
      </UserProvider>
    ),
  ],
};

export default meta;

type Stroy = StoryObj<typeof Header>;

export const Default: Stroy = {};
