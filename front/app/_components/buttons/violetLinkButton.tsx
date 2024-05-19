import { Button } from '@mantine/core';

interface Props {
  variant?: 'filled' | 'outline';
  label: string;
  href: string;
}

export default function VioletLinkButton({ variant = 'filled', label, ...props }: Props) {
  return (
    <Button
      component='a'
      color="violet.7" size="sm" radius="xl"
      variant={variant}
      {...props}
    >
      {label}
    </Button>
  );
}
