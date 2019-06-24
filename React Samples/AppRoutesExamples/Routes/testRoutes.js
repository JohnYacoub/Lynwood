import { lazy } from "react";

// an example file to separate your routes from the AppRoutes.js file

// also look at the index.js file located inside this folder
const Routes = [
  {
    path: "/admin/tests",
    exact: true,
    roles: [],
    component: lazy(() => import("./../../../components/Test"))
  },
  {
    path: "/admin/tests/:id",
    exact: true,
    roles: [],
    component: lazy(() => import("./../../../components/Test"))
  },
  {
    path: "/admin/tests/something/:id",
    exact: true,
    roles: [],
    component: lazy(() => import("./../../../components/Test"))
  }
];

export default Routes;
