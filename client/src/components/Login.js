import React, { Component } from "react";
import {Redirect} from "react-router-dom";
import { Section, ButtonPrimary, Icon } from "../utilities";
import {postLogin} from "../data/backend";

export default class Login extends Component {

  componentWillMount() {
    this.setState({
      form: {
        username: '',
        password: '',
      },
      formError: null
    });
  }

  handleChange(propertyToChange) {
    return (e) => {
      const change = {};
      change[propertyToChange] = e.target.value;
      this.setState({ form: Object.assign({},this.state.form,change) });
    };
  };

  submitForm() {
    // clear submission errors
    this.setState({ formError: null });

    postLogin(this.state.form)
    .then( userObject => {
      console.log(userObject);
    })
    .catch( e => {
      this.setState({ formError: e.error });
    });
  }

  render() {
    // TODO: redirect if logged in?
    const errorMessages = this.state.formError ? (
      <div>{this.state.formError}</div>
    ) : null;

    const loginForm = (
      <LoginSection>
        <Icon name="logo-text" />
        <form>
          {errorMessages}
          <label>Email Address</label>
          <input 
            value={this.state.form.username}
            onChange={this.handleChange('username')}
            type="text"
          />
          <label>Password</label>
          <input 
            value={this.state.form.password}
            onChange={this.handleChange('password')}
            type="password"
          />
        </form>
        <ButtonPrimary
          onClick={_ => this.submitForm()}
        >Sign in</ButtonPrimary>
      </LoginSection>
    );
    console.log(`userid: ${this.props.userId}`)
    return this.props.userId ? (
      //TODO: this is probably wrong.
      <Redirect to="/app/account"/>
    ) : loginForm;
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
