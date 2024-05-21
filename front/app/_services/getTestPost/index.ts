import { handleFailed, handleSucceed } from "@/app/_services";
import { TestPost } from "@/app/_types/testPost";

export async function getTestPost(): Promise<TestPost[]>{
  return fetch(`${process.env.NEXT_PUBLIC_API_URL}/test_posts`, {
    headers: {
      "Content-Type": "application/json",
    }
  })
  .then(handleSucceed)
  .catch(handleFailed)
}
