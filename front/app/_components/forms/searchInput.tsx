import { ArrowRightIcon } from '@/app/_components/icons/arrowRightIcon';
import { SearchIcon } from '@/app/_components/icons/searchIcon';
import { TextInput } from '@mantine/core';
import classes from './searchForm.module.css';

export default function SearchInput() {
  return (
    <TextInput
      radius="xl"
      size="md"
      placeholder="Search"
      bg="white.2"
      rightSectionWidth={42}
      leftSectionPointerEvents="none"
      leftSection={<SearchIcon width="18px" height="18px" stroke="#CED4DA" />}
      rightSection={
        <button className="relative flex h-8 w-8 items-center justify-center rounded-full bg-main">
          <ArrowRightIcon width="18px" height="18px" fill="#CED4DA" />
        </button>
      }
      classNames={{ input: classes.input }}
    />
  );
}
