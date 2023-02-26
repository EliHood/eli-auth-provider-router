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
      routeName: "/home",
      isProtected: true,
    },
  ];
  return (
    <>
      <h1>Auth Provider Wrapper</h1>
      <AuthProviderRouter routes={ourRoutes} />
    </>
  );
}
