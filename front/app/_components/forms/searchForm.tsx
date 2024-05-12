import { ArrowRightIcon } from "@/app/_components/icons/arrowRightIcon";
import { SearchIcon } from "@/app/_components/icons/searchIcon";
import { TextInput } from "@mantine/core";
import classes from "./searchForm.module.css";

export default function SearchForm() {
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
        <button className="flex justify-center items-center w-8 h-8 bg-main relative rounded-full">
          <ArrowRightIcon width="18px" height="18px" fill="#CED4DA" />
        </button>
      }
      classNames={classes}
    />
  );
}
