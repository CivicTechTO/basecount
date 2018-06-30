import React, { Component } from "react";
import { clear, filter, checked, unchecked } from "./../assets/icons";

class EligibilityFilter extends Component {
  render() {
    return (
      <div className="eligibility-form wrap80">
        <div
          className="close-sidebar"
          onClick={() => this.props.toggleFilter()}
        >
          {clear}
        </div>
        <form>
          <label>
            <input
              name="men"
              type="checkbox"
              checked={this.props.filter.men}
              onChange={e => this.props.handleCheckboxChange(e)}
            />
            <div className="new-checkbox">
              {this.props.filter.men ? checked : unchecked}
            </div>
            Men
          </label>
          <label>
            <input
              name="women"
              type="checkbox"
              checked={this.props.filter.women}
              onChange={e => this.props.handleCheckboxChange(e)}
            />
            <div className="new-checkbox">
              {this.props.filter.women ? checked : unchecked}
            </div>
            Women
          </label>
          <label>
            <input
              name="youth"
              type="checkbox"
              checked={this.props.filter.youth}
              onChange={e => this.props.handleCheckboxChange(e)}
            />
            <div className="new-checkbox">
              {this.props.filter.youth ? checked : unchecked}
            </div>
            Youth
          </label>
          <label>
            <input
              name="mixed"
              type="checkbox"
              checked={this.props.filter.mixed}
              onChange={e => this.props.handleCheckboxChange(e)}
            />
            <div className="new-checkbox">
              {this.props.filter.mixed ? checked : unchecked}
            </div>
            Mixed Adult
          </label>
          <label>
            <input
              name="family"
              type="checkbox"
              checked={this.props.filter.family}
              onChange={e => this.props.handleCheckboxChange(e)}
            />
            <div className="new-checkbox">
              {this.props.filter.family ? checked : unchecked}
            </div>
            Family
          </label>
          <label>
            <input
              name="other"
              type="checkbox"
              checked={this.props.filter.other}
              onChange={e => this.props.handleCheckboxChange(e)}
            />
            <div className="new-checkbox">
              {this.props.filter.other ? checked : unchecked}
            </div>
            Other
          </label>
        </form>
      </div>
    );
  }
}

export default EligibilityFilter;
