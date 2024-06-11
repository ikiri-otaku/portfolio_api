import { MantineProvider } from '@mantine/core';
import theme from '../_constants/customTheme';
import Share from '../_components/buttons/share';
import EditProfile from '../_components/buttons/editProfile';
import { LocationIcon } from '../components/icons/locationIcon';
import { CompanyIcon } from '../components/icons/companyIcon';

export default function Home() {

  return (
    <MantineProvider theme={theme}>
      <Share />
      <EditProfile />
      <h1>イキリオタク</h1>
      <p>文章</p>
      <h1>アプリ</h1>
      <h1>記事</h1>
    </MantineProvider>
  );
}
