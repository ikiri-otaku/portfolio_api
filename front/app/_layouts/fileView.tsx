"use client";

import { useEffect, useState } from "react";
import { S3File } from "@/app/_types/s3";
import Image from "next/image";

interface TestFileViewProps {
  prefix: string
}

export default function TestFileView({prefix} : TestFileViewProps) {
  const [files, setFiles] = useState<S3File[]>([])
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const fetchFiles = async () => {
      try {
        const objectList = await fetch(`/api/s3-get-object?prefix=${encodeURIComponent(prefix)}`)
        const result = await objectList.json();
        if(!result.success) {
          setError(result.error);
          return;
        }

        const signedFiles = await Promise.all(
          result.files
          .filter((file: { key: string }) => /\.(jpg|jpeg|png)$/i.test(file.key))
          .map(async (file: {key: string}) => {
            const signedResponse = await fetch(`/api/s3-signed-url?key=${encodeURIComponent(file.key)}`);
            const signedResult = await signedResponse.json();
            if(!signedResult.success) {
              throw new Error(signedResult.error);
            }

            return { key: file.key, signedUrl: signedResult.url };
          })
        );

        setFiles(signedFiles);
      } catch(err) {
        setError(err instanceof Error ? err.message : String(err))
      }
    }

    fetchFiles();
  }, [prefix])

  if (error) return <div>Error: {error}</div>

  return (
    <div>
      <h3>S3 Files</h3>
      <ul>
        {files.map((file) => (
          <li key={file.key}>
            <Image src={file.signedUrl} alt={file.key} width={100} height={100} style={{ width: '100%', height: 'auto' }} />
          </li>
        ))}
      </ul>
    </div>
  )
}
