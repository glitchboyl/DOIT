import 'package:flutter/material.dart';
import 'property.dart';
import 'package:doit/providers/theme.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/icons.dart';

enum BookkeepingItemType {
  Incomes,
  Expenses,
}

enum BookkeepingItemCategory {
  Salary,
  Bonus,
  PartTimeJob,
  Financing,
  Study,
  FoodAndDrink,
  Daily,
  Game,
  Shopping,
  Leisure,
  Traffic,
  Communication,
  Housing,
  Health,
  Other,
}

const BookkeepingItemCategoryList = {
  BookkeepingItemType.Incomes: [
    BookkeepingItemCategory.Salary,
    BookkeepingItemCategory.Bonus,
    BookkeepingItemCategory.PartTimeJob,
    BookkeepingItemCategory.Financing,
    BookkeepingItemCategory.Other,
  ],
  BookkeepingItemType.Expenses: [
    BookkeepingItemCategory.FoodAndDrink,
    BookkeepingItemCategory.Study,
    BookkeepingItemCategory.Daily,
    BookkeepingItemCategory.Game,
    BookkeepingItemCategory.Shopping,
    BookkeepingItemCategory.Leisure,
    BookkeepingItemCategory.Traffic,
    BookkeepingItemCategory.Communication,
    BookkeepingItemCategory.Housing,
    BookkeepingItemCategory.Health,
    BookkeepingItemCategory.Financing,
    BookkeepingItemCategory.Other,
  ],
};

final bookkeepingItemCategoryMap = {
  BookkeepingItemCategory.Salary: Property(
    icon: (context) =>
        isDarkMode(context) ? Ico.BookkeepingSalaryDark : Ico.BookkeepingSalary,
    color: (context) =>
        isDarkMode(context) ? DarkStyles.WorkColor : LightStyles.WorkColor,
    text: '工资',
  ),
  BookkeepingItemCategory.Bonus: Property(
    icon: (context) =>
        isDarkMode(context) ? Ico.BookkeepingBonusDark : Ico.BookkeepingBonus,
    color: (context) => isDarkMode(context)
        ? DarkStyles.BookkeepingBonusColor
        : LightStyles.BookkeepingBonusColor,
    text: '奖金',
  ),
  BookkeepingItemCategory.PartTimeJob: Property(
    icon: (context) => isDarkMode(context)
        ? Ico.BookkeepingPartTimeJobDark
        : Ico.BookkeepingPartTimeJob,
    color: (context) => isDarkMode(context)
        ? DarkStyles.BookkeepingPartTimeJobColor
        : LightStyles.BookkeepingPartTimeJobColor,
    text: '兼职',
  ),
  BookkeepingItemCategory.Financing: Property(
    icon: (context) => isDarkMode(context)
        ? Ico.BookkeepingFinancingDark
        : Ico.BookkeepingFinancing,
    color: (context) => isDarkMode(context)
        ? DarkStyles.BookkeepingFinancingColor
        : LightStyles.BookkeepingFinancingColor,
    text: '理财',
  ),
  BookkeepingItemCategory.Study: Property(
    icon: (context) =>
        isDarkMode(context) ? Ico.BookkeepingStudyDark : Ico.BookkeepingStudy,
    color: (context) =>
        isDarkMode(context) ? DarkStyles.StudyColor : LightStyles.StudyColor,
    text: '学习',
  ),
  BookkeepingItemCategory.FoodAndDrink: Property(
    icon: (context) => isDarkMode(context)
        ? Ico.BookkeepingFoodAndDrinkDark
        : Ico.BookkeepingFoodAndDrink,
    color: (context) => isDarkMode(context)
        ? DarkStyles.BookkeepingFoodAndDrinkColor
        : LightStyles.BookkeepingFoodAndDrinkColor,
    text: '饮食',
  ),
  BookkeepingItemCategory.Daily: Property(
    icon: (context) =>
        isDarkMode(context) ? Ico.BookkeepingDailyDark : Ico.BookkeepingDaily,
    color: (context) =>
        isDarkMode(context) ? DarkStyles.LifeColor : LightStyles.LifeColor,
    text: '日用',
  ),
  BookkeepingItemCategory.Game: Property(
    icon: (context) =>
        isDarkMode(context) ? Ico.BookkeepingGameDark : Ico.BookkeepingGame,
    color: (context) => isDarkMode(context)
        ? DarkStyles.BookkeepingGameColor
        : LightStyles.BookkeepingGameColor,
    text: '游戏',
  ),
  BookkeepingItemCategory.Shopping: Property(
    icon: (context) => isDarkMode(context)
        ? Ico.BookkeepingShoppingDark
        : Ico.BookkeepingShopping,
    color: (context) => isDarkMode(context)
        ? DarkStyles.BookkeepingShoppingColor
        : LightStyles.BookkeepingShoppingColor,
    text: '购物',
  ),
  BookkeepingItemCategory.Leisure: Property(
    icon: (context) => isDarkMode(context)
        ? Ico.BookkeepingLeisureDark
        : Ico.BookkeepingLeisure,
    color: (context) =>
        isDarkMode(context) ? DarkStyles.TravelColor : LightStyles.TravelColor,
    text: '休闲',
  ),
  BookkeepingItemCategory.Traffic: Property(
    icon: (context) => isDarkMode(context)
        ? Ico.BookkeepingTrafficDark
        : Ico.BookkeepingTraffic,
    color: (context) => isDarkMode(context)
        ? DarkStyles.BookkeepingTrafficColor
        : LightStyles.BookkeepingTrafficColor,
    text: '交通',
  ),
  BookkeepingItemCategory.Communication: Property(
    icon: (context) => isDarkMode(context)
        ? Ico.BookkeepingCommunicationDark
        : Ico.BookkeepingCommunication,
    color: (context) => isDarkMode(context)
        ? DarkStyles.BookkeepingCommunicationColor
        : LightStyles.BookkeepingCommunicationColor,
    text: '通讯',
  ),
  BookkeepingItemCategory.Housing: Property(
    icon: (context) => isDarkMode(context)
        ? Ico.BookkeepingHousingDark
        : Ico.BookkeepingHousing,
    color: (context) => isDarkMode(context)
        ? DarkStyles.BookkeepingHousingColor
        : LightStyles.BookkeepingHousingColor,
    text: '住房',
  ),
  BookkeepingItemCategory.Health: Property(
    icon: (context) =>
        isDarkMode(context) ? Ico.BookkeepingHealthDark : Ico.BookkeepingHealth,
    color: (context) =>
        isDarkMode(context) ? DarkStyles.HealthColor : LightStyles.HealthColor,
    text: '医疗',
  ),
  BookkeepingItemCategory.Other: Property(
    icon: (context) =>
        isDarkMode(context) ? Ico.BookkeepingOtherDark : Ico.BookkeepingOther,
    color: (context) => isDarkMode(context)
        ? DarkStyles.BookkeepingOtherColor
        : LightStyles.BookkeepingOtherColor,
    text: '其他',
  ),
};

class BookkeepingItem {
  BookkeepingItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.time,
  });

  final int id;
  String title;
  double amount;
  BookkeepingItemType type;
  BookkeepingItemCategory category;
  DateTime time;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount.toString(),
      'type': type.index,
      'category': category.index,
      'time': time.millisecondsSinceEpoch,
    };
  }
}

final sortByTime =
    (BookkeepingItem a, BookkeepingItem b) => a.time.compareTo(b.time);

final getAllStatisticsSum = (Iterable<double>? statistics) =>
    statistics?.fold<double>(
      0,
      (a, b) => a + b,
    ) ??
    0;
