import SigninButton from "@/app/_components/buttons/signinButton";
import SignupButton from "@/app/_components/buttons/signupButton";
import SearchForm from "@/app/_components/forms/searchForm";
import HeaderNavigation from "@/app/_layouts/headerNavigation";
import { Container, Flex } from "@mantine/core";
import Link from "next/link";

export default function Header() {
  return (
    <header className="fixed top-0 left-0 w-full z-50">
      <Container fluid h="80px" bg="white.2" px="54px">
        <Flex align="center" h="100%">
          <Flex align="center" columnGap="24px">
            {/* TODO: image */}
            <div className="text-3xl font-bold">
              <Link href="/">LOGO</Link>
            </div>
            <SearchForm />
          </Flex>
          <Flex align="center" ml="auto" gap="24px">
            <HeaderNavigation />
            <Flex align="center" gap="18px">
              <SigninButton />
              <SignupButton />
            </Flex>
          </Flex>
        </Flex>
      </Container>
    </header>
  );
}
