import { Portfolio } from "@/app/_types/portfolios";

export type PortfolioSearchResponse = {
  success: boolean;
  portfolios: Portfolio[]
}

export async function GET(req: Request): Promise<Response> {
  try {
    const url = new URL(req.url);
    const query = url.searchParams.get('query') || '';

    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/portfolios/search?query=${encodeURIComponent(query)}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
      cache: 'no-cache',
    });

    const res = await response.json();
    const result: PortfolioSearchResponse = { success: true, portfolios: res };

    return new Response(JSON.stringify(result), {
      status: 200,
      headers: {
        'Content-Type': 'application/json',
      },
    })

  } catch (error: any) {
    console.error(error);
    return new Response(`Failed: ${error.message}`, { status: 500 });
  }
}
