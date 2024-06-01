"use client";

import VioletLinkButton from "@/app/_components/buttons/violetLinkButton";
import { useUser } from "@auth0/nextjs-auth0/client";

export default function AuthButtons() {
  const { user, isLoading } = useUser();

  if (isLoading) {
    return (<></>) // TODO: ローディング中の表示
  }

  return (
    <>
      {user && (
        <VioletLinkButton variant='outline' label='ログアウト' href='/api/auth/logout' />
      )}
      {!user && (
        <VioletLinkButton variant='outline' label='ログイン' href='/api/auth/login' />
      )}
    </>
  );
}
