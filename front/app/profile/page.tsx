'use client';
import { MantineProvider, Card, Image, Text, SimpleGrid } from '@mantine/core';
import theme from '../_constants/customTheme';
import Share from '../_components/buttons/share';
import EditProfile from '../_components/buttons/editProfile';
import TechHistoryBadge from '../_components/badges/techHistoryBadge';
import { LocationIcon } from '../_components/icons/locationIcon';
import { CompanyIcon } from '../_components/icons/companyIcon';
import { UserIcon } from '../_components/icons/userIcon';
import { GithubIcon } from '../_components/icons/githubIcon';
import { ZennIcon } from '../_components/icons/zennIcon';
import { XIcon } from '../_components/icons/xIcon';
import { QiitaIcon } from '../_components/icons/qiitaIcon';
import { AtcoderIcon } from '../_components/icons/atcoderIcon';
import { RubyIcon } from '../_components/techIcons/rubyIcon';

export default function Home() {
  return (
    <MantineProvider theme={theme}>
      <section className="container mx-auto pb-24 px-48">
        <div className="flex flex-col pt-[86px]">
          <div className="flex justify-between">
            <div className="flex space-x-4">
              <div className="flex items-center space-x-4">
                <UserIcon width="120" height="120" />
              </div>
              <div className="space-y-2">
                <h1 className="text-3xl font-bold">イキリ オタク</h1>
                <div className="flex space-x-2">
                  <GithubIcon width="40" height="40" />
                  <XIcon width="40" height="40" />
                  <ZennIcon width="40" height="40" />
                  <QiitaIcon width="40" height="40" />
                  <AtcoderIcon width="40" height="40" />
                </div>
                <div className="flex space-x-4">
                  <div className="flex items-center space-x-1">
                    <LocationIcon width="20" height="20" />
                    <span>居住地</span>
                  </div>
                  <div className="flex items-center space-x-1">
                    <CompanyIcon width="20" height="20" />
                    <span>company name</span>
                  </div>
                </div>
              </div>
            </div>
            <div className="flex space-x-2">
              <Share />
              <EditProfile />
            </div>
          </div>
        </div>
        <p className="mb-[34px] mt-6 text-base font-bold leading-snug text-textGray">
          自己紹介テキストここに箇条書きのためで考えています。とにかく今日を話題に皆様色々な観点がありますが
          でもまあすぐは反省がしぶらくあかり、まだに取りなないないなけど、根性を持ちますものはどうしても当時からしっててました。
          他のキャルシン著者。根性を持ちふくじん個体はすずにすますったの主要部分がきてます。その他もうは世界的多くの部位をつなげて。
          同意と心もの多くです。私を皆にご著作として彼ら実践できる表現をどうようにとしてもご表現忘れらないなは、ついに同期にもすぐになってきて多くなもののしあん。
        </p>
        <h1 className="text-2xl text-left font-bold my-4">技術歴</h1>
        <TechHistoryBadge
          icon={<RubyIcon width="20" height="20" />}
          label="Ruby"
          duration="1年3ヶ月"
        />
        <h1 className="text-2xl text-left font-bold my-4">アプリ</h1>
        <SimpleGrid cols={3} spacing="lg">
          <Card shadow="sm" padding="lg" radius="md" withBorder>
            <Text fw={700} size="xl">
              アプリタイトルアプリタイトル
            </Text>
            <div className="flex space-x-2">
              <Image
                src="/ruby.png"
                alt="BUZZ BASE"
                style={{ width: '30px', height: '30px', objectFit: 'contain' }}
              />
              <Image
                src="/rails.png"
                alt="BUZZ BASE"
                style={{ width: '30px', height: '30px', objectFit: 'contain' }}
              />
            </div>
            <Card.Section p="sm">
              <Image src="/apptest.png" height={160} radius="xl" alt="BUZZ BASE" />
            </Card.Section>
          </Card>
          <Card shadow="sm" padding="lg" radius="md" withBorder>
            <Text fw={700} size="xl">
              アプリタイトルアプリタイトル
            </Text>
            <div className="flex space-x-2">
              <Image
                src="/ruby.png"
                alt="BUZZ BASE"
                style={{ width: '30px', height: '30px', objectFit: 'contain' }}
              />
              <Image
                src="/rails.png"
                alt="BUZZ BASE"
                style={{ width: '30px', height: '30px', objectFit: 'contain' }}
              />
            </div>
            <Card.Section p="sm">
              <Image src="/apptest.png" height={160} radius="xl" alt="BUZZ BASE" />
            </Card.Section>
          </Card>
          <Card shadow="sm" padding="lg" radius="md" withBorder>
            <Text fw={700} size="xl">
              アプリタイトルアプリタイトル
            </Text>
            <div className="flex space-x-2">
              <Image
                src="/ruby.png"
                alt="BUZZ BASE"
                style={{ width: '30px', height: '30px', objectFit: 'contain' }}
              />
              <Image
                src="/rails.png"
                alt="BUZZ BASE"
                style={{ width: '30px', height: '30px', objectFit: 'contain' }}
              />
            </div>
            <Card.Section p="sm">
              <Image src="/apptest.png" height={160} radius="xl" alt="BUZZ BASE" />
            </Card.Section>
          </Card>
        </SimpleGrid>
        <h1 className="text-2xl text-left font-bold mt-12 mb-4">記事</h1>
        <SimpleGrid cols={3} spacing="lg">
          <Card shadow="sm" padding="lg" radius="md" withBorder>
            <Card.Section p="sm">
              <Image src="/test.jpg" height={160} alt="BUZZ BASE" />
            </Card.Section>
            <Text fw={700} size="xl">
              記事タイトル記事タイトル記事タイトル
            </Text>
          </Card>
          <Card shadow="sm" padding="lg" radius="md" withBorder>
            <Card.Section p="sm">
              <Image src="/test.jpg" height={160} alt="BUZZ BASE" />
            </Card.Section>
            <Text fw={700} size="xl">
              記事タイトル記事タイトル記事タイトル
            </Text>
          </Card>
          <Card shadow="sm" padding="lg" radius="md" withBorder>
            <Card.Section p="sm">
              <Image src="/test.jpg" height={160} alt="BUZZ BASE" />
            </Card.Section>
            <Text fw={700} size="xl">
              記事タイトル記事タイトル記事タイトル
            </Text>
          </Card>
        </SimpleGrid>
      </section>
    </MantineProvider>
  );
}
