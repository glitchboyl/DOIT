// inspired of https://github.com/yize/solarlunar

const lunarInfo = [
  0x04bd8,
  0x04ae0,
  0x0a570,
  0x054d5,
  0x0d260,
  0x0d950,
  0x16554,
  0x056a0,
  0x09ad0,
  0x055d2, //1900-1909
  0x04ae0,
  0x0a5b6,
  0x0a4d0,
  0x0d250,
  0x1d255,
  0x0b540,
  0x0d6a0,
  0x0ada2,
  0x095b0,
  0x14977, //1910-1919
  0x04970,
  0x0a4b0,
  0x0b4b5,
  0x06a50,
  0x06d40,
  0x1ab54,
  0x02b60,
  0x09570,
  0x052f2,
  0x04970, //1920-1929
  0x06566,
  0x0d4a0,
  0x0ea50,
  0x06e95,
  0x05ad0,
  0x02b60,
  0x186e3,
  0x092e0,
  0x1c8d7,
  0x0c950, //1930-1939
  0x0d4a0,
  0x1d8a6,
  0x0b550,
  0x056a0,
  0x1a5b4,
  0x025d0,
  0x092d0,
  0x0d2b2,
  0x0a950,
  0x0b557, //1940-1949
  0x06ca0,
  0x0b550,
  0x15355,
  0x04da0,
  0x0a5b0,
  0x14573,
  0x052b0,
  0x0a9a8,
  0x0e950,
  0x06aa0, //1950-1959
  0x0aea6,
  0x0ab50,
  0x04b60,
  0x0aae4,
  0x0a570,
  0x05260,
  0x0f263,
  0x0d950,
  0x05b57,
  0x056a0, //1960-1969
  0x096d0,
  0x04dd5,
  0x04ad0,
  0x0a4d0,
  0x0d4d4,
  0x0d250,
  0x0d558,
  0x0b540,
  0x0b6a0,
  0x195a6, //1970-1979
  0x095b0,
  0x049b0,
  0x0a974,
  0x0a4b0,
  0x0b27a,
  0x06a50,
  0x06d40,
  0x0af46,
  0x0ab60,
  0x09570, //1980-1989
  0x04af5,
  0x04970,
  0x064b0,
  0x074a3,
  0x0ea50,
  0x06b58,
  0x05ac0,
  0x0ab60,
  0x096d5,
  0x092e0, //1990-1999
  0x0c960,
  0x0d954,
  0x0d4a0,
  0x0da50,
  0x07552,
  0x056a0,
  0x0abb7,
  0x025d0,
  0x092d0,
  0x0cab5, //2000-2009
  0x0a950,
  0x0b4a0,
  0x0baa4,
  0x0ad50,
  0x055d9,
  0x04ba0,
  0x0a5b0,
  0x15176,
  0x052b0,
  0x0a930, //2010-2019
  0x07954,
  0x06aa0,
  0x0ad50,
  0x05b52,
  0x04b60,
  0x0a6e6,
  0x0a4e0,
  0x0d260,
  0x0ea65,
  0x0d530, //2020-2029
  0x05aa0,
  0x076a3,
  0x096d0,
  0x04afb,
  0x04ad0,
  0x0a4d0,
  0x1d0b6,
  0x0d250,
  0x0d520,
  0x0dd45, //2030-2039
  0x0b5a0,
  0x056d0,
  0x055b2,
  0x049b0,
  0x0a577,
  0x0a4b0,
  0x0aa50,
  0x1b255,
  0x06d20,
  0x0ada0, //2040-2049
  0x14b63,
  0x09370,
  0x049f8,
  0x04970,
  0x064b0,
  0x168a6,
  0x0ea50,
  0x06b20,
  0x1a6c4,
  0x0aae0, //2050-2059
  0x092e0,
  0x0d2e3,
  0x0c960,
  0x0d557,
  0x0d4a0,
  0x0da50,
  0x05d55,
  0x056a0,
  0x0a6d0,
  0x055d4, //2060-2069
  0x052d0,
  0x0a9b8,
  0x0a950,
  0x0b4a0,
  0x0b6a6,
  0x0ad50,
  0x055a0,
  0x0aba4,
  0x0a5b0,
  0x052b0, //2070-2079
  0x0b273,
  0x06930,
  0x07337,
  0x06aa0,
  0x0ad50,
  0x14b55,
  0x04b60,
  0x0a570,
  0x054e4,
  0x0d160, //2080-2089
  0x0e968,
  0x0d520,
  0x0daa0,
  0x16aa6,
  0x056d0,
  0x04ae0,
  0x0a9d4,
  0x0a4d0,
  0x0d150,
  0x0f252, //2090-2099
  0x0d520,
]; //2100;

const upperCaseChineseNumber = [
  "\u65e5", // 日
  "\u4e00", // 一
  "\u4e8c", // 二
  "\u4e09", // 三
  "\u56db", // 四
  "\u4e94", // 五
  "\u516d", // 六
  "\u4e03", // 七
  "\u516b", // 八
  "\u4e5d", // 九
  "\u5341", // 十
];

const lunarDateChinese = [
  "\u521d", // 初
  "\u5341", // 十
  "\u5eff", // 廿
  "\u5345", // 卅
];

const lunarMonthChinese = [
  "\u6b63", // 正
  "\u4e8c", // 二
  "\u4e09", // 三
  "\u56db", // 四
  "\u4e94", // 五
  "\u516d", // 六
  "\u4e03", // 七
  "\u516b", // 八
  "\u4e5d", // 九
  "\u5341", // 十
  "\u51ac", // 冬
  "\u814a", // 腊
];

final leapMonth = (int year) => lunarInfo[year - 1900] & 0xf;

int leapDays(int year) => leapMonth(year) != 0
    ? lunarInfo[year - 1900] & 0x10000 != 0
        ? 30
        : 29
    : 0;

int getLunarYearDays(int year) {
  int i, sum = 348;
  for (i = 0x8000; i > 0x8; i >>= 1) {
    sum += lunarInfo[year - 1900] & i != 0 ? 1 : 0;
  }
  return sum + leapDays(year);
}

String toChineseMonth(int month) {
  if (month > 12 || month < 1) {
    return '';
  }
  String s = lunarMonthChinese[month - 1];
  s += "\u6708";
  return s;
}

int getLunarMonthDays(int year, int month) {
  if (month > 12 || month < 1) {
    return -1;
  }
  return lunarInfo[year - 1900] & (0x10000 >> month) != 0 ? 30 : 29;
}

String toChineseDay(int day) {
  String s;
  switch (day) {
    case 10:
      s = "\u521d\u5341";
      break;
    case 20:
      s = "\u4e8c\u5341";
      break;
    case 30:
      s = "\u4e09\u5341";
      break;
    default:
      s = lunarDateChinese[(day / 10).truncate()];
      s += upperCaseChineseNumber[day % 10];
  }
  return s;
}

LunarDate getLunar(DateTime solarDate) {
  // if (solarDate.year < 1900 || solarDate.year > 2100) {
  //   return -1;
  // }
  // if (solarDate.year == 1900 && solarDate.month == 1 && solarDate.day < 31) {
  //   return -1;
  // }
  int i, temp = 0;
  int offset = (DateTime.utc(
            solarDate.year,
            solarDate.month,
            solarDate.day,
          ).millisecondsSinceEpoch -
          DateTime.utc(1900, 1, 31).millisecondsSinceEpoch) ~/
      86400000;
  for (i = 1900; i < 2101 && offset > 0; i++) {
    temp = getLunarYearDays(i);
    offset -= temp;
  }
  if (offset < 0) {
    offset += temp;
    i--;
  }

  int year = i;
  int leap = leapMonth(i);
  bool isLeap = false;

  for (i = 1; i < 13 && offset > 0; i++) {
    if (leap > 0 && i == leap + 1 && isLeap == false) {
      --i;
      isLeap = true;
      temp = leapDays(year);
    } else {
      temp = getLunarMonthDays(year, i);
    }
    if (isLeap == true && i == leap + 1) {
      isLeap = false;
    }
    offset -= temp;
  }

  if (offset == 0 && leap > 0 && i == leap + 1) if (isLeap) {
    isLeap = false;
  } else {
    isLeap = true;
    --i;
  }
  if (offset < 0) {
    offset += temp;
    --i;
  }

  return LunarDate(
    solarDate: solarDate,
    month: (isLeap && (leap == i) ? "\u95f0" : "") + toChineseMonth(i),
    day: toChineseDay(offset + 1),
  );
}

class LunarDate {
  const LunarDate({
    required this.solarDate,
    required this.month,
    required this.day,
  });

  final DateTime solarDate;
  final String month;
  final String day;
}
