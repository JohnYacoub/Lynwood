//Alphabetize
import adminRoutes from "./adminManagementRoutes";
import businessRoutes from "./businessRoutes";
import dashboardRoutes from "./dashboardRoutes";
import entrepreneurRoutes from "./entrepreneurRoutes";
import faqsRoutes from "./faqRoutes.js";
import fileRoutes from "./fileRoutes.js";
import userProfileRoutes from "./userProfileRoutes.js";
import resourceRoutes from "./resourceRoutes";
import surveyRoutes from "./surveyRoutes";
import testRoutes from "./testRoutes";

const Routes = adminRoutes
  .concat(businessRoutes)
  .concat(dashboardRoutes)
  .concat(entrepreneurRoutes)
  .concat(faqsRoutes)
  .concat(fileRoutes)
  .concat(userProfileRoutes)
  .concat(resourceRoutes)
  .concat(surveyRoutes)
  .concat(testRoutes);

const makeAdmin = routes => {
  routes.forEach(route => {
    route.isAdmin = true;

    if (!route.path.startsWith('/admin')) {
      route.path = '/admin' + route.path;
    }
  });
};

makeAdmin(Routes);
export default Routes;
