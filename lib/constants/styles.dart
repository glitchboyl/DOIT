import 'package:flutter/material.dart';

abstract class Styles {
  static const Color RegularBaseColor = Colors.white;
  static const Color PrimaryColor = Color(0xFF3A36EE);
  static const Color PrimaryLightColor = Color(0xFF5753FC);
  static const Color PrimaryDeepColor = Color(0xFF2224C6);
  static const Color PrimaryTextColor = Color(0xFF373655);
  static const Color SecondaryTextColor = Color(0xFF868CA3);
  static const Color BackgroundColor = Color(0xFFF7F7FA);
  static const Color BarrierColor = Color(0x5C10101A);
  static const Color DeactivedColor = Color(0xFFDBDEEE);
  static const Color DeactivedDeepColor = Color(0xFFB8BBCC);
  static const Color ToDoItemLevelIVColor = Color(0xFF4BEB9B);
  static const Color ToDoItemLevelIIIColor = Color(0xFF3DCFFF);
  static const Color ToDoItemLevelIIColor = Color(0xFFFFD83D);
  static const Color ToDoItemLevelIColor = Color(0xFFFF543D);
  static const Color StudyColor = Color(0xFF9470FF);
  static const Color WorkColor = Color(0xFF6B89FF);
  static const Color LifeColor = Color(0xFF38E8DE);
  static const Color HealthColor = Color(0xFFFF6B76);
  static const Color TravelColor = Color(0xFF84ED64);
  static const Color DangerousColor = Color(0xFFFF543D);
  static const Color DangerousActivedColor = Color(0xFFD23426);

  static const Color CompleteColor = Color(0xFF4BEB9B);
  static const Color CompleteActivedColor = Color(0xFF2FC37E);
  static const Color ResumeColor = Color(0xFFFFD83D);
  static const Color ResumeActivedColor = Color(0xFFD2AA26);
  static const Color AddButtonShadowColor = Color(0x33312DE0);

  static const Color BookkeepingBonusColor = Color(0xFFFFBB71);
  static const Color BookkeepingPartTimeJobColor = Color(0xFF78E5FA);
  static const Color BookkeepingFinancingColor = Color(0xFF78E5FA);
  static const Color BookkeepingGameColor = Color(0xFFFF9174);
  static const Color BookkeepingFoodAndDrinkColor = Color(0xFFB9EB71);
  static const Color BookkeepingShoppingColor = Color(0xFFFFDFCB);
  static const Color BookkeepingTrafficColor = Color(0xFF6CADFF);
  static const Color BookkeepingCommunicationColor = Color(0xFFB8ADEE);
  static const Color BookkeepingHousingColor = Color(0xFF97BFCF);
  static const Color BookkeepingOtherColor = Color(0xFFDBE9EF);

  static const Color NoteImagesIndicatorBackgroundColor = Color(0x1A373655);

  static const Color CalendarDateRangeColor = Color(0xFFF0F0FF);

  static const Color DialogActionActivedColor = Color(0xFFEFEFF2);

  static const Color BookkeepingStatisticsShadowColor = Color(0x0F373655);

  static double tinyTextSize = 9;
  static double tinyTextLineHeight = 12;
  static double smallTextSize = 12;
  static double smallTextLineHeight = 16;
  static double textSize = 14;
  static double textLineHeight = 20;
  static double largeTextSize = 16;
  static double largeTextLineHeight = 24;
  static double greatTextSize = 18;
  static double greatTextLineHeight = 26;

  static double confirmDialogContentLineHeight = 18;

  static double dateTextSize = 15;
  static double dateTextLineHeight = 18;

  static double amountTextSize = 20;
  static double amountTextLineHeight = 32;

  static final daysOfWeekTextStyle = TextStyle(
    color: SecondaryTextColor,
    fontSize: smallTextSize,
    height: smallTextLineHeight / smallTextSize,
  );
}
