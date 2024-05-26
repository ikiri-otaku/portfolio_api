import PortfolioCard from '@/app/_components/portfolioCard/portfolioCard';
import PortfolioCardHorizontal from '@/app/_components/portfolioCard/portfolioCardHorizontal';

export default function PortfolioCards() {
  // TODO: Implement viewRankingData
  const viewRankingData = [
    {
      id: 1,
      user: 'テストユーザー1',
      userIcon: '/user/user-default-icon.png',
      name: 'テストアプリ1',
      url: 'https://buzzbase.jp/',
      tech: ['React', 'TypeScript', 'Ruby', 'Rails'],
    },
    {
      id: 2,
      user: 'テストユーザー2',
      userIcon: '/user/user-default-icon.png',
      name: 'テストアプリ2',
      url: 'https://buzzbase.jp/',
      tech: ['React', 'TypeScript', 'Ruby', 'Rails'],
    },
    {
      id: 3,
      user: 'テストユーザー3',
      userIcon: '/user/user-default-icon.png',
      name: 'テストアプリ3',
      url: 'https://buzzbase.jp/',
      tech: ['React', 'TypeScript', 'Ruby', 'Rails'],
    },
    {
      id: 4,
      user: 'テストユーザー4',
      userIcon: '/user/user-default-icon.png',
      name: 'テストアプリ4',
      url: 'https://buzzbase.jp/',
      tech: ['React', 'TypeScript', 'Ruby', 'Rails'],
    },
    {
      id: 5,
      user: 'テストユーザー5',
      userIcon: '/user/user-default-icon.png',
      name: 'テストアプリ5',
      url: 'https://buzzbase.jp/',
      tech: ['React', 'TypeScript', 'Ruby', 'Rails'],
    },
  ];
  return (
    <div className="grid grid-cols-[1fr_1fr] gap-6">
      {viewRankingData.map((data, index) =>
        index === 0 ? (
          <PortfolioCard key={data.id} data={data} ranking={true} />
        ) : (
          <PortfolioCardHorizontal key={data.id} />
        )
      )}
    </div>
  );
}
