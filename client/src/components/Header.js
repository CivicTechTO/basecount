import React, { Component, Fragment } from "react";
import { blue, blueDark } from "../utilities/colors";
import { Toggle, Modal, Icon } from "../utilities";
import styled from "styled-components";
import Menu from "./Menu";

export default class Header extends Component {
  render() {
    return (
      <MainHeader>
        <Icon name="logo" style={{ height: "50px", width: "50px" }} />
        <Toggle>
          {({ on, toggle }) => (
            <Fragment>
              <button onClick={toggle}>DROP</button>
              <Modal on={on} toggle={toggle}>
                <Menu />
              </Modal>
            </Fragment>
          )}
        </Toggle>
      </MainHeader>
    );
  }
}

const MainHeader = styled.header`
  display: flex;
  flex-flow: row nowrap;
  background-color: white;
  justify-content: space-between;
  padding: 20px;
  .header__logo {
    color: ${blue};
  }
  .header__nav {
    color: ${blueDark};
  }
  & > svg {
    width: 50px;
    height: 50px;
  }
`;
