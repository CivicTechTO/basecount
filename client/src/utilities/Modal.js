import React, { Component } from "react";
import styled from "styled-components";
import { Portal, Icon } from "./index.js";

export default class Modal extends Component {
  render() {
    const { children, toggle, on } = this.props;
    return (
      <Portal>
        {on && (
          <ModalWrapper onClick={toggle}>
            <ModalCard>
              <CloseBtn onClick={toggle}>
                <Icon name="close" />
              </CloseBtn>
              <div>{children}</div>
            </ModalCard>
          </ModalWrapper>
        )}
      </Portal>
    );
  }
}
const ModalCard = styled.div`
  background: white;
  border-radius: 2px;
  padding: 15px;
  box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.7);
  position: relative;
  top: 50%;
  left: 50%;
  transform: translateX(-50%) translateY(-50%);
  width: 50%;
  transition: width ease 1s;
  border-radius: 2px;
  z-index: 10px;

  @media (max-width: 700px) {
    width: 90%;
  }
`;
const ModalWrapper = styled.div`
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.7);
`;

const CloseBtn = styled.button`
  position: absolute;
  top: 0;
  right: 0;
  border: none;
  background: transparent;
  padding: 10px;
  cursor: pointer;
`;

// const Background = styled.div`
//   position: absolute;
//   width: 100;
// `;
