import Link from 'next/link';
import Submission from '@/app/_components/buttons/submission';
import TestPostUI from '@/app/_services/testPost';

export default function Home() {
  return (
    <div>
      <TestPostUI />
      <Link href="/test_s3">S3 Test Page⇒</Link>

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
    </div>
  );
}
