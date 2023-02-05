import 'dart:developer';

import 'package:intl/intl.dart' show DateFormat;

class DayMonth {
  String? day;
  String? month;
}

final List<String> convertTime = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '00',
];
final List<String> convertDay = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
];

final shortMonth = {
  'มกราคม': 'ม.ค.',
  'กุมภาพันธ์': 'ก.พ.',
  'มีนาคม': 'มี.ค.',
  'เมษายน': 'เม.ย.',
  'พฤษภาคม': 'พ.ค.',
  'มิถุนายน': 'มิ.ย.',
  'กรกฎาคม': 'ก.ค.',
  'สิงหาคม': 'ส.ค.',
  'กันยายน': 'ก.ย.',
  'ตุลาคม': 'ต.ค.',
  'พฤศจิกายน': 'พ.ย.',
  'ธันวาคม': 'ธ.ค.'
};
final List<String> monthThaiNumber = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12'
];

final List<String> monthThai = [
  'มกราคม',
  'กุมภาพันธ์',
  'มีนาคม',
  'เมษายน',
  'พฤษภาคม',
  'มิถุนายน',
  'กรกฎาคม',
  'สิงหาคม',
  'กันยายน',
  'ตุลาคม',
  'พฤศจิกายน',
  'ธันวาคม'
];

final List<String> minimizedThaiMonths = [
  'ม.ค.',
  'ก.พ.',
  'มี.ค.',
  'เม.ย.',
  'พ.ค.',
  'มิ.ย.',
  'ก.ค.',
  'ส.ค.',
  'ก.ย.',
  'ต.ค.',
  'พ.ย.',
  'ธ.ค.'
];

final intMonth = {
  'ม.ค.': 1,
  'ก.พ.': 2,
  'มี.ค.': 3,
  'เม.ย.': 4,
  'พ.ค.': 5,
  'มิ.ย.': 6,
  'ก.ค.': 7,
  'ส.ค.': 8,
  'ก.ย.': 9,
  'ต.ค.': 10,
  'พ.ย.': 11,
  'ธ.ค.': 12
};

final shortDayTH = {
  'Sun': 'อา.',
  'Mon': 'จ.',
  'Tue': 'อ.',
  'Wed': 'พ.',
  'Thu': 'พฤ.',
  'Fri': 'ศ.',
  'Sat': 'ส.',
};

final fullDayTH = [
  '',
  'จันทร์',
  'อังคาร',
  'พุธ',
  'พฤหัสบดี',
  'ศุกร์',
  'เสาร์',
  'อาทิตย์',
];

class Time {
  List<String> listMonthThai = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม'
  ];

  String thaiDateTextFormat(DateTime date, bool bcDate) {
    var daySplitTime = date.toString().split(' ')[0];
    var daySplitDate = daySplitTime.toString().split('-');
    var day = daySplitDate[2];
    var month = monthThai[int.parse(daySplitDate[1]) - 1];
    var year = daySplitDate[0];
    return '${day}' + ' ' + '${month}' + ' ' + '${year}';
  }

  String StringToDatetime(String date) {
    DateTime dateTime = new DateFormat('dd/MM/yyyy').parse(date);
    var day = convertDay[int.parse(DateFormat.d('th').format(dateTime)) - 1];
    var month =
        monthThaiNumber[int.parse(DateFormat.M('th').format(dateTime)) - 1];
    var year = int.parse(DateFormat.y('th').format(dateTime));
    return '${year - 543}' + '-' + '${month}' + '-' + '${day}' + ' 00:00:00';
  }

  String StringCutTimeToGetDate(String date) {
    var daySplitTime = date.toString().split(' ')[0];
    var daySplitDate = daySplitTime.toString().split('-');
    var day = daySplitDate[2];
    var month = monthThai[int.parse(daySplitDate[1]) - 1];
    var year = daySplitDate[0];
    return '${day}' + ' ' + '${month}' + ' ' + '${int.parse(year) + 543}';
  }

  String DatetimeToDateThaiString(String date) {
    var data = date.split(" ")[0];
    DateTime dateTime = new DateFormat('dd/MM/yyyy').parse(data);
    var daySplitTime = dateTime.toString().split(' ')[0];
    var daySplitDate = daySplitTime.toString().split('-');
    var day = int.parse(daySplitDate[2]);
    var month = monthThai[int.parse(daySplitDate[1]) - 1];
    var year = daySplitDate[0];
    return '${day}' + ' ' + '${month}' + ' ' + '${year}';
  }
}
