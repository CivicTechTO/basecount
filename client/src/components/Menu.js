import React, { Component } from "react";
import { Link } from "react-router-dom";
import styled from "styled-components";

export default class Menu extends Component {
  logoutClick = () => {
    console.log("logout user");
  };
  render() {
    return (
      <MenuDrop>
        <ul>
          <li>
            <Link to="/app/headcount">Headcount</Link>
          </li>
          <li>
            <Link to="/app/admin/users">User</Link>
          </li>
          <li>
            <Link to="/app/admin/sites">Sites</Link>
          </li>
          <li>
            <Link to="/app/account">Your settings</Link>
          </li>
          <li>
            <a href="#" onClick={this.logoutClick}>
              Logout
            </a>
          </li>
        </ul>
      </MenuDrop>
    );
  }
}

const MenuDrop = styled.div`
  ul {
    padding: 0;
    & li {
      list-style: none;
      & a {
        text-decoration: none !important;
        text-transform: uppercase;
      }
    }
  }
`;
