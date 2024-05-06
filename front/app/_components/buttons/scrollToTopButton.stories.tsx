import { Meta, StoryObj } from "@storybook/react";
import ScrollToTopButton from "./scrollToTopButton";

const meta: Meta<typeof ScrollToTopButton> = {
  title: 'Component/Button/ScrollToTopButton',
  component: ScrollToTopButton,
  tags: ['autodocs'],
}

export default meta

type Story = StoryObj<typeof ScrollToTopButton>

export const Default: Story = {}
