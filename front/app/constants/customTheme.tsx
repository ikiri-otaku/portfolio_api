import { Button, createTheme, MantineProvider, rem } from "@mantine/core";

const theme = createTheme({
  colors: {
    // Add your color
    darkGray: [
      "#f5f5f5",
      "#e7e7e7",  // bg_color
      "#cdcdcd",
      "#b2b2b2",
      "#9a9a9a",
      "#8b8b8b",
      "#848484",
      "#717171",
      "#656565",
      "#575757",
    ],
    violet: [
      "#f6ecff",
      "#e7d6fb",
      "#caabf1",
      "#ac7ce8",
      "#915BD6", //right_color
      "#833cdb",
      "#7b2eda",
      "#632BAD", //main_color
      "#5d1cae",
      "#501599",
    ],
    // or replace default theme color
  },

  shadows: {
    md: "1px 1px 3px rgba(0, 0, 0, .25)",
    xl: "5px 5px 3px rgba(0, 0, 0, .25)",
  },

  headings: {
    fontFamily: "Roboto, sans-serif",
    sizes: {
      h1: { fontSize: rem(36) },
    },
  },
});

export default theme;
