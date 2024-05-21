interface Post {
  title: string;
}

async function getTestPost() {
  const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/test_posts`);
  const posts: Post[] = await response.json();
  return posts.map(post => post.title);
}

export default async function TestPostUI() {
  const titles = await getTestPost()
  
  return (
    <div>
      <h1>Post Titles</h1>
      <ul>
          {titles.map((title, index) => (
              <li key={index}>{title}</li>
          ))}
      </ul>
    </div>
  );
}
