import { Meta, StoryObj } from "@storybook/react";
import SigninButton from "./signinButton";

const meta: Meta<typeof SigninButton> = {
  // title: 'Buttons',
  component: SigninButton,
}

export default meta

type Story = StoryObj<typeof SigninButton>

export const Default: Story = {}
