'use client';

import { useRouter } from "next/navigation";
import { useState } from "react";
import { TextInput } from "@mantine/core";

import { ArrowRightIcon } from "@/app/_components/icons/arrowRightIcon";
import { SearchIcon } from "@/app/_components/icons/searchIcon";
import classes from "./searchForm.module.css";

export default function SearchInput() {
  const router = useRouter();
  const [searchQuery, setSearchQuery] = useState('');

  const handleSearch = () => {
    router.push(`/portfolios?query=${encodeURIComponent(searchQuery)}`);
  };

  return (
    <TextInput
      radius="xl"
      size="md"
      placeholder="Search"
      bg="white.3"
      rightSectionWidth={42}
      leftSectionPointerEvents="none"
      leftSection={<SearchIcon width="18px" height="18px" stroke="#CED4DA" />}
      rightSection={
        <button onClick={handleSearch} className="flex justify-center items-center w-8 h-8 bg-main relative rounded-full">
          <ArrowRightIcon width="18px" height="18px" fill="#CED4DA" />
        </button>
      }
      value={searchQuery}
      onChange={(e) => setSearchQuery(e.currentTarget.value)}
      classNames={classes}
    />
  );
}
