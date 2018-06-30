import React, { Component } from "react";

class Login extends Component {
  render() {
    return (
      <nav className="login">
        <h3>Admin Login Page</h3>
        <p>Sign in to Manage Shelter Capacity and Location details.</p>
        <button
          className="gmailBtn"
          onClick={() => this.props.authenticate("Google")}
        >
          Login with Gmail
        </button>
        <br />
        <button
          className="gmailBtn"
          onClick={() => this.props.authenticate("Facebook")}
        >
          Login with Facebook
        </button>
        <br />
        <button
          className="githubBtn"
          onClick={() => this.props.authenticate("Github")}
        >
          Login with Github
        </button>
      </nav>
    );
  }
}

export default Login;
