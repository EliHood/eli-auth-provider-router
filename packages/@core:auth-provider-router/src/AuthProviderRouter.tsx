/**
 * @param {RoutesMap} routes Will take an array of type RoutesMap.
 * @param {string} token will take a JWT string. User will handle verify JWT implementation on their own.
 * @param {void} validateToken user will pass their own validate token handler, we will just validate it.
 */

import React, { ReactElement } from "react";
import { Route, Routes, Navigate, BrowserRouter } from "react-router-dom";

/**
 * @todo support nest routes.
 */
type RoutesMap = {
  isProtected: boolean;
  routeName: string;
  element?: JSX.Element | ReactElement;
};

type ValidateToken = {
  validateToken?: (token: string) => boolean;
};

type AuthProviderRouter = {
  routes: RoutesMap[];
  token?: string;
} & ValidateToken;

type AuthPrivateRoute = {
  routeName?: string;
  token?: string;
  children: ReactElement;
  isProtected: boolean;
} & ValidateToken;

export function AuthPrivateRoute({
  children,
  routeName,
  token,
  isProtected,
  validateToken,
}: AuthPrivateRoute): ReactElement {
  if (!validateToken(token) && isProtected) {
    <Navigate to={routeName} replace={true} />;
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
        {routes.map(({ isProtected, routeName, element }, key) => (
          <Route
            key={key}
            path={routeName}
            element={
              <AuthPrivateRoute
                validateToken={validateToken}
                isProtected={isProtected}
                token={token}
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
