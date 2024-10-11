export const LocationIcon = ({
  height = "",
  width = "",
  fill = "none",
  stroke = "#6E6C71",
}) => {
  return (
    <svg
      width={width}
      height={height}
      viewBox="0 0 15 15"
      fill={fill}
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M7.99992 8.95346C9.14867 8.95346 10.0799 8.02221 10.0799 6.87346C10.0799 5.7247 9.14867 4.79346 7.99992 4.79346C6.85117 4.79346 5.91992 5.7247 5.91992 6.87346C5.91992 8.02221 6.85117 8.95346 7.99992 8.95346Z"
        stroke={stroke}
        strokeWidth="1.0"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <path
        d="M2.41379 5.66016C3.72712 -0.113169 12.2805 -0.106502 13.5871 5.66683C14.3538 9.0535 12.2471 11.9202 10.4005 13.6935C9.06046 14.9868 6.94046 14.9868 5.59379 13.6935C3.75379 11.9202 1.64712 9.04683 2.41379 5.66016Z"
        stroke={stroke}
        strokeWidth="1.0"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
};
