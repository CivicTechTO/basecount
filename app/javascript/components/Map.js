import React, { Component } from "react";
import { mapStyles } from "./../data/mapStyles.js";
// const { compose, withProps, withStateHandlers } = require("recompose");
const { compose, withStateHandlers } = require("recompose");
const {
  withScriptjs,
  withGoogleMap,
  GoogleMap,
  Marker,
  InfoWindow
} = require("react-google-maps");

class Map extends Component {
  state = {
    currentLocation: { lat: 43.64918, lng: -79.397859 }
  };

  componentDidMount() {
    navigator.geolocation.getCurrentPosition(geoData => {
      const { latitude, longitude } = geoData.coords;
      this.setCurrentLocation(latitude, longitude);
    });
  }

  setCurrentLocation = (latitude, longitude) => {
    const currentLocation = { ...this.state.currentLocation };
    currentLocation.lat = latitude;
    currentLocation.lng = longitude;
    this.setState({ currentLocation });
  };

  render() {
    const mapOptions = {
      styles: mapStyles
    };
    const MapWithAMakredInfoWindow = compose(
      withStateHandlers(),
      withScriptjs,
      withGoogleMap
    )(props => (
      <GoogleMap
        defaultZoom={16}
        defaultCenter={this.state.currentLocation}
        options={mapOptions}
      >
        {this.props.locations.map((location, i) => (
          <Marker
            key={location.key}
            position={{
              lat: location.latitude,
              lng: location.longitude
            }}
            onClick={() => {
              this.props.toggleLocationsActive(location.key);
              this.setCurrentLocation(location.latitude, location.longitude);
            }}
          >
            {location.key === this.props.activeKey && (
              <InfoWindow onCloseClick={props.onToggleOpen}>
                <div>
                  {location.orgName}
                  {location.orgName !== location.programName &&
                    "/" + location.programName}
                </div>
              </InfoWindow>
            )}
          </Marker>
        ))}
      </GoogleMap>
    ));

    /////END OF MAP

    return (
      <React.Fragment>
        <MapWithAMakredInfoWindow
          googleMapURL="https://maps.googleapis.com/maps/api/js?key=AIzaSyB-_GBwR4R1xZT8QnV1q1ph88yH1VeylfI&v=3.exp&libraries=geometry,drawing,places"
          loadingElement={<div style={{ height: `100%` }} />}
          containerElement={
            <div className="public-map" style={{ height: `50vh` }} />
          }
          mapElement={<div style={{ height: `100%` }} />}
        />
      </React.Fragment>
    );
  }
}
export default Map;
