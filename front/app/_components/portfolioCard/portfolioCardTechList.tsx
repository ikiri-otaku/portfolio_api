import BaseImage from '@/app/_components/images/baseImage';

type Props = {
  tech: string;
  key: string;
};

export default function PortfolioCardTechList({ tech, key }: Props) {
  return (
    <>
      <li
        key={key}
        className="flex flex-col items-center justify-center rounded-full border border-borderColor p-1.5"
      >
        <BaseImage
          src={`/tech/tech-${tech.toLowerCase()}.svg`}
          width={100}
          height={100}
          alt=""
          className="h-auto w-auto"
        />
      </li>
    </>
  );
}
