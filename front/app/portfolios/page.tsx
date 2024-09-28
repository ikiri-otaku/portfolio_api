import { Flex, Text, Title } from "@mantine/core";

import { PortfolioSearchResponse } from "@/app/api/portfolios/search/route";

export default async function PortfoliosPage({ searchParams  }: { searchParams : { query?: string } }) {
  const res = await fetch(
    `${process.env.NEXT_PUBLIC_FRONT_URL}/api/portfolios/search?query=${encodeURIComponent(searchParams.query || '')}`,
    { cache: 'no-cache' },
  );
  const data: PortfolioSearchResponse = await res.json();

  return (
    <div>
      <Title order={1}>アプリ一覧</Title>

      {/* TODO: sort */}
      <Flex gap="md">
        <Text>投稿日</Text>
        <Text>いいね数</Text>
        <Text>View数</Text>
      </Flex>

      {data.portfolios.length === 0 ? (
        <Text>検索結果がありません</Text>
      ) : (
        /* TODO: アプリカード */
        data.portfolios.map((portfolio) => (
          <Flex key={portfolio.id} gap="md">
            <Text>{portfolio.name}</Text>
            <Text>{portfolio.url}</Text>
            <Text>{portfolio.introduction}</Text>
          </Flex>
        ))
      )}
    </div>
  )
}
