import 'package:doit/utils/time.dart';
import 'lunar.dart';

final Map<int, Map<int, String>> solarDateFestivals = {
  1: {
    1: '元旦',
  },
  2: {
    14: '情人节',
  },
  3: {
    8: '妇女节',
    12: '植树节',
    15: '消费者日',
  },
  4: {
    1: '愚人节',
  },
  5: {
    1: '劳动节',
    4: '青年节',
  },
  6: {
    1: '儿童节',
  },
  7: {
    1: '建党节',
  },
  8: {
    1: '建军节',
  },
  9: {
    10: '教师节',
  },
  10: {
    1: '国庆节',
    24: '程序员日',
    31: '万圣夜',
  },
  11: {
    11: '光棍节',
  },
  12: {
    24: '平安夜',
    25: '圣诞节',
  },
};

final lunarDateFestivals = {
  '正月': {
    '初一': '春节',
    '十五': '元宵节',
  },
  '二月': {
    '初二': '龙抬头',
  },
  '五月': {
    '初五': '端午节',
  },
  '七月': {
    '初七': '七夕',
    '十五': '中元节',
  },
  '八月': {
    '十五': '中秋节',
  },
  '九月': {
    '初九': '重阳节',
  },
  '腊月': {
    '廿三': '北方小年',
    '廿四': '南方小年',
    '三十': '除夕',
  },
};

String? getSpecialDateFestival(DateTime date) {
  if (date.month == 5 &&
      date.weekday == DateTime.sunday &&
      date.weekdayInMonth() == 2)
    return '母亲节';
  else if (date.month == 6 &&
      date.weekday == DateTime.sunday &&
      date.weekdayInMonth() == 3)
    return '父亲节';
  else if (date.month == 11 &&
      date.weekday == DateTime.thursday &&
      date.weekdayInMonth() == 4) return '感恩节';
  return null;
}

String getDateFestivals(LunarDate lunarDate) {
  final List<String> festivals = [];
  final DateTime solarDate = lunarDate.solarDate;
  final String? solarDateFesitval =
      solarDateFestivals[solarDate.month]?[solarDate.day];
  final String? lunarDateFestival = lunarDateFestivals[lunarDate.month
      .replaceFirstMapped('from', (match) => '')]?[lunarDate.day];
  final String? specialDateFestivel = getSpecialDateFestival(solarDate);
  if (solarDateFesitval != null) {
    festivals.add(solarDateFesitval);
  }
  if (lunarDateFestival != null) {
    festivals.add(lunarDateFestival);
  }
  if (specialDateFestivel != null) {
    festivals.add(specialDateFestivel);
  }
  if (festivals.length > 1 && festivals[0] == '国庆节' && festivals[1] == '中秋节')
    return '国庆中秋';
  return festivals.length > 0 ? festivals[0] : '';
}
