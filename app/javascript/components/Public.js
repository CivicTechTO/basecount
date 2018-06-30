import React, { Component } from "react";
import Map from "./Map";
import EligibilityFilter from "./EligibilityFilter";
import LocationInfo from "./LocationInfo";
import CentralIntake from "./CentralIntake";
import Chart from "./Chart";
import { clear, filter } from "./../assets/icons";

class Public extends Component {
  state = {
    locationsActive: [],
    activeKey: "",
    filter: {
      men: false,
      women: false,
      youth: false,
      mixed: false,
      family: false,
      other: false
    },
    search: "",
    sidebar: false
  };

  toggleLocationsActive = locationKey => {
    this.setState({
      activeKey: locationKey
    });
  };

  handleCheckboxChange = e => {
    const filter = { ...this.state.filter };
    filter[e.target.name] = !filter[e.target.name];
    this.setState({ filter });
  };

  updateSearch = e => {
    this.setState({ search: e.target.value });
  };

  toggleFilter = () => {
    this.setState({ sidebar: !this.state.sidebar });
  };

  render() {
    const currentLocation = this.props.locations.find(
      location => location.key === this.state.activeKey
    );
    //If all values false (no boxes checked use locations) otherwise filter using checked boxes
    let eligibilityFiltered = Object.values(this.state.filter).every(
      value => value === false
    )
      ? this.props.locations
      : this.props.locations.filter(location => {
          return location.eligibility.some(
            item => this.state.filter[item.replace(/ .*/, "")]
          );
        });
    //Check if there is a match with the search box

    let filteredLocations = eligibilityFiltered.filter(location => {
      return (
        location.orgName
          .toLowerCase()
          .indexOf(this.state.search.toLowerCase()) !== -1 ||
        location.programName
          .toLowerCase()
          .indexOf(this.state.search.toLowerCase()) !== -1
      );
    });

    return (
      <React.Fragment>
        {this.state.sidebar && (
          <EligibilityFilter
            sidebar={this.state.sidebar}
            filter={this.state.filter}
            handleCheckboxChange={this.handleCheckboxChange}
            toggleFilter={this.toggleFilter}
          />
        )}
        <section className="main-section">
          <header>
            <div className="main-section-wrap wrap80">
              <h1>Shelter Watch</h1>
              <div className="search-box">
                <div className="filter-icon" onClick={this.toggleFilter}>
                  {filter}
                </div>
                <label htmlFor="search" className="visuallyhidden">
                  {" "}
                  Search by Name:
                </label>
                <input
                  id="serach"
                  name="search"
                  type="text"
                  value={this.state.search}
                  placeholder="Search Shelters"
                  onChange={this.updateSearch.bind(this)}
                />

                <button onClick={() => this.setState({ search: "" })}>
                  {clear}
                </button>
              </div>
            </div>
          </header>

          <Map
            locations={filteredLocations}
            activeKey={this.state.activeKey}
            locationsActive={this.state.locationsActive}
            toggleLocationsActive={this.toggleLocationsActive}
          />
          <section className="main-info wrap80">
            <div className="main-info-chart">
              {currentLocation ? (
                <LocationInfo currentLocation={currentLocation} />
              ) : (
                <div className="maxH220">
                  <p className="main-info-start">
                    Search Map for closest shelter location, click on marker for
                    shelter availability and details.
                  </p>

                  <p className="main-info-intro">
                    Call <a href="tel:311">311</a> or Central Intake at{" "}
                    <a href="tel:+1-416-338-4766">416-338-4766</a> or
                    <a href="tel:+ 1-877-338-3398"> 1-877-338-3398</a> for
                    emergency shelter. Youth and adults can get a walk-in
                    referral from the Streets to Homes Assessment and Referral
                    Centre at 129 Peter St (the red map marker red map marker).
                    The shelters listed can be contacted directly, but may not
                    have available space.
                  </p>
                </div>
              )}
              {currentLocation &&
                (currentLocation.time > Date.now() - 57600000 && (
                  <Chart currentLocation={currentLocation} />
                ))}
            </div>
            <CentralIntake />
          </section>
        </section>
      </React.Fragment>
    );
  }
}

export default Public;
