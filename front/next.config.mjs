/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'ikiri-otaku.s3.amazonaws.com',
      },
      {
        protocol: 'https',
        hostname: 'ikiri-otaku.s3.us-east-1.amazonaws.com',
      },
    ],
  }
};

export default nextConfig;
