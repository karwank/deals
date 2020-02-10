import React from "react"
import PropTypes from "prop-types"

import CanvasJSReact from 'javascripts/canvasjs/canvasjs.react';

var CanvasJS = CanvasJSReact.CanvasJS;
var CanvasJSChart = CanvasJSReact.CanvasJSChart;

class DealStagesChart extends React.Component {  
  render() {

    let dataPoints = this.props.data.map((row) => {      
      return {y: row.value, label: row.name}
    })

    const options = {
      animationEnabled: true,
      exportEnabled: true,
      theme: "light2",
      axisX: {
        title: "Deal Stage"
      },
      axisY: {
        title: "Total Value of Deals",
      },
      data: [{
        type: "column",
        indexLabelFontColor: "#5A5757",
        indexLabelPlacement: "outside",
        yValueFormatString: "$ #,##0.##",
        dataPoints: dataPoints
      }]
    }
    
    return (
    <div>
      <CanvasJSChart options = {options} 
        /* onRef={ref => this.chart = ref} */
      />
      {/*You can get reference to the chart instance as shown above using onRef. This allows you to access all chart properties and methods*/}
    </div>
    );
  }
}

DealStagesChart.propTypes = {
  data: PropTypes.array
};
export default DealStagesChart
