import React from "react";
import {Route, Redirect} from "react-router-dom";

// We should be redirecting if the user is logged out
const PrivateRoute = ({ render: Render, ...rest }) => (
  <Route
    {...rest}
    render={ props => props.appUser != null ? Render : 
      (
        <Redirect
          to={{
            pathname: "/login"
          }}
        />
      )
    }
  />
)

export default PrivateRoute;