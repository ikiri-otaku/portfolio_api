import { PutObjectCommand, S3Client } from "@aws-sdk/client-s3";

const s3Client = new S3Client({})

export async function POST(req: Request) {
  const {key, contentType, content} = await req.json();
  const bucket = process.env.AWS_BUCKET_NAME;

  if (!key) return new Response(JSON.stringify({ error: 'オブジェクトキーが指定されていません' }), { status: 500 });

  const command = new PutObjectCommand({
    Bucket: bucket,
    Key: key,
    ContentType: contentType,
    Body: Buffer.from(content, 'base64')
  });

  try {
    const response = await s3Client.send(command);
    console.log(response);
    return new Response('Success!', {status: 200});
  } catch (error) {
    console.error(error);
    return new Response('Failed', {status: 500});
  }
}
