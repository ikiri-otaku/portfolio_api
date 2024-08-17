import { GetObjectCommand, S3Client } from "@aws-sdk/client-s3";
import { getSignedUrl } from "@aws-sdk/s3-request-presigner";

const s3Client = new S3Client({});

export async function GET(req: Request): Promise<Response> {
  const url = new URL(req.url);
  const key = url.searchParams.get('key');
  if(!key) return new Response('Missing key parameter', {status: 500});

  const command = new GetObjectCommand({
    Bucket: process.env.AWS_BUCKET_NAME,
    Key: key,
  });

  try {
    const url = await getSignedUrl(s3Client, command, { expiresIn: 3600 });
    return Response.json({ success: true, url });

  } catch (error: any) {
    console.error(error);
    return new Response(`Failed: ${error.message}`, {status: 500});
  }
}
