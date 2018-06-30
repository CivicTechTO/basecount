import React, { Component } from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
import Public from "./components/Public";
import Operations from "./components/Operations";
import Admin from "./components/Admin";
import NotFound from "./components/NotFound";
import firebase from "firebase";

const config = {
  apiKey: "AIzaSyB-_GBwR4R1xZT8QnV1q1ph88yH1VeylfI",
  authDomain: "shelter-33632.firebaseapp.com",
  databaseURL: "https://shelter-33632.firebaseio.com",
  projectId: "shelter-33632",
  storageBucket: "shelter-33632.appspot.com",
  messagingSenderId: "319352140748"
};

firebase.initializeApp(config);

class App extends Component {
  state = {
    locations: []
  };

  componentDidMount() {
    const dbRef = firebase.database().ref("locations");

    dbRef.on("value", snapshot => {
      const data = snapshot.val();
      const newLocations = [];
      //item is the id that firebase creates
      for (let item in data) {
        data[item].key = item;
        newLocations.push(data[item]);
      }

      this.setState({
        locations: newLocations
      });
    });
  }

  render() {
    return (
      <BrowserRouter>
        <Switch>
          <Route
            exact
            path="/"
            // component={Public}
            render={() => <Public locations={this.state.locations} />}
          />
          <Route
            exact
            path="/Admin"
            render={() => <Admin locations={this.state.locations} />}
          />
          <Route
            exact
            path="/Operations"
            // component={Operations}
            render={() => <Operations locations={this.state.locations} />}
          />
          <Route component={NotFound} />
        </Switch>
      </BrowserRouter>
    );
  }
}

export default App;
