import React, { Component } from "react";
import LocationSelector from "./LocationSelector";
import LocationInfo from "./LocationInfo";
import CentralIntake from "./CentralIntake";
import Add from "react-icons/lib/md/add-circle-outline";
import Minus from "react-icons/lib/md/remove-circle-outline";
import firebase from "firebase";

class Operations extends Component {
  state = {
    activeKey: "",
    status: {
      activeOccupancy: 0
    }
  };

  updateLocation = activeKey => {
    const status = { ...this.state.status };
    const locationIndex = this.props.locations.findIndex(
      location => location.key === activeKey
    );
    status.activeOccupancy = this.props.locations[locationIndex].OCCUPANCY;
    this.setState({ activeKey, status });
  };

  updateStatus = e => {
    const status = { ...this.state.status };
    status[e.currentTarget.name] =
      status[e.currentTarget.name] + parseInt(e.currentTarget.value, 0);
    status[e.currentTarget.name] < 0 && (status[e.currentTarget.name] = 0);
    this.setState({ status });
  };

  submitStatus = () => {
    console.log("submit status");
    const time = Date.now();
    const updated = new Date();
    const locationStatus = {
      OCCUPANCY: this.state.status.activeOccupancy,
      time,
      updated
    };
    firebase
      .database()
      .ref()
      .child("/locations/" + this.state.activeKey)
      .update(locationStatus);
  };

  render() {
    const currentLocation = this.props.locations.find(
      location => location.key === this.state.activeKey
    );

    return (
      <React.Fragment>
        <section className="main-section">
          <div className="ops-wrap wrap80">
            <h1>Shelter Watch / Staff Login</h1>
            <LocationSelector
              locations={this.props.locations}
              updateLocation={this.updateLocation}
            />
            {currentLocation && (
              <LocationInfo currentLocation={currentLocation} />
            )}

            {this.state.activeKey !== "" && (
              <div className="operations-status">
                <div className="operations-status-occupancy">
                  <h3>Occupancy</h3>
                  <div className="status-number">
                    {this.state.status.activeOccupancy}{" "}
                  </div>
                  <div className="buttons">
                    <button
                      name="activeOccupancy"
                      value={-1}
                      onClick={this.updateStatus}
                    >
                      <Minus />
                    </button>
                    <button
                      name="activeOccupancy"
                      value={1}
                      onClick={e => this.updateStatus(e)}
                    >
                      <Add />
                    </button>
                  </div>
                </div>
              </div>
            )}
            {currentLocation && (
              <button className="submit-status-btn" onClick={this.submitStatus}>
                Submit Change
              </button>
            )}
            <CentralIntake />
          </div>
        </section>
      </React.Fragment>
    );
  }
}

export default Operations;
