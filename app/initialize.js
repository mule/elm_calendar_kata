import moment from 'moment';
import {getWeeksOfMonth} from './calendarUtils.js';

document.addEventListener('DOMContentLoaded', function() {
   var elmNode = document.getElementById('elm-calendar');
   var months = moment.months();
   var weekdays = moment.weekdaysMin();
   var currentMonth = moment().month();
   var currentYear  = moment().year();
   var currentDate = moment().date();
   var weeksOfCurrentMonth = getWeeksOfMonth(currentMonth,currentYear);

   var initialState = {
       months: months,
       weekdays: weekdays,
       selectedMonth: currentMonth,
       selectedYear: currentYear,
       selectedDay: currentDate,
       monthWeeks: weeksOfCurrentMonth};

   var app = Elm.Calendar.embed(elmNode, initialState);
   app.ports.monthRequest.subscribe(function(pair){
       console.log(pair)
       var month = pair[0];
       var year = pair[1];
       var weeksOfMonth = getWeeksOfMonth(month, year);
       var response = { monthWeeks: weeksOfMonth, selectedMonth: month, selectedYear: year};
       console.log("sending weeks")
       app.ports.monthResponse.send(response);
   })
});
