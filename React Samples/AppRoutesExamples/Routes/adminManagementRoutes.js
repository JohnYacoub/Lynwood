import { lazy } from "react";

const Routes = [
  {
    path: "/admin/faqs",
    exact: true,
    roles: [],
    component: lazy(() => import("../../../components/Test"))
  },
  {
    path: "/admin/faqs/:id/edit",
    exact: true,
    roles: [],
    component: lazy(() => import("../../../components/Test"))
  },
  {
    path: "/admin/faqs/create",
    exact: true,
    roles: [],
    component: lazy(() => import("../../../components/Test"))
  }
];

export default Routes;
