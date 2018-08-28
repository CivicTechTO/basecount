import React, { Component } from "react";
import { UserFilterRow } from "../../utilities/Users";

class UserFilter extends Component {
  render() {
    return (
      <UserFilterRow>
        <input
          type="search"
          onChange={e => this.props.updateSearchFilter(e.target.value)}
          style={{ height: "32px", width: "100%", paddingLeft: "16px" }}
        />
        <div style={{ color: "white" }}>ico</div>
      </UserFilterRow>
    );
  }
}

export default UserFilter;
