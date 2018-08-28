import styled from "styled-components";
import { blue, blueDark, orange, silver, white } from "./colors";

const Button = styled.button`
  border-radius: 2px;
  border: 1px solid transparent;
  color: ${white};
  display: block;
  font-weight: bold;
  max-width: 90%;
  padding: 1rem;

  &:hover {
    background-color: ${white};
  }

  &:disabled,
  &:disabled:hover {
    background-color: ${silver};
    border: 1px solid transparent;
    color: ${blueDark};
  }

  }
`;

export const ButtonPrimary = Button.extend`
  background-color: ${orange};

  &:hover {
    border: 1px solid ${orange};
    color: ${orange};
  }
`;
export const ButtonSecondary = Button.extend`
  background-color: ${blue};

  &:hover {
    border: 1px solid ${blue};
    color: ${blue};
  }
`;
