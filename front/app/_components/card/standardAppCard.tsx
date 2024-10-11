import { Card, Image, Text, Badge, Button, Group, Box } from '@mantine/core';
import { BookmarkIcon } from '@/app/_components/icons/bookmarkIcon';
import UserButton from '@/app/_components/buttons/userButton';

export default function StandardAppCard() {
  return (
    <Card shadow="sm" padding="sm" radius="md" withBorder >
      <Group justify="space-between" style={{ width: '100%' }}>
        <Text fw={700} size="lg">
          アプリタイトル
        </Text>
        <div style={{ marginLeft: 'auto' }}>
          <BookmarkIcon width='18px' height='18px' />
        </div>
      </Group>

      <Group mb={30}>
        <div>
          icon表示するとこ
        </div>
        <div style={{ marginLeft: 'auto' }}>
          <UserButton />  
        </div>
      </Group>

      <Group className='static'>
        {/* publicフォルダ内のsample表示 */}
        <Image
          h={200}
          w="auto"
          src="/buzz-ogp 2.jpg" 
          alt="Sample" 
        />

        <Box 
          bg="#f7f7f7"
          my="lg"
          className='absolute bottom-0 right-6 h-6 w-24 rounded text-center'
        >
          <Text size="xs" >♡ 1105 ☆ 2016</Text>
        </Box>
      </Group>

    </Card>
  );
}
