import "server-only";

import { getAccessToken, getSession } from "@auth0/nextjs-auth0";

interface GetMessageParams {
  type: "public" | "protected" | "admin";
}

interface Message {
  text: string;
}

export const getTestAuthMessage = async ({
  type,
}: GetMessageParams): Promise<Message> => {
  const session = await getSession();

  if (!session) {
    return {
      text: "Requires authorization if you wanna see this text",
    };
  }

  const { accessToken } = await getAccessToken();

  if (!accessToken) {
    return {
      text: "Requires authorization if you wanna see this text",
    };
  }

  const res = await fetch(
    `${process.env.NEXT_PUBLIC_API_URL}/auth/test_messages/${type}`,
    {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    },
  );

  if (res.ok) {
    const json = await res.json();

    return {
      text: json,
    };
  }

  if (!res.ok) {
    const json = await res.json();

    return {
      text: json.message || res.statusText || "Unable to fetch",
    };
  }

  // console.log('----- res json')
  // const json = await res.json();
  // console.log(json)
  // return res.json();
};

export const getPublicMessage = async () => {
  return {
    text: "This is a public message!!"
  }
  // return getMessage({ type: "public" });
};

export const getProtectedMessage = async () => {
  return getTestAuthMessage({ type: "protected" });
};

export const getAdminMessage = async () => {
  return getTestAuthMessage({ type: "admin" });
};
