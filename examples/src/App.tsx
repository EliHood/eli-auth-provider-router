import React from "react";
import { AuthProviderRouter } from "@core/auth-provider-router";
import { About, Contact, Dashboard } from "./pages";
export default function App() {
  /**
   * will need to figure out how to pass props to element pages
   */
  const ourRoutes = [
    {
      routeName: "/dashboard",
      isProtected: true,
      element: <Dashboard />,
      redirectTo: "/",
    },
    {
      routeName: "/about",
      isProtected: true,
      element: <About />,
    },
    {
      routeName: "/contact",
      isProtected: false,
      element: <Contact />,
      redirectTo: "/",
    },
  ];

  const validateToken = (token: string) => {
    /**
     * User will add their own logic for decoding tokens, user will need to return a boolean.
     */
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
