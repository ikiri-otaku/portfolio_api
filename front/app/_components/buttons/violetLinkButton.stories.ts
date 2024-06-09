import type { Meta, StoryObj } from '@storybook/react';
import VioletLinkButton from './violetLinkButton';

const meta: Meta<typeof VioletLinkButton> = {
  title: 'Component/Button/VioletLinkButton',
  component: VioletLinkButton,
  tags: ['autodocs'],
}

export default meta;

type Story = StoryObj<typeof VioletLinkButton>;

export const Filled: Story = {
  args: {
    label: 'Button',
  },
};

export const Outline: Story = {
  args: {
    variant: 'outline',
    label: 'Button',
  },
};
