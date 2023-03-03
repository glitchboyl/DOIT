import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  static const Color LifeColor = Color(0xFF64EDB6);
  static const Color HealthColor = Color(0xFFFF6B76);
  static const Color TravelColor = Color(0xFF84ED64);
  static const Color DangerousColor = Color(0xFFFF543D);
  static const Color DangerousActivedColor = Color(0xFFD23426);

  static const Color CompleteColor = Color(0xFF4BEB9B);
  static const Color CompleteActivedColor = Color(0xFF2FC37E);
  static const Color ResumeColor = Color(0xFFFFD83D);
  static const Color ResumeActivedColor = Color(0xFFD2AA26);
  static const Color AddButtonShadowColor = Color(0x33312DE0);

  static const Color DialogActionActivedColor = Color(0xFFEFEFF2);

  static const Color BookkeepingStatisticsShadowColor = Color(0x0F373655);

  static double textSize = 14.sp;
  static double textLineHeight = 20.sp;
  static double smallTextSize = 12.sp;
  static double smallTextLineHeight = 16.sp;
  static double largeTextSize = 18.sp;
  static double largeTextLineHeight = 26.sp;

  static double dialogContentLineHeight = 18.sp;

  static double drawerItemTextSize = 16.sp;
  static double drawerItemTextLineHeight = 22.sp;

  static double statisticTextSize = 20.sp;
  static double statisticTextLineHeight = 32.sp;
}
