import { PortfolioId } from "../_types/like";

const API_BASE_URL = '/auth/portfolios';

export async function addLike(portfolioId: PortfolioId) {
  try {
    const response = await fetch(`${API_BASE_URL}/${portfolioId}/likes`, {
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
    const response = await fetch(`${API_BASE_URL}/${portfolioId}/likes`,{
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
