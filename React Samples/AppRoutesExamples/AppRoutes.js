import { CSSTransition, TransitionGroup } from "react-transition-group";
import React, { Suspense, lazy } from "react";
import { Route, Switch, withRouter, Redirect } from "react-router-dom";
import LoadingOverlay from "react-loading-overlay";
import PropTypes from "prop-types";
import RouteData from "./routes/admin/";
import publicRoutes from "./routes/public/";
import BasePage from "../components/layout/BasePage";
import PageLoader from "../components/common/PageLoader";
import LynwoodBase from "../components/layout/LynwoodBase";
import * as authService from "../services/authService";

import logger from "../logger";
const _logger = logger.extend("AppRoutes");

const Base = lazy(() => import("../components/layout/Base"));
// import BaseHorizontal from './components/Layout/BaseHorizontal';

// List of routes that uses the a simple page layout
const listofPages = [
  "/login",
  "/register",
  "/recover",
  "/lock",
  "/notfound",
  "/error500",
  "/maintenance",
  "/mock",
  "/registration/survey",
  "/recommendations",
  "/recommendation/details",
  "/confirm/validate"
];

class AppRoutes extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      routesToRender: RouteData.map(this.mapRoutes),
      publicRoutes: publicRoutes.map(this.mapRoutes),
      currentUser: { isLoggedIn: false, roles: [], hasAuthenticated: false },
      publicPaths: this.createRouteDict(publicRoutes)
    };

    this.currentKey = props.location.pathname.split("/")[1] || "/";
    this.timeout = { enter: 500, exit: 500 };
    this.animationName = "rag-fadeIn";
  }

  componentDidMount() {
    authService
      .getCurrentUser()
      .then(this.handleMount)
      .catch(this.mountError);
  }

  componentDidUpdate() {
    if (this.props.location.state) {
      if (
        this.props.location.state.type === "LOGIN" &&
        this.props.location.state.payload !== this.state.currentUser
      ) {
        let currentUser = this.props.location.state.payload;
        currentUser.isLoggedIn = true;
        currentUser.hasAuthenticated = true;
        this.setState({ currentUser });
      }
    }
  }

  handleMount = data => {
    const currentUser = data.item;
    currentUser.isLoggedIn = true;
    currentUser.hasAuthenticated = true;
    this.setState({ currentUser });
  };

  mountError = () => {
    let currentUser = { ...this.state.currentUser };
    currentUser.hasAuthenticated = true;
    this.setState({
      currentUser
    });
  };

  createRouteDict = routes => {
    let dict = {};
    for (let i = 0; i < routes.length; i++) {
      dict[routes[i].path.toLowerCase()] = routes[i];
    }
    return dict;
  };

  mapRoutes = prop => {
    let Component = prop.component;
    return (
      <Route
        key={prop.path}
        path={prop.path}
        exact={prop.exact}
        render={props => (
          <Component {...props} currentUser={this.state.currentUser} />
        )}
      />
    );
  };

  getLayoutContent = () => {
    // Layout component wrapper
    // Use <BaseHorizontal> to change layout
    return (
      <Suspense fallback={<PageLoader />}>
        <TransitionGroup>
          <CSSTransition
            key={this.currentKey}
            timeout={this.timeout}
            classNames={this.animationName}
            exit={false}
          >
            <Base currentUser={this.state.currentUser}>
              <Suspense fallback={<PageLoader />}>
                {this.state.currentUser.isLoggedIn ? (
                  <Switch location={this.props.location}>
                    {this.state.routesToRender}
                  </Switch>
                ) : (
                  <Switch>
                    <Redirect to="/login" />
                  </Switch>
                )}
              </Suspense>
            </Base>
          </CSSTransition>
        </TransitionGroup>
      </Suspense>
    );
  };

  getSimplePageContent = () => {
    return (
      <BasePage>
        <Suspense fallback={<PageLoader />}>
          <Switch location={this.props.location}>
            {this.state.publicRoutes}
          </Switch>
        </Suspense>
      </BasePage>
    );
  };

  getLynwoodPageContent = () => {
    return (
      <LynwoodBase>
        <Suspense fallback={<PageLoader />}>
          <Switch location={this.props.location}>
            {this.state.publicRoutes}
          </Switch>
        </Suspense>
      </LynwoodBase>
    );
  };

  render() {
    _logger(this.props.location);

    return listofPages.indexOf(this.props.location.pathname) > -1 ? (
      this.props.location.pathname !== "/mock" ? (
        this.getSimplePageContent()
      ) : (
        this.getLynwoodPageContent()
      )
    ) : this.state.currentUser.hasAuthenticated ? (
      this.getLayoutContent()
    ) : (
      <Suspense
        fallback={
          <LoadingOverlay
            active={true}
            spinner={<PageLoader />}
            styles={this.loadingStyles}
          />
        }
      >
        <TransitionGroup>
          <CSSTransition
            key={this.currentKey}
            timeout={this.timeout}
            classNames={this.animationName}
            exit={false}
          >
            <Base currentUser={this.state.currentUser}>
              <div>
                <Suspense
                  fallback={
                    <LoadingOverlay
                      active={true}
                      spinner={<PageLoader />}
                      styles={this.loadingStyles}
                    />
                  }
                />
              </div>
            </Base>
          </CSSTransition>
        </TransitionGroup>
      </Suspense>
    );
  }
}

AppRoutes.propTypes = {
  location: PropTypes.shape({
    pathname: PropTypes.string.isRequired,
    search: PropTypes.string.isRequired,
    hash: PropTypes.string.isRequired,
    state: PropTypes.object
  })
};

export default withRouter(AppRoutes);
