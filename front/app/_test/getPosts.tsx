'use server'

interface Post {
  title: string;
}

export async function getPosts() {
  const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/posts`);
  const posts: Post[] = await response.json();

  return posts.map(post => post.title);
}
