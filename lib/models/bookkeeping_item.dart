import 'package:flutter/material.dart';
import 'property.dart';
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
    icon: Ico.BookkeepingSalary,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.WorkColor
        : LightStyles.WorkColor,
    text: '工资',
  ),
  BookkeepingItemCategory.Bonus: Property(
    icon: Ico.BookkeepingBonus,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.BookkeepingBonusColor
        : LightStyles.BookkeepingBonusColor,
    text: '奖金',
  ),
  BookkeepingItemCategory.PartTimeJob: Property(
    icon: Ico.BookkeepingPartTimeJob,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.BookkeepingPartTimeJobColor
        : LightStyles.BookkeepingPartTimeJobColor,
    text: '兼职',
  ),
  BookkeepingItemCategory.Financing: Property(
    icon: Ico.BookkeepingFinancing,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.BookkeepingFinancingColor
        : LightStyles.BookkeepingFinancingColor,
    text: '理财',
  ),
  BookkeepingItemCategory.Study: Property(
    icon: Ico.BookkeepingStudy,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.StudyColor
        : LightStyles.StudyColor,
    text: '学习',
  ),
  BookkeepingItemCategory.FoodAndDrink: Property(
    icon: Ico.BookkeepingFoodAndDrink,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.BookkeepingFoodAndDrinkColor
        : LightStyles.BookkeepingFoodAndDrinkColor,
    text: '饮食',
  ),
  BookkeepingItemCategory.Daily: Property(
    icon: Ico.BookkeepingDaily,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.LifeColor
        : LightStyles.LifeColor,
    text: '日用',
  ),
  BookkeepingItemCategory.Game: Property(
    icon: Ico.BookkeepingGame,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.BookkeepingGameColor
        : LightStyles.BookkeepingGameColor,
    text: '游戏',
  ),
  BookkeepingItemCategory.Shopping: Property(
    icon: Ico.BookkeepingShopping,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.BookkeepingShoppingColor
        : LightStyles.BookkeepingShoppingColor,
    text: '购物',
  ),
  BookkeepingItemCategory.Leisure: Property(
    icon: Ico.BookkeepingLeisure,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.TravelColor
        : LightStyles.TravelColor,
    text: '休闲',
  ),
  BookkeepingItemCategory.Traffic: Property(
    icon: Ico.BookkeepingTraffic,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.BookkeepingTrafficColor
        : LightStyles.BookkeepingTrafficColor,
    text: '交通',
  ),
  BookkeepingItemCategory.Communication: Property(
    icon: Ico.BookkeepingCommunication,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.BookkeepingCommunicationColor
        : LightStyles.BookkeepingCommunicationColor,
    text: '通讯',
  ),
  BookkeepingItemCategory.Housing: Property(
    icon: Ico.BookkeepingHousing,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.BookkeepingHousingColor
        : LightStyles.BookkeepingHousingColor,
    text: '住房',
  ),
  BookkeepingItemCategory.Health: Property(
    icon: Ico.BookkeepingHealth,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.HealthColor
        : LightStyles.HealthColor,
    text: '医疗',
  ),
  BookkeepingItemCategory.Other: Property(
    icon: Ico.BookkeepingOther,
    color: (context) => Theme.of(context).brightness == Brightness.dark
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
