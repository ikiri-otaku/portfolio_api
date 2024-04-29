import { Meta, StoryObj } from "@storybook/react";
import Footer from "./footer";

const meta: Meta<typeof Footer> = {
  title: 'Layout/Footer',
  component: Footer,
  tags: ['autodocs'],
}

export default meta

type Story = StoryObj<typeof Footer>

export const Default: Story = {}

// TODO: Linkのテスト
