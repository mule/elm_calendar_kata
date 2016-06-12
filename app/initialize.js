import moment from 'moment';
import {getWeeksOfMonth} from './calendarUtils.js';

document.addEventListener('DOMContentLoaded', function() {
   var elmNode = document.getElementById('elm-calendar');
   var weekdays = moment.weekdaysMin();
   var currentMonth = moment().month();
   var currentYear  = moment().year();
   var weeksOfCurrentMonth = getWeeksOfMonth(currentMonth,currentYear);
   var app = Elm.Calendar.embed(elmNode, {weekdays: weekdays, monthWeeks: weeksOfCurrentMonth});
   app.ports.monthRequest.subscribe(function(params){
       console.log(params)
       var weekdays = moment.weekdaysMin();
       var currentMonth = moment().month();
       var currentYear  = moment().year();
       var weeksOfCurrentMonth = getWeeksOfMonth(currentMonth,currentYear);
       console.log("sending weekdays")
       app.ports.monthResponse.send({weekdays: weekdays, monthWeeks: weeksOfCurrentMonth});
   })
});
