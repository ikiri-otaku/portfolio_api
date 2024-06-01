export const DesktopIcon = ({
  height = "",
  width = "",
  fill = "none",
  stroke = "#e7e7e7",
}) => {
  return (
    <svg
      width={width}
      height={height}
      viewBox="0 0 30 30"
      fill={fill}
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M8.04975 2.49902H21.9373C26.3873 2.49902 27.4998 3.61152 27.4998 8.04902V15.9615C27.4998 20.4115 26.3873 21.5115 21.9498 21.5115H8.04975C3.61226 21.524 2.49976 20.4115 2.49976 15.974V8.04902C2.49976 3.61152 3.61226 2.49902 8.04975 2.49902Z"
        stroke={stroke}
        strokeWidth="2.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <path
        d="M15 21.5254V27.5004"
        stroke={stroke}
        strokeWidth="2.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <path
        d="M2.49976 16.251H27.4998"
        stroke={stroke}
        strokeWidth="2.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <path
        d="M9.375 27.501H20.625"
        stroke={stroke}
        strokeWidth="2.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
};
