import { PortfolioId } from "../_types/like";

export async function addLike(portfolioId: PortfolioId) {
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/auth/portfolios/1/likes`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
    });

    if(! response.ok) {
      const { message } = await response.json();
      throw new Error(message);
    }
    return response.json();
  } catch (error) {
    console.error('Failed to add like:', error);
    throw error;
  }
}

export async function removeLike(portfolioId: PortfolioId) {
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/auth/portfolios/${portfolioId}/likes`,{
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
      },
    });
    if (!response.ok) {
      const { message } = await response.json();
      throw new Error(message); 
    }
    return response.json();
  } catch (error) {
    console.error('Failed to remove like:', error);
    throw error;
  }
}
