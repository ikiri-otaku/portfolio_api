import { getTestPost } from "@/app/_services/getTestPost";
import { TestPost } from "@/app/_types/testPost";

export default async function TestPostUI() {
  const posts: TestPost[] = await getTestPost()
  return (
    <div>
      <h1>Test Posts</h1>
      <ul>
          {posts.map((post, index) => (
              <li key={index}>
                <p>{post.title}</p>
              </li>
          ))}
      </ul>
    </div>
  );
}
