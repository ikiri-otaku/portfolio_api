import "@mantine/core/styles.css";
import '../app/globals.css';

import React, { useEffect } from "react";
import { addons } from "@storybook/preview-api";
import { DARK_MODE_EVENT_NAME } from "storybook-dark-mode";
import { MantineProvider, useMantineColorScheme } from "@mantine/core";
import { withMantineThemes } from "storybook-addon-mantine"
import theme from "../app/_constants/customTheme";
import { Preview } from "@storybook/react";

const channel = addons.getChannel();

function ColorSchemeWrapper({ children }: { children: React.ReactNode }) {
  const { setColorScheme } = useMantineColorScheme();
  const handleColorScheme = (value: boolean) =>
    setColorScheme(value ? "dark" : "light");

  useEffect(() => {
    channel.on(DARK_MODE_EVENT_NAME, handleColorScheme);
    return () => channel.off(DARK_MODE_EVENT_NAME, handleColorScheme);
  }, [channel]);

  return <>{children}</>;
}

export const decorators = [
  (renderStory: any) => (
    <ColorSchemeWrapper>{renderStory()}</ColorSchemeWrapper>
  ),
  (renderStory: any) => (
    <MantineProvider theme={theme}>{renderStory()}</MantineProvider>
  ),
  // withMantineThemes({
  //   themes: [
  //     {
  //       id: "theme",
  //       name: "Theme",
  //       ...theme,
  //     },
  //   ],
  // }),
];

// const preview: Preview = {
//   parameters: {
//     actions: { argTypesRegex: '^on[A-Z].*' },
//     controls: {
//       matchers: {
//         color: /(background|color)$/i,
//         date: /Date$/,
//       },
//     },
//   },
//   decorators: [
//     (Story) => (
//       <MantineProvider theme={theme}>
//         <Story />
//       </MantineProvider>
//     ),
//   ],
// }

// export default preview
