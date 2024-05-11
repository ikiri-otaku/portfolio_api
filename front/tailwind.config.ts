import { Secondary } from "@/stories/Button.stories";
import { PiPlaceholder } from "react-icons/pi";
import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      backgroundImage: {
        "gradient-radial": "radial-gradient(var(--tw-gradient-stops))",
        "gradient-conic":
          "conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))",
      },
      colors: {
        main: "#632BAD", // NOTE: brand color
        textBlack: "#0D001E", 
        textGray: "#6E6C71", 
        bgWhite: "#F7F7F7", 
        borderColor: "#EDEDED", 
        firstRank: "#FFC403", 
        secondRank: "#C9C9C9", 
        thirdRank: "#AC6D4D", 
        placeholder: "#ADB5BD", 
        inputBorder: "#9B80BF",
        warning: "#F03E3E",
      },
    },
  },
  plugins: [],
};
export default config;
