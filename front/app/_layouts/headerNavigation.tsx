import { DesktopIcon } from "@/app/_components/icons/desktopIcon";
import { HomeIcon } from "@/app/_components/icons/homeIcon";
import { PlusIcon } from "@/app/_components/icons/plusIcon";
import Link from "next/link";

export default function HeaderNavigation() {
  const navigation = [
    {
      name: "トップ",
      href: "/",
      icon: HomeIcon,
    },
    {
      name: "アプリ投稿",
      // TODO: Link設定
      href: "/",
      icon: PlusIcon,
    },
    {
      name: "アプリ一覧",
      // TODO: Link設定
      href: "/",
      icon: DesktopIcon,
    },
  ];

  return (
    <nav>
      <ul className="flex items-center gap-x-6">
        {navigation.map((item, index) => (
          <li key={index}>
            <Link href={item.href} className="flex items-center gap-x-2 font-bold">
              <item.icon width="20px" height="20px" stroke="#171717" />
              {item.name}
            </Link>
          </li>
        ))}
      </ul>
    </nav>
  );
}
