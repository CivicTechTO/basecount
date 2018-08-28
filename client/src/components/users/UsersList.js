import React, { Component } from "react";
import UserItem from "./UserItem";
import UserFilter from "./UserFilter";
import { ButtonPrimary } from "../../utilities";

export default class UsersList extends Component {
  render() {
    const users = Object.values(this.props.users);
    return (
      <div>
        <UserFilter updateSearchFilter={this.props.updateSearchFilter} />
        {users
          .filter(
            user =>
              this.props.searchFilter === "" ||
              user.firstName
                .toLowerCase()
                .indexOf(this.props.searchFilter.toLowerCase()) !== -1 ||
              user.lastName
                .toLowerCase()
                .indexOf(this.props.searchFilter.toLowerCase()) !== -1 ||
              user.role
                .toLowerCase()
                .indexOf(this.props.searchFilter.toLowerCase()) !== -1
          )
          .map(user => <UserItem user={user} key={"user-" + user.id} />)}
        <ButtonPrimary style={{ margin: "0 auto", width: "90%" }}>
          Add User
        </ButtonPrimary>
      </div>
    );
  }
}
