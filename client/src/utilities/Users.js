import styled from "styled-components";

export const UserItemContainer = styled.div`
  width: 90%;
  max-width: 400px;
  margin: 0 auto;
`;

export const UserFilterRow = styled.div`
  display: flex;
  flex-flow: row nowrap;
  justify-content: space-between;
  width: 90%;
  margin: 0 auto;
`;

export const UserItemStyle = styled.div`
  width: 90%;
  background-color: #1c41b2;
  height: 64px;
  margin: 4px auto;
  border: 1px solid transparent;
  border-radius: 2px;
  text-aling: left;
`;

export const UserItemTitle = styled.div`
  text-transform: uppercase;
  font-weight: 800;
  color: white;
`;

export const UserItemRole = styled.div`
  color: white;
  font-weight: 300;
  font-size: 1.4rem;
`;
