import React from "react";
import { AuthProviderRouter } from "@core/auth-provider-router";
export default function App() {
  const ourRoutes = [
    {
      routeName: "/dashboard",
      isProtected: true,
      // element: <Component /> some component will go here, need to figure out how to accept props etc.
    },
    {
      routeName: "/home",
      isProtected: false,
    },
    {
      routeName: "/login",
      isProtected: false,
    },
  ];

  const validateToken = (token: string) => {
    console.log("token:", token);
    return false;
  };
  return (
    <>
      <h1>Auth Provider Wrapper</h1>
      <AuthProviderRouter
        routes={ourRoutes}
        validateToken={validateToken}
        token={
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
        }
      />
    </>
  );
}
