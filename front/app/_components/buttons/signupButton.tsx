import Link from "next/link";

export default function SignupButton() {
  return (
    <div className="h-10 rounded-full bg-main">
      <Link
        href="/signup"
        className="h-full flex justify-center items-center font-bold px-5 text-sm text-bgWhite"
      >
        新規登録
      </Link>
    </div>
  );
}
