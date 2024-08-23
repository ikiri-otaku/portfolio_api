// LikeButton.tsx
'use client'

import { useState } from "react"
import { LikeOffIcon } from "../icons/likeOff"
import { LikeOnIcon } from "../icons/likeOn"
import { addLike, removeLike } from "@/app/_services/likes"
import { PortfolioId } from "@/app/_types/like"

interface LikeButtonProps {
  portfolioId: PortfolioId;
}

export default function LikeButton({ portfolioId }: LikeButtonProps) {
  const [liked, setLiked] = useState(false);
  const [loading, setLoading] = useState(false);

  async function handleClick() {
    setLoading(true);

    try {
      if (liked) {
        await removeLike(portfolioId);
        setLiked(false);
      } else {
        await addLike(portfolioId);
        setLiked(true);
      }
    } catch (error) {
      console.error('Failed to toggle like:', error);
    } finally {
      setLoading(false);
    }

    console.log("like count updated");
  }

  return (
    <>
      <button onClick={handleClick} disabled={loading}>
        {liked ? <LikeOnIcon /> : <LikeOffIcon />}
      </button>
    </>
  );
}