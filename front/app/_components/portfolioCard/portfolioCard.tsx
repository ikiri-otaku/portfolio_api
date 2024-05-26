import BookmarkButton from '@/app/_components/buttons/bookmarkButton';
import BaseImage from '@/app/_components/images/baseImage';
import PortfolioCardTechList from '@/app/_components/portfolioCard/portfolioCardTechList';
import PortfolioCardTitle from '@/app/_components/portfolioCard/portfolioCardTitle';
import PortfolioCardUser from '@/app/_components/portfolioCard/portfolioCardUser';
import { PortfolioData } from '@/app/_types/portfolio';
import Link from 'next/link';

export default function PortfolioCard({
  data,
  ranking,
}: {
  data: PortfolioData;
  ranking?: boolean;
}) {
  const userIcon = data.userIcon ? data.userIcon : '/user/user-default-icon.png';
  return (
    <div className="shadow-card rounded-md bg-white">
      <Link href={`/`} className="flex flex-col gap-y-3.5 p-6">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-x-1.5">
            {ranking && (
              <BaseImage src="/ranking/first-place-icon.svg" width={24} height={24} alt="" />
            )}
            <PortfolioCardTitle className="text-2xl">{data.name}</PortfolioCardTitle>
          </div>
          <BookmarkButton />
        </div>
        <div className="flex items-center justify-between gap-x-4">
          <ul className="flex flex-wrap gap-2">
            {data.tech.map((t: string) => (
              <PortfolioCardTechList tech={t} key={t} />
            ))}
          </ul>
          <PortfolioCardUser userIcon={userIcon} user={data.user} />
        </div>
        <div>{data.url}</div>
      </Link>
    </div>
  );
}
