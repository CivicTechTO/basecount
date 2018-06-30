import React, { Component } from "react";

class LocationInfo extends Component {
  render() {
    const { currentLocation } = this.props;
    return (
      <React.Fragment>
        <div className="location-info">
          <h3>{currentLocation.orgName}</h3>
          {/* Availability is only shown if updated within 16 hours */}
          {currentLocation.time > Date.now() - 57600000 && (
            <p>
              <span className="location-info-label">Availability: </span>
              <span className="location-info-value">
                {currentLocation.CAPACITY - currentLocation.OCCUPANCY} of{" "}
                {currentLocation.CAPACITY} beds. last udpated:{" "}
                {currentLocation.updated}
              </span>
            </p>
          )}
          <p>
            <span className="location-info-label">Address: </span>
            <span className="location-info-value">
              {currentLocation.address}
            </span>
          </p>
          <p>
            <span className="location-info-label">Hours: </span>
            <span className="location-info-value">{currentLocation.hours}</span>
          </p>
          <p>
            <span className="location-info-label">Eligibility: </span>
            <span className="location-info-value">
              {currentLocation.eligibility.map((index, i) => (
                <span key={i}> {index} </span>
              ))}
            </span>
          </p>
          {currentLocation.eligibilityNotes && (
            <p>
              <span className="location-info-label">Eligibility Notes: </span>
              <span className="location-info-value">
                {currentLocation.eligibilityNotes}
              </span>
            </p>
          )}
          {currentLocation.web && (
            <p>
              <span className="location-info-label">Phone: </span>
              <span className="location-info-value">
                <a
                  href={"http://" + currentLocation.web}
                  rel="noopener noreferrer"
                  target="_blank"
                >
                  {currentLocation.web}
                </a>
              </span>
            </p>
          )}
          {currentLocation.phone && (
            <p>
              <span className="location-info-label">Phone: </span>
              <span className="location-info-value">
                {currentLocation.phone}
              </span>
            </p>
          )}
        </div>
      </React.Fragment>
    );
  }
}

export default LocationInfo;
