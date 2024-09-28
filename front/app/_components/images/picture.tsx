'use client';

import Image from "next/image";
import { useEffect, useState } from "react";

interface Props {
  s3Key: string;
  width: number;
  height: number;
}

export default function Picture({ s3Key, width, height }: Props) {
  const [signedUrl, setSignedUrl] = useState('');
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const fetchSignedUrl = async () => {
      try {
        const signedResponse = await fetch(`/api/s3-signed-url?key=${encodeURIComponent(s3Key)}`);
        const signedResult = await signedResponse.json();
        setSignedUrl(signedResult.url);
      } catch (error) {
        setError(error instanceof Error ? error.message : String(error));
      }
    };

    fetchSignedUrl();
  }, [s3Key]);

  if (error) return <div>Error: {error}</div>

  return (
    <Image src={signedUrl} alt={s3Key} width={width} height={height} />
  );
}
