export const XIcon = ({
  height = "",
  width = "",
  fill = "white",
  stroke = "white",
}) => {
  return (
    <svg
      width={width}
      height={height}
      viewBox="0 0 30 30"
      fill={fill}
      xmlns="http://www.w3.org/2000/svg"
    >
      <circle cx="12" cy="12" r="12" fill="black"/>
      <path
        d="M13.1416 11.0786L17.6089 6H16.5503L12.6714 10.4097L9.57328 6H6L10.6849 12.6682L6 17.9938H7.05866L11.1549 13.3371L14.4267 17.9938H18L13.1414 11.0786H13.1416ZM11.6916 12.7269L11.217 12.0629L7.44011 6.77941H9.06615L12.1141 11.0434L12.5888 11.7074L16.5508 17.2499H14.9248L11.6916 12.7272V12.7269Z"
        stroke={stroke}
        strokeWidth="0.2"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
};
