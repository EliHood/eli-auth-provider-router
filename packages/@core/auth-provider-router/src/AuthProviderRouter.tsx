/**
 * @param {RoutesMap} routes Will take an array of type RoutesMap.
 * @param {string} token will take a JWT string. User will handle verify JWT implementation on their own.
 * @param {void} validateToken user will pass their own validate token handler, we will just validate it.
 */

import React, { ReactElement } from "react";
import { Route, Routes, Navigate, BrowserRouter } from "react-router-dom";

/**
 * @todo support nested routes.
 */
type RoutesMap = {
  isProtected: boolean;
  routeName: string;
  element?: JSX.Element | ReactElement;
  redirectTo?: string;
};

type ValidateToken = {
  /**
   * User will add their own logic for decoding tokens, user will need to return a boolean.
   */
  validateToken?: (token: string) => boolean;
};

type AuthProviderRouter = {
  routes: RoutesMap[];
  token?: string;
} & ValidateToken;

type AuthPrivateRoute = {
  token?: string;
  children: ReactElement;
  isProtected: boolean;
  redirectTo: string;
} & ValidateToken;

export function AuthPrivateRoute({
  children,
  token,
  isProtected,
  validateToken,
  redirectTo,
}: AuthPrivateRoute): ReactElement {
  /**
   * If validate token callback fails, and if route is protected redirect to some unathorized route like a login.
   */
  if (
    typeof validateToken === "function" &&
    !validateToken?.(token) &&
    isProtected
  ) {
    return <Navigate to={redirectTo} replace={true} />;
  }
  return children;
}

export function AuthProviderRouter({
  routes,
  token,
  validateToken,
}: AuthProviderRouter) {
  return (
    <BrowserRouter>
      <Routes>
        {routes.map(({ isProtected, routeName, element, redirectTo }, key) => (
          <Route
            key={key}
            path={routeName}
            element={
              <AuthPrivateRoute
                validateToken={validateToken}
                isProtected={isProtected}
                token={token}
                redirectTo={redirectTo}
              >
                {element}
              </AuthPrivateRoute>
            }
          />
        ))}
      </Routes>
    </BrowserRouter>
  );
}
