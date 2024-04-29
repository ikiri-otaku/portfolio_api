'use client'

import { ActionIcon } from '@mantine/core';
import { IoIosArrowDropup } from 'react-icons/io';

export default function ScrollToTopButton() {
  return (
    <ActionIcon
      variant="transparent" color="white" aria-label="Scroll to top"
      onClick={() => window.scrollTo({ top: 0, behavior: "smooth" })}
    >
      <IoIosArrowDropup />
    </ActionIcon>
  );
}
