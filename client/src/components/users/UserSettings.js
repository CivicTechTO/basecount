import React from "react";
import styled from "styled-components";
import { PageTitle } from "../../utilities";

const Body = styled.div`
  color: white;
`;

const Input = styled.input`
  display: block;
  width: 90%;
  margin: 8px auto;
`;
const Label = styled.label`
  display: block;
  width: 90%;
  margin: 5px auto;
  font-size: 14px;
`;

export default class UserSettings extends React.Component {
  render() {
    const userId = parseInt(this.props.match.params.id, 10);
    const user = this.props.users.find(user => user.id === userId);
    console.log("UserSettings", userId);
    return (
      <div>
        <PageTitle>User Settings</PageTitle>
        <Body>
          <Label htmlFor="">First Name*</Label>
          <Input type="text" defaultValue={user.firstName} />
          <Label htmlFor="">Last Name*</Label>
          <Input type="text" defaultValue={user.lastName} />
          <Label htmlFor="">E-mail address*</Label>
          <div
            style={{
              fontSize: "14px",
              fontWeight: "100",
              width: "90%",
              margin: "5px auto"
            }}
          >
            <i>This will be your login</i>
          </div>
          <Input type="email" defaultValue={user.email} />
          <Label htmlFor="">Phone Number</Label>
          <Input type="tel" defaultValue={user.tel} />
          <Label htmlFor="">Position</Label>
          <Input type="text" defaultValue={user.role} />
          <Label htmlFor="">Permission Level*</Label>
          <select
            name="cars"
            style={{
              width: "90%",
              margin: "0 auto"
            }}
          >
            <option value="siteManager">Site Manager</option>
            <option value="siteEmployee">Site Employee</option>
          </select>
        </Body>
      </div>
    );
  }
}
