export const LikeOffIcon = ({
  height = "16",
  width = "16",
  fill = "none",
  stroke = "#171717",
}) => {
  return (
    <svg
      width={width}
      height={height}
      viewBox="0 0 16 16"
      fill={fill}
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M8.4135 13.8736C8.18683 13.9536 7.8135 13.9536 7.58683 13.8736C5.6535 13.2136 1.3335 10.4602 1.3335 5.79356C1.3335 3.73356 2.9935 2.06689 5.04016 2.06689C6.2535 2.06689 7.32683 2.65356 8.00016 3.56023C8.6735 2.65356 9.7535 2.06689 10.9602 2.06689C13.0068 2.06689 14.6668 3.73356 14.6668 5.79356C14.6668 10.4602 10.3468 13.2136 8.4135 13.8736Z"
        stroke={stroke}
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
};
