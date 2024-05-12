import Link from "next/link";

export default function SigninButton() {
  return (
    <div className="h-10 border-2 border-main rounded-full ">
      <Link
        href="/signin"
        className="h-full flex justify-center items-center font-bold text-main px-5 text-sm"
      >
        ログイン
      </Link>
    </div>
  );
}
