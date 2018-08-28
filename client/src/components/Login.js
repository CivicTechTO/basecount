import React, { Component } from "react";
import { Link } from "react-router-dom";
import { Section, ButtonPrimary, ButtonSecondary, Icon } from "../utilities";

export default class Login extends Component {
  render() {
    return (
      <LoginSection>
        <Icon name="logo-text" />
        <Link to="/app/headcount">
          <ButtonPrimary>Login</ButtonPrimary>
        </Link>
      </LoginSection>
    );
  }
}

const LoginSection = Section.extend`
  text-align: center;
  button {
    margin: 50px auto;
  }
  & > svg {
    height: 200px;
    width: 200px;
  }
`;
