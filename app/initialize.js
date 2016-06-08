import * as momentjs from 'momentjs'

document.addEventListener('DOMContentLoaded', function() {
   var elmNode = document.getElementById('elm-calendar');
   var app = Elm.Main.embed(elmNode);
   app.ports.weekdays.subscribe(function(params){
       var weekdays
   })
});
