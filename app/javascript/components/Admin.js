import React, { Component } from "react";
// import shelters from "./../data/shelters.json";
import LocationSelector from "./LocationSelector";
import LocationInfo from "./LocationInfo";
import CentralIntake from "./CentralIntake";
import Add from "react-icons/lib/md/add-circle-outline";
import Minus from "react-icons/lib/md/remove-circle-outline";
import firebase from "firebase";
import Login from "./Login";

class Admin extends Component {
  state = {
    activeKey: "",
    status: {
      activeOccupancy: 0,
      activeCapacity: 0
    }
  };

  updateLocation = activeKey => {
    const status = { ...this.state.status };
    const locationIndex = this.props.locations.findIndex(
      location => location.key === activeKey
    );
    status.activeOccupancy = this.props.locations[locationIndex].OCCUPANCY;
    status.activeCapacity = this.props.locations[locationIndex].CAPACITY;
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
      CAPACITY: this.state.status.activeCapacity,
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

  authHandler = async authData => {
    console.log(authData);
    // const id = authData.user.uid;
    // const userData = await base.fetch(id, { context: this });
    // if (!userData.id) {
    //   await base.post(`${id}/id`, {
    //     data: id
    //   });
    // }
    // this.setState(
    //   { id }
    // );
  };

  authenticate = provider => {
    const authProvider = new firebase.auth[`${provider}AuthProvider`]();
    firebase
      .auth()
      .signInWithPopup(authProvider)
      .then(this.authHandler)
      .catch(err => alert(err.message));
  };

  render() {
    const currentLocation = this.props.locations.find(
      location => location.key === this.state.activeKey
    );
    return <Login authenticate={this.authenticate} />;
    return (
      <React.Fragment>
        <section className="main-section">
          <div className="ops-wrap wrap80">
            <h1>This is the the admin page</h1>
            <p>
              this will include a login and then form section to upload new
              shelter info
            </p>
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

                <div className="operations-status-occupancy">
                  <h3>Capacity</h3>
                  <div className="status-number">
                    {this.state.status.activeCapacity}
                  </div>
                  <div className="buttons">
                    <button
                      name="activeCapacity"
                      value={-1}
                      onClick={this.updateStatus}
                    >
                      <Minus />
                    </button>
                    <button
                      name="activeCapacity"
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

            {/* DANGER!!!! THIS WILL ADD EVERYTHING FROM THE JSON REQUIRED FOR INITIAL DATA POP ONLY */}

            {/* {shelters.data.map(shelter => {
          const shelterInfo = shelter;
          shelterInfo.OCCUPANCY = 0;
          shelterInfo.CAPACITY = 0;
          shelterInfo.updated = "";
          shelterInfo.time = 0;

          console.log(shelterInfo);
          const dbRef = firebase.database().ref("locations");
          dbRef.push(shelterInfo);
        })} */}
          </div>
        </section>
      </React.Fragment>
    );
  }
}

export default Admin;
