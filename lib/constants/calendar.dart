import 'package:doit/utils/lunar.dart';
import 'package:doit/utils/festivals.dart';
import 'package:doit/utils/solar_terms.dart';
import 'package:doit/utils/time.dart';

final weekDayTextMap = {
  DateTime.monday: '一',
  DateTime.tuesday: '二',
  DateTime.wednesday: '三',
  DateTime.thursday: '四',
  DateTime.friday: '五',
  DateTime.saturday: '六',
  DateTime.sunday: '日',
};

const List<String> Months = <String>[
  '1月',
  '2月',
  '3月',
  '4月',
  '5月',
  '6月',
  '7月',
  '8月',
  '9月',
  '10月',
  '11月',
  '12月',
];

final firstDay = DateTime(nowTime.year - 10);
final lastDay = DateTime(nowTime.year + 50);

class DateInfo {
  const DateInfo({
    required this.lunar,
    required this.festival,
    required this.solarTerm,
  });

  final LunarDate lunar;
  final String festival;
  final String solarTerm;
}

final Map<DateTime, DateInfo> calendarMap = () {
  final Map<DateTime, DateInfo> _calendarMap = {};
  DateTime _date = firstDay;
  while (_date.compareTo(lastDay) == -1) {
    final LunarDate lunar = getLunar(_date);
    String festival = getDateFestivals(lunar);
    String solarTerm = getDateSolarTerm(_date);
    _calendarMap[_date] = DateInfo(
      lunar: lunar,
      festival: festival,
      solarTerm: solarTerm,
    );
    _date = _date.add(const Duration(days: 1));
  }
  return _calendarMap;
}();