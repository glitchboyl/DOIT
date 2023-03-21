import 'property.dart';
import 'package:doit/constants/styles.dart';

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

const BookkeepingItemCategoryMap = {
  BookkeepingItemCategory.Salary: Property(
    icon: 'assets/images/bookkeeping_salary.svg',
    color: Styles.WorkColor,
    text: '工资',
  ),
  BookkeepingItemCategory.Bonus: Property(
    icon: 'assets/images/bookkeeping_bonus.svg',
    color: Styles.BookkeepingBonusColor,
    text: '奖金',
  ),
  BookkeepingItemCategory.PartTimeJob: Property(
    icon: 'assets/images/bookkeeping_part_time_job.svg',
    color: Styles.BookkeepingPartTimeJobColor,
    text: '兼职',
  ),
  BookkeepingItemCategory.Financing: Property(
    icon: 'assets/images/bookkeeping_financing.svg',
    color: Styles.BookkeepingFinancingColor,
    text: '理财',
  ),
  BookkeepingItemCategory.Study: Property(
    icon: 'assets/images/bookkeeping_study.svg',
    color: Styles.StudyColor,
    text: '学习',
  ),
  BookkeepingItemCategory.FoodAndDrink: Property(
    icon: 'assets/images/bookkeeping_food_and_drink.svg',
    color: Styles.BookkeepingFoodAndDrinkColor,
    text: '饮食',
  ),
  BookkeepingItemCategory.Daily: Property(
    icon: 'assets/images/bookkeeping_daily.svg',
    color: Styles.LifeColor,
    text: '日用',
  ),
  BookkeepingItemCategory.Game: Property(
    icon: 'assets/images/bookkeeping_game.svg',
    color: Styles.BookkeepingGameColor,
    text: '游戏',
  ),
  BookkeepingItemCategory.Shopping: Property(
    icon: 'assets/images/bookkeeping_shopping.svg',
    color: Styles.BookkeepingShoppingColor,
    text: '购物',
  ),
  BookkeepingItemCategory.Leisure: Property(
    icon: 'assets/images/bookkeeping_leisure.svg',
    color: Styles.TravelColor,
    text: '休闲',
  ),
  BookkeepingItemCategory.Traffic: Property(
    icon: 'assets/images/bookkeeping_traffic.svg',
    color: Styles.BookkeepingTrafficColor,
    text: '交通',
  ),
  BookkeepingItemCategory.Communication: Property(
    icon: 'assets/images/bookkeeping_communication.svg',
    color: Styles.BookkeepingCommunicationColor,
    text: '通讯',
  ),
  BookkeepingItemCategory.Housing: Property(
    icon: 'assets/images/bookkeeping_housing.svg',
    color: Styles.BookkeepingHousingColor,
    text: '住房',
  ),
  BookkeepingItemCategory.Health: Property(
    icon: 'assets/images/bookkeeping_health.svg',
    color: Styles.HealthColor,
    text: '医疗',
  ),
  BookkeepingItemCategory.Other: Property(
    icon: 'assets/images/bookkeeping_other.svg',
    color: Styles.BookkeepingOtherColor,
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
