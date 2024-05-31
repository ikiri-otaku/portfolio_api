import { MantineProvider } from '@mantine/core';
import List from './_components/buttons/list';
import Submission from './_components/buttons/submission';
import theme from './_constants/customTheme';
import AuthButtons from './_layouts/nav/auth_buttons';
import TestPostUI from '@/app/_components/test/testPosts';

export default function Home() {
  return (
    <MantineProvider theme={theme}>
      <AuthButtons />
      <List />
      <TestPostUI />
      <section className="flex flex-col items-center justify-center pb-14 pt-[86px]">
        <h2 className="text-center text-2xl font-black leading-snug text-textBlack">
          キャッチコピーキャッチコピー
          <strong className="font-black text-main">キャッチコピー</strong>
          キャッチコピー
          <br />
          キャッチコピーキャッチコピー キャッチコピー
        </h2>
        <p className="mb-[34px] mt-6 text-base font-bold leading-snug text-textGray">
          キャッチコピーキャッチコピーキャッチコピーキャッチコピキャッチコピーキャッチコピー
        </p>
        <Submission />
      </section>
    </MantineProvider>
  );
}
