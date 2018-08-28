import React, { Component } from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import { Section, PageTitle } from "../utilities";
import UsersList from "./users/UsersList";
import UserSettings from "./users/UserSettings";

export default class Users extends Component {
  state = {
    searchFilter: ""
  };

  updateSearchFilter = searchFilter => {
    this.setState({ searchFilter });
  };

  render() {
    const users = Object.values(this.props.users);
    const { match } = this.props;
    return (
      <UserSection>
        <div className="section__wrapper">
          <Route
            exact
            path={match.path}
            render={() => (
              <div>
                <PageTitle>User</PageTitle>
                <UsersList
                  users={users}
                  updateSearchFilter={this.updateSearchFilter}
                  searchFilter={this.state.searchFilter}
                />
              </div>
            )}
          />
          <Route
            path={`${match.path}/user/:id`}
            render={props => <UserSettings {...props} users={users} />}
          />
        </div>
      </UserSection>
    );
  }
}

const UserSection = Section.extend`
  .section__wrapper {
    max-width: 400px;
  }
`;
