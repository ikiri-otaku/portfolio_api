export const UserIcon = ({
  height = "",
  width = "",
  fill = "#632BAD",
  stroke = "white",
}) => {
  return (
    <svg
      width={width}
      height={height}
      viewBox="-6 -5 30 30"
      fill={fill}
      xmlns="http://www.w3.org/2000/svg"
    >
      <circle cx="9" cy="10" r="15" fill="#632BAD"/>
      <path
        d="M11.265 2.25751C10.635 1.77751 9.855 1.5 9 1.5C6.93 1.5 5.25 3.18 5.25 5.25C5.25 7.32 6.93 9 9 9C11.07 9 12.75 7.32 12.75 5.25"
        stroke={stroke}
        strokeWidth="0.8"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <path
        d="M15.4426 16.5C15.4426 13.5975 12.5551 11.25 9.00011 11.25C5.44511 11.25 2.55762 13.5975 2.55762 16.5"
        stroke={stroke}
        strokeWidth="0.8"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
};
