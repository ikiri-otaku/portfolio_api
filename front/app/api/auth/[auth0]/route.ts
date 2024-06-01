import { handleAuth, handleLogin } from '@auth0/nextjs-auth0';

export const GET = handleAuth({
  login: handleLogin({
    authorizationParams: {
      connection: "github", // GitHub Login Only
      prompt: "login", // always show the login form regardless of session status
    },
    returnTo: "/",
  }),
  // logout: handleLogout({ returnTo: 'https://example.com' }),
});
