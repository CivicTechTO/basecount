import React, { Component } from "react";
import { Section, ButtonPrimary, ButtonSecondary } from "../utilities";

export default class Sites extends Component {
  render() {
    return (
      <SitesSection>
        <div className="section-wrapper">
          <div>Add/Edit sites here</div>
        </div>
      </SitesSection>
    );
  }
}

const SitesSection = Section.extend``;
