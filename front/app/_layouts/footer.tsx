import { Container, Divider, Flex, Text } from "@mantine/core";
import { IoIosArrowDropup } from "react-icons/io";
import styles from "./layouts.module.css"
import ScrollToTopButton from "../_components/buttons/scrollToTopButton";

export default function Footer() {
  return (
    <footer>
      <Container fluid pt="60px" pl="60px" pr="60px" pb="32px" bg="violet.7" c="white">
        <Flex
          direction={{ base: 'row', sm: 'column' }}
        >
          <Flex
            direction={{ base: 'column', sm: 'row' }}
            gap={{ base: 0, sm: 'lg' }}
            justify='flex-start'
            align='flex-start'
            mb="48px"
          >
            {/* TODO: image */}
            <div className="text-4xl leading-10">LOGO</div>
            <div className={`${styles.separate_horizontal_over_sm} grid gap-y-6 mr-28 mt-4`}>
              {/* TODO: Link */}
              <Text size="base">アプリ投稿</Text>
              <Text size="base">アプリ一覧</Text>
              <Text size="base">使い方</Text>
            </div>
            <div className="grid gap-y-6 mr-[12%] mt-4">
              <Text size="base">お問い合わせ</Text>
              <Text size="base">運営</Text>
            </div>
          </Flex>
          <div className={styles.right_under}>
            <ScrollToTopButton />
          </div>
        </Flex>

        <Divider my="sm" mt="16px" mb="60px" />

        <Flex
          direction={{ base: 'column', sm: 'row' }}
          gap={{ base: 0, sm: 'lg' }}
          justify='flex-end'
          align='flex-start'
          mt="xl"
        >
          <div>
            {/* TODO: app name */}
            <Text size="12px">© 2024 domain.com</Text>
          </div>
          <div className={styles.separate_horizontal_over_sm}>
            <Text size="14px">プライバシーポリシー</Text>
          </div>
          <div className="ml-6">
            <Text size="14px">利用規約</Text>
          </div>
        </Flex>
      </Container>
    </footer>
  );
}
