export const host = process.env.API_URL

export const path = (path?: string) => `${host}${path}`

export class FetchError extends Error {
  status: number;
  constructor(message: string, status: number) {
    super(message)
    this.status = status
  }
}

export const handleSucceed = async (res: Response) => {
  const data = await res.json()
  if (!res.ok) {
    throw new FetchError(res.statusText, res.status);
  }
  return data;
}

export const handleFailed = (err: unknown) => {
  if (err instanceof FetchError) {
    console.warn(err.message)
  }
}
