import {getWeeksOfMonth} from '../calendarUtils.js';
import * as _ from 'lodash';
describe('calendarUtils tests', function () {
    it('should get weeks of month',function () {
        var expectedWeeks = 5;
        var  actual = getWeeksOfMonth(0,1990);
        var unexpectedWeeks = _.filter(actual, (week) => {return week.weekOfYear >5 && week.weekOfYear < 1});
        expect(unexpectedWeeks.length).toBe(0);
        expect(actual.length).toBe(expectedWeeks);
    });
});
