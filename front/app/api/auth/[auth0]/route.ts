import { AfterCallback, handleAuth, handleCallback, handleLogin } from '@auth0/nextjs-auth0';
import { NextApiRequest } from 'next';

const afterCallback: AfterCallback = async (_req: NextApiRequest, session: any, _state: { [key: string]: any }) => {
  // console.log('----- start callback')
  const { user, accessToken } = session;

  const data = {
    user: {
      'name': user.name,
      'github_username': user.nickname,
      'auth0_id': user.sub,
    },
  }

  const res = await fetch(
    `${process.env.NEXT_PUBLIC_API_URL}/auth/user`,
    {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    },
  );
  // console.log('----- res')
  // console.log(res.ok)
  return session;
};

export const GET = handleAuth({
  login: handleLogin({
    authorizationParams: {
      connection: "github", // GitHub Login Only
      prompt: "login", // always show the login form regardless of session status
    },
  }),
  callback: handleCallback({ afterCallback }),
  // logout: handleLogout({ returnTo: '/profile' }),
});
