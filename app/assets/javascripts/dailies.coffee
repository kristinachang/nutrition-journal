# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

# PIE GRAPH
  data = [
      {
          value: 300,
          color:"#F7464A",
          highlight: "#FF5A5E",
          label: "Protein"
      },
      {
          value: 50,
          color: "#46BFBD",
          highlight: "#5AD3D1",
          label: "Carb"
      },
      {
          value: 100,
          color: "#FDB45C",
          highlight: "#FFC870",
          label: "Fat"
      }
  ]

  myNewChart = new Chart($("#canvasPie").get(0).getContext("2d")).Pie(data);