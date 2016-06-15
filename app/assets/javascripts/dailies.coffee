# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  data = {
    labels : $("#canvasLine").data('date'),
    datasets : [
      {
        fillColor : "rgba(151,187,205,0.5)",
        strokeColor : "rgba(151,187,205,1)",
        pointColor : "rgba(151,187,205,1)",
        pointStrokeColor : "#fff",
        data : $("#canvasLine").data('mood')
      }
    ]
  }

  myNewChart = new Chart($("#canvasLine").get(0).getContext("2d")).Line(data);