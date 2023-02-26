import React, { ReactElement } from "react";
import { Route, Routes, Navigate, BrowserRouter } from "react-router-dom";

type RoutesMap = {
  isProtected: boolean;
  routeName: string;
  element?: JSX.Element | ReactElement;
};

interface IAuthProviderRouter {
  routes: RoutesMap[];
  token?: string;
}

type AuthPrivateRoute = {
  routeName?: string;
  token?: string;
  children: ReactElement;
  isProtected: boolean;
};

export function AuthPrivateRoute({
  children,
  routeName,
  token,
  isProtected,
}: AuthPrivateRoute): ReactElement {
  if (!token || isProtected) {
    <Navigate to={routeName} replace={true} />;
  }
  return children;
}

export function AuthProviderRouter({ routes, token }: IAuthProviderRouter) {
  return (
    <BrowserRouter>
      <Routes>
        {routes.map(({ isProtected, routeName, element }, key) => (
          <Route
            key={key}
            path={routeName}
            element={
              <AuthPrivateRoute isProtected={isProtected} token={token}>
                {element}
              </AuthPrivateRoute>
            }
          />
        ))}
      </Routes>
    </BrowserRouter>
  );
}
