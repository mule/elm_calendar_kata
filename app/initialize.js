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
   console.log("sending weekdays")
   app.ports.monthResponse.send({
       months: months,
       weekdays: weekdays,
       selectedMonth: currentMonth,
       selectedYear: currentYear,
       selectedDay: currentDate,
       monthWeeks: weeksOfCurrentMonth});

   var app = Elm.Calendar.embed(elmNode, {weekdays: weekdays, monthWeeks: weeksOfCurrentMonth});
   app.ports.monthRequest.subscribe(function(params){
       console.log(params)
       var months = moment.months();
       var weekdays = moment.weekdaysMin();
       var currentMonth = moment().month();
       var currentYear  = moment().year();
       var currentDate = moment().date();
       var weeksOfCurrentMonth = getWeeksOfMonth(currentMonth,currentYear);
       console.log("sending weekdays")
       app.ports.monthResponse.send({
           months: months,
           weekdays: weekdays,
           selectedMonth: currentMonth,
           selectedYear: currentYear,
           selectedDay: currentDate,
           monthWeeks: weeksOfCurrentMonth});
   })
});
