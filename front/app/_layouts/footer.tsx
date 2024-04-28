import { Container, Flex, Text } from "@mantine/core";
import { IoIosArrowDropup } from "react-icons/io";
import styles from "./layouts.module.css"

export default function Footer() {
  return (
    <footer>
      <Container fluid p="xl" bg="violet" c="white">
        <Flex
          direction={{ base: 'row', sm: 'column' }}
        >
          <Flex
            direction={{ base: 'column', sm: 'row' }}
            gap={{ base: 0, sm: 'lg' }}
            justify='flex-start'
            align='flex-start'
          >
            {/* TODO: image */}
            <div>LOGO</div>
            <div className={styles.separate_horizontal_over_sm}>
              {/* TODO: Link */}
              <Text size="sm">アプリ投稿</Text>
              <Text size="sm">アプリ一覧</Text>
              <Text size="sm">使い方</Text>
            </div>
            <div>
              <Text size="sm">お問い合わせ</Text>
              <Text size="sm">運営</Text>
            </div>
          </Flex>
          <div className={styles.right_under}>
            {/* TODO: scroll up */}
            <IoIosArrowDropup />
          </div>
        </Flex>

        <hr />

        <Flex
          direction={{ base: 'column', sm: 'row' }}
          gap={{ base: 0, sm: 'lg' }}
          justify='flex-end'
          align='flex-start'
          mt="xl"
        >
          <div>
            {/* TODO: app name */}
            <Text size="xs">© 2024 domain.com</Text>
          </div>
          <div className={styles.separate_horizontal_over_sm}>
            <Text size="xs">プライバシーポリシー</Text>
          </div>
          <div>
            <Text size="xs">利用規約</Text>
          </div>
        </Flex>
      </Container>
    </footer>
  );
}
