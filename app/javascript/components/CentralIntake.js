import React, { Component } from "react";
import { phone } from "./../assets/icons";
import styled from "styled-components";
class NotFound extends Component {
  render() {
    return (
      <div className="central-intake">
        <a href="tel:+1-416-338-4766">
          <div> {phone}</div> Central Intake{" "}
          <span className="number">416-338-4766</span>
        </a>
      </div>
    );
  }
}

export default NotFound;
