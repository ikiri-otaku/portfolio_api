import { Button, createTheme, MantineProvider, rem } from "@mantine/core";

const theme = createTheme({
  colors: {
    // Add your color
    darkGray: [
      "#f5f5f5",
      "#e7e7e7", 
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
      "#9B80BF", // NOTE: inputBorder
      "#915BD6", // NOTE: right_color
      "#833cdb",
      "#7b2eda",
      "#632BAD", // NOTE: main
      "#5d1cae",
      "#501599",
    ],
    yellow: [
      "#fff5e3",
      "#ffe9c6",
      "#ffd89f",
      "#ffc67a",
      "#FFC403", // NOTE: firstRank
      "#f5a623",
      "#f08c00",
      "#e67700",
      "#d45f00",
      "#c44c00",
    ],
    silver: [
      "#f7f7f7", // NOTE: bg_color
      "#e7e7e7",
      "#d7d7d7",
      "#C9C9C9", // NOTE: secondRank
      "#b7b7b7",
      "#a7a7a7",
      "#979797",
      "#878787",
      "#777777",
      "#676767",
    ],
    brown: [
      "#f5e9e2",
      "#e7d3c5",
      "#dcbbaa",
      "#d1a38f",
      "#c58a74",
      "#b9715a",
      "#ae5840",
      "#AC6D4D", // NOTE: thirdRank
      "#9b3f2b",
      "#8b2f1f",
    ],
    red: [
      "#ffebee",
      "#fcd3d1",
      "#f9b9b7",
      "#f79f9d",
      "#F03E3E", // NOTE: warning
      "#f26b68",
      "#f04f4c",
      "#ee3330",
      "#ec1713",
      "#e90000",
    ],
    white: [
      "#ffffff",
      "#f7f7f7", // NOTE: bgWhite
      "#EDEDED", // NOTE: borderColor
      "#e6e6e6",
      "#d9d9d9",
      "#bfbfbf",
      "#ADB5BD", // NOTE: placeholder
      "#b3b3b3",
      "#a6a6a6",
      "#999999",
    ],
    text: [
      "#E6E6E6",
      "#CCCCCC",
      "#B3B3B3",
      "#999999",
      "#808080",
      "#6E6C71", // NOTE: textGray
      "#4D4D4D",
      "#333333",
      "#1A1A1A",
      "#0D001E", // NOTE: textBlack
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
