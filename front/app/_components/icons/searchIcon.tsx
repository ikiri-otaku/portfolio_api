export const SearchIcon = ({
  height = "",
  width = "",
  fill = "none",
  stroke = "",
}) => {
  return (
    <svg
      width={width}
      height={height}
      viewBox="0 0 14 14"
      fill={fill}
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M6.70841 1.1665C9.77091 1.1665 12.2501 3.64567 12.2501 6.70817C12.2501 9.77067 9.77091 12.2498 6.70841 12.2498C3.64591 12.2498 1.16675 9.77067 1.16675 6.70817C1.16675 4.54984 2.39758 2.68317 4.20008 1.76734"
        stroke={stroke}
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <path
        d="M12.8334 12.8332L11.6667 11.6665"
        stroke={stroke}
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
};
