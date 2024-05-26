import BaseImage from '@/app/_components/images/baseImage';

type Props = {
  userIcon: string;
  user: string;
};

export default function PortfolioCardUser({ userIcon, user }: Props) {
  return (
    <>
      <div className="flex items-center gap-x-2">
        <BaseImage src={userIcon} width={24} height={24} alt="" />
        <p className="text-sm font-medium text-textGray">{user}</p>
      </div>
    </>
  );
}
