import React, { Component, Fragment } from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
// import axios from "axios";
import Login from "./components/Login";
import Header from "./components/Header";
import Subheader from "./components/Subheader";
import Headcount from "./components/Headcount";
import Sites from "./components/Sites";
import Users from "./components/Users";
import Account from "./components/Account";
import "./App.css";
import data from "./data/front-end";

class App extends Component {
  state = {
    appOrg: null,
    appUse: null,
    orgs: {},
    sites: {},
    users: {},
    loggedIn: false,
    siteServices: [],
    sitePopulations: [],
    permission_levels: []
  };

  componentWillMount() {
    console.log(data);
    const {
      appOrg,
      appUser,
      siteServices,
      sitePopulations,
      permission_levels
    } = data;
    const { orgs, sites, users, loggedIn } = data.dbData;
    this.setState({
      appOrg,
      appUser,
      orgs,
      sites,
      users,
      loggedIn,
      siteServices: Object.values(siteServices),
      sitePopulations: Object.values(sitePopulations),
      permission_levels
    });
  }

  render() {
    const { appOrg, appUser } = this.state;
    return (
      <div className="App">
        <BrowserRouter>
          <Fragment>
            <Header />
            <Subheader orgName={this.state.orgs[appOrg].name} />
            <Switch>
              <Route exact path="/app/" render={() => <Login />} />
              <Route
                exact
                path="/app/headcount"
                render={() => (
                  <Headcount
                    user={this.state.users[appUser]}
                    org={this.state.orgs[appOrg]}
                    sites={this.state.sites}
                  />
                )}
              />
              <Route
                exact
                path="/app/admin/sites"
                render={() => (
                  <Sites
                    user={this.state.users[appUser]}
                    org={this.state.orgs[appOrg]}
                    users={this.state.users}
                    sites={this.state.sites}
                  />
                )}
              />
              <Route
                path="/app/admin/users"
                render={props => (
                  <Users
                    {...props}
                    user={this.state.users[appUser]}
                    org={this.state.orgs[appOrg]}
                    users={this.state.users}
                    sites={this.state.sites}
                  />
                )}
              />
              <Route
                exact
                path="/app/account"
                render={() => <Account user={this.state.users[appUser]} />}
              />
            </Switch>
          </Fragment>
        </BrowserRouter>
      </div>
    );
  }
}

export default App;
