import React, { lazy } from 'react';

// project import
import MainLayout from 'layout/MainLayout';
import Loadable from 'component/Loadable';

const DashboardDefault = Loadable(lazy(() => import('views/Dashboard/Default')));
const Order = Loadable(lazy(() => import('views/Order')));


// ==============================|| MAIN ROUTES ||============================== //

const MainRoutes = {
  path: '/',
  element: <MainLayout />,
  children: [
    {path: '/',element: <DashboardDefault />},
    {path: '/dashboard/default',element: <DashboardDefault />},
    { path: '/order', element: <Order/> }

  ]
};

export default MainRoutes;
