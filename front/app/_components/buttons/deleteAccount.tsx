import { Group, Text, Accordion } from '@mantine/core';

export default function DeleteAccount() {
  return (
    <Group wrap="nowrap">
      <Accordion chevronPosition="right" variant="contained" style={{ width: '100%', maxWidth: '500px' }}>
        <Accordion.Item value="hoge">
          <Accordion.Control>
            <div style={{ display: 'flex', alignItems: 'center' }}>
              <Text>アカウント削除について</Text>
            </div>
          </Accordion.Control>
          <Accordion.Panel>
            <Text size="sm">ホゲホゲホゲホゲ</Text>
          </Accordion.Panel>
        </Accordion.Item>
      </Accordion>
    </Group>
  );
}
