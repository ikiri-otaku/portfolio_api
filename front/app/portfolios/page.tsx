import { Flex, Text, Title } from "@mantine/core";

import { PortfolioSearchResponse } from "@/app/api/portfolios/search/route";
import Picture from "@/app/_components/images/picture";

export default async function PortfoliosPage({ searchParams }: { searchParams: { query?: string } }) {
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
            {portfolio.pictures.length > 0 ? (
              <Picture s3Key={portfolio.pictures[0]} width={100} height={100} />
            ) : (
              // TODO 画像がないとき用の画像
              <p>No image</p>
            )}
          </Flex>
        ))
      )}
    </div>
  )
}
