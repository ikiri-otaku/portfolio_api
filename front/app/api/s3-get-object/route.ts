import { ListObjectsV2Command, ListObjectsV2CommandOutput, S3Client } from "@aws-sdk/client-s3";

const s3Client = new S3Client({})

export async function GET(req: Request): Promise<Response> {
  const url = new URL(req.url);
  const prefix = url.searchParams.get('prefix') || '';
  const bucket = process.env.AWS_BUCKET_NAME;

  const command = new ListObjectsV2Command({
    Bucket: bucket,
    Prefix: prefix,
    Delimiter: "/",
  });

  try {
    // https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/client/s3/command/ListObjectsV2Command/
    const response: ListObjectsV2CommandOutput = await s3Client.send(command);

    const files = (response.Contents || []).map((file) => ({
      key: file.Key!,
    }))
    return Response.json({ success: true, files })

  } catch (error: any) {
    console.error(error);
    return new Response(`Failed: ${error.message}`, {status: 500});
  }
}
