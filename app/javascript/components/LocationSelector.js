import React, { Component } from "react";

class LocationSelector extends Component {
  render() {
    const { locations } = this.props;
    return (
      <React.Fragment>
        <select
          name="location-selector"
          className="location-selector"
          // ref={this.locationRef}
          type="text"
          onChange={e => this.props.updateLocation(e.currentTarget.value)}
        >
          {Object.keys(locations)
            .sort(
              (a, b) =>
                locations[a].orgName.toLowerCase() >
                locations[b].orgName.toLowerCase()
                  ? 1
                  : -1
            )
            .map(index => (
              <option key={locations[index].key} value={locations[index].key}>
                {locations[index].orgName}
              </option>
            ))}
        </select>
      </React.Fragment>
    );
  }
}

export default LocationSelector;
