import React from "react";
import styled from "styled-components"; // remove this, when OrgLogo moved to utilities

const Subheader = props => {
  return <OrgLogo>{props.orgName}</OrgLogo>;
};

// TODO: Move this to utilities
const OrgLogo = styled.div`
  color: white;
  font-size: 16px;
  font-weight: 100;
  margin: 32px;
  text-align: center;
`;

export default Subheader;
