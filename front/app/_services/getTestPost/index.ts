import { handleFailed, handleSucceed, path } from "@/app/_services";
import { TestPost } from "@/app/_types/testPost";

export async function getTestPost(): Promise<TestPost[]>{
  return fetch(path('/test_posts'), {
    headers: {
      "Content-Type": "application/json",
    }
  })
  .then(handleSucceed)
  .catch(handleFailed)
}
