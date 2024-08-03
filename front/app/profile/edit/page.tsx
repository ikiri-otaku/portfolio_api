'use client';
import { MantineProvider } from '@mantine/core';

import { UserIcon } from '@/app/_components/icons/userIcon';
import theme from '@/app/_constants/customTheme';
import SnsInput from '@/app/_components/forms/snsInput';
import PrefectureSelect from '@/app/_components/forms/prefectureInput';
import UserInput from '@/app/_components/forms/textArea';
import Tech from '@/app/_components/buttons/tech';
import Article from '@/app/_components/buttons/article';
import Keep from '@/app/_components/buttons/keep';
import { TrushIcon } from '@/app/_components/icons/trushIcon';
import DeleteAccount from '@/app/_components/buttons/deleteAccount';
import TechHistorySelect from '@/app/_components/forms/techHistoryInput';

export default function Home() {
  return (
    <MantineProvider theme={theme}>
      <h1 className="text-4xl text-left font-bold mt-16 ml-16">プロフィール編集</h1>
      <section className="container mx-auto pb-8 px-64">
        <div className='flex justify-start'>
          <div className="flex flex-col pt-[86px]">
            <div className="flex flex-col items-center">
              <UserIcon width="150" height="150" />
              <p className="font-bold" style={{ color: '#632BAD' }}>画像編集</p>
            </div>
          </div>
        </div>
        <h1 className="text-2xl text-left font-bold my-4">ユーザー名</h1>
        <SnsInput width={600} placeholder="ほげ 太郎" />
        <h1 className="text-2xl text-left font-bold my-4">自己紹介</h1>
        <UserInput width={1000} height={150} />
        <h1 className="text-2xl text-left font-bold my-4">会社名</h1>
        <SnsInput width={600} placeholder="株式会社〇〇" />
        <h1 className="text-2xl text-left font-bold my-4">居住地</h1>
        <PrefectureSelect width={300} />
        <h1 className="text-2xl text-left font-bold my-4">GitHub</h1>
        <SnsInput width={1000} placeholder="hoge" />
        <h1 className="text-2xl text-left font-bold my-4">X</h1>
        <SnsInput width={1000} placeholder="hoge" />
        <h1 className="text-2xl text-left font-bold my-4">Zenn</h1>
        <SnsInput width={1000} placeholder="hoge" />
        <h1 className="text-2xl text-left font-bold my-4">Qiita</h1>
        <SnsInput width={1000} placeholder="hoge" />
        <h1 className="text-2xl text-left font-bold my-4">AtCoder</h1>
        <SnsInput width={1000} placeholder="hoge" />
        <h1 className="text-2xl text-left font-bold my-4">技術歴</h1>
        <div className="flex items-end space-x-2">
          <div>
            <SnsInput width={250} placeholder="Ruby" />
          </div>
          <div>
            <TechHistorySelect width={160} />
          </div>
          <div>
            <TrushIcon width="45" height="45" />
          </div>
        </div>
        <div className="flex justify-center my-4">
          <Tech />
        </div>
        <h1 className="text-2xl text-left font-bold my-4">記事</h1>
        <div className="flex items-end space-x-2">
          <SnsInput width={1000} placeholder="https://qiita.com/hoge/items/123456789abc" />
          <TrushIcon width="45" height="45" />
        </div>
        <div className="flex justify-end my-4">
          <Article />
        </div>
        <div className="flex justify-center my-2">
          <Keep />
        </div>
        <div className="my-24">
          <DeleteAccount />
        </div>
      </section>
    </MantineProvider>
  );
}
