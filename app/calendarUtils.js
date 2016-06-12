import moment from 'moment';

export function getWeeksOfMonth(month, year) {
    var monthWeeks = [];
    var firstOfMonth = moment().year(year).month(month).date(1) ;
    console.log(firstOfMonth.format());
    var weekOfYear = firstOfMonth.week();
    var dayCounter = firstOfMonth.weekday(0);

    for (var weekOfMonth = 1; weekOfMonth < 6; weekOfMonth++) {
        var week = {
            weekOfYear: dayCounter.week(),
            dates: []
        }
        for (var dayOfWeek = 1; dayOfWeek < 8; dayOfWeek++) {
            week.dates.push({
                weekDay: dayCounter.weekday(),
                date: dayCounter.date(),
                month: dayCounter.month()
            });
            dayCounter.add(1,'d')
        }
        monthWeeks.push(week);
    }
    return monthWeeks;
}
