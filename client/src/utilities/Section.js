import styled from "styled-components";

export const Section = styled.section`
  & .section__wrapper {
    color: white;
    width: 86%;
    max-width: 1200px;
    margin: 75px auto 0;
    text-align: center;
    &.flex-three {
      display: flex;
      flex-flow: row wrap;
      justify-content: space-between;
    }

    h2 {
      margin-bottom: 50px;
    }
  }
`;
