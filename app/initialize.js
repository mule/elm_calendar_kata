import * as moment from 'moment';

document.addEventListener('DOMContentLoaded', function() {
   var elmNode = document.getElementById('elm-calendar');
   var weekdays = moment.weekdaysMin();
   var app = Elm.Calendar.embed(elmNode, {weekdays: weekdays});
   app.ports.weekdaysRequest.subscribe(function(params){
       console.log(params)
       var weekdays = moment.weekdaysMin();
       console.log("sending weekdays")
       app.ports.weekdaysResponse.send(weekdays);
   })
});
