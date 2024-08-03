import { Badge } from '@mantine/core';

interface BadgeProps {
  icon: JSX.Element;
  label: string;
  duration: string;
}

export default function TechHistoryBadge({ icon, label, duration }: BadgeProps) {
  return (
    <Badge
      tt="none"
      size="lg"
      radius="xl"
      variant="outline"
      style={{ display: 'flex', alignItems: 'center', padding: '0.5rem 1rem', borderColor: '#DEDEDE', color: 'black' }}
    >
      <div style={{ display: 'flex', alignItems: 'center' }}>
        {icon}
        <span style={{ marginLeft: '0.5rem', fontWeight: 'bold' }}>{label}</span>
        <span style={{ marginLeft: '0.5rem', color: '#6e6e6e' }}> / {duration}</span>
      </div>
    </Badge>
  );
}
