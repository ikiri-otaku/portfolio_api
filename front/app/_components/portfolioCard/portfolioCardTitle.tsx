import { cn } from '@/app/lib/utils';

type Props = {
  children: React.ReactNode;
  className?: string;
};

export default function PortfolioCardTitle({ children, className }: Props) {
  return (
    <>
      <div className="flex items-center gap-x-1.5">
        <h4 className={cn('text-xl font-bold text-textBlack', className)}>{children}</h4>
      </div>
    </>
  );
}
