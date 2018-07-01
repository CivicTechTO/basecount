import React, { Component } from "react";
import { Pie } from "react-chartjs-2";

class Chart extends Component {
  render() {
    const available =
      this.props.currentLocation.CAPACITY -
      this.props.currentLocation.OCCUPANCY;

    const chartData = {
      labels: ["Occupied", "Available"],
      datasets: [
        {
          label: "Beds",
          data: [this.props.currentLocation.OCCUPANCY, available],
          backgroundColor: ["rgba(51,51,51,0.5", "rgba(80,165,209, 0.5)"]
        }
      ]
    };

    return (
      <div className="pie-chart">
        <div className="pie-chart-div">
          <Pie
            data={chartData}
            width="220"
            height="220"
            options={{
              legend: {
                display: true
              }
            }}
          />
        </div>
      </div>
    );
  }
}

export default Chart;
