'use client'

import { Button } from "@mantine/core";
import { useRef, useState } from "react";

export default function TestFileUploader() {
  const inputRef = useRef<HTMLInputElement | null>(null);
  const [message, setMessage] = useState('');

  async function handleUpload() {
    if (!inputRef.current || !inputRef.current.files || inputRef.current.files.length === 0) {
      alert('Please select a file to upload.');
      return;
    }

    const file = inputRef.current.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = async () => {
      const base64Content = reader.result?.toString().split(',')[1];

      if (!base64Content) {
        setMessage('Failed to read file content.');
        return;
      }

      const response = await fetch('/api/s3-put-object', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          key: `test/${file.name}`,
          contentType: file.type,
          content: base64Content,
        }),
      });

      if (response.ok) {
        setMessage('File uploaded successfully!');
        if(inputRef.current) inputRef.current.value = '';
      } else {
        setMessage(`Upload failed: ${response.status}`);
        return
      }
    }
  }

  return (
    <div>
      S3のtestフォルダにアップロードします<br />
      <input type="file" ref={inputRef} /><br />
      <Button onClick={handleUpload}>Upload</Button><br />
      {message && <p>{message}</p>}
    </div>
  );
}
