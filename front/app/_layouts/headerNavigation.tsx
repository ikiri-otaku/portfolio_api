import { navigation } from '@/app/_constants/navigationLink';
import Link from 'next/link';

export default function HeaderNavigation() {
  return (
    <nav>
      <ul className="flex items-center gap-x-6">
        {navigation.map((item, index) => (
          <li key={index}>
            <Link href={item.href} className="flex items-center gap-x-2 font-bold text-textBlack">
              <item.icon width="20px" height="20px" stroke="#171717" />
              {item.name}
            </Link>
          </li>
        ))}
      </ul>
    </nav>
  );
}
