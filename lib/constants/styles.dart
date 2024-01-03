import 'package:flutter/material.dart';

extension CustomColor on ColorScheme {
  Color get primaryColor => brightness == Brightness.light
      ? LightStyles.PrimaryColor
      : DarkStyles.PrimaryColor;

  Color get primaryDeepColor => brightness == Brightness.light
      ? LightStyles.PrimaryDeepColor
      : DarkStyles.PrimaryDeepColor;

  Color get backgroundColor => brightness == Brightness.light
      ? LightStyles.BackgroundColor
      : DarkStyles.BackgroundColor;

  Color get regularBaseColor => brightness == Brightness.light
      ? LightStyles.RegularBaseColor
      : DarkStyles.RegularBaseColor;

  Color get secondaryTextColor => brightness == Brightness.light
      ? LightStyles.SecondaryTextColor
      : DarkStyles.SecondaryTextColor;

  Color get primaryTextColor => brightness == Brightness.light
      ? LightStyles.PrimaryTextColor
      : DarkStyles.PrimaryTextColor;

  Color get deactivedColor => brightness == Brightness.light
      ? LightStyles.DeactivedColor
      : DarkStyles.DeactivedColor;

  Color get deactivedDeepColor => brightness == Brightness.light
      ? LightStyles.DeactivedDeepColor
      : DarkStyles.DeactivedDeepColor;

  Color get resumeColor => brightness == Brightness.light
      ? LightStyles.ResumeColor
      : DarkStyles.ResumeColor;

  Color get completeColor => brightness == Brightness.light
      ? LightStyles.CompleteColor
      : DarkStyles.CompleteColor;

  Color get dangerousColor => brightness == Brightness.light
      ? LightStyles.DangerousColor
      : DarkStyles.DangerousColor;

  Color get calendarDateRangeColor => brightness == Brightness.light
      ? LightStyles.CalendarDateRangeColor
      : DarkStyles.CalendarDateRangeColor;

  Color get barrierColor => brightness == Brightness.light
      ? LightStyles.BarrierColor
      : DarkStyles.BarrierColor;

  Color get addButtonShadowColor => brightness == Brightness.light
      ? LightStyles.AddButtonShadowColor
      : DarkStyles.AddButtonShadowColor;

  Color get dialogActionActivedColor => brightness == Brightness.light
      ? LightStyles.DialogActionActivedColor
      : DarkStyles.DialogActionActivedColor;

  Color get bookkeepingStatisticsShadowColor => brightness == Brightness.light
      ? LightStyles.BookkeepingStatisticsShadowColor
      : DarkStyles.BookkeepingStatisticsShadowColor;

  Color get whiteColor => brightness == Brightness.light
      ? LightStyles.RegularBaseColor
      : DarkStyles.PrimaryTextColor;

  Color get tabColor => brightness == Brightness.light
      ? LightStyles.RegularBaseColor
      : DarkStyles.PrimaryTextColor;

  Color get tabActivedColor => brightness == Brightness.light
      ? LightStyles.BackgroundColor
      : DarkStyles.PrimaryColor;

  Color get tabTextColor => brightness == Brightness.light
      ? LightStyles.PrimaryTextColor
      : DarkStyles.SecondaryTextColor;

  Color get tabActivedTextColor => brightness == Brightness.light
      ? LightStyles.PrimaryColor
      : DarkStyles.PrimaryTextColor;

  Color get greyColor => brightness == Brightness.light
      ? LightStyles.BackgroundColor
      : DarkStyles.DeactivedColor;
}

const _defaultTextStyle = TextStyle(
  leadingDistribution: TextLeadingDistribution.even,
  decoration: TextDecoration.none,
);

abstract class TextStyles {
  static const double TinyTextSize = 9;
  static const double TinyTextLineHeight = 12;
  static const double SmallTextSize = 12;
  static const double SmallTextLineHeight = 16;
  static const double RegularTextSize = 14;
  static const double RegularTextLineHeight = 20;
  static const double LargeTextSize = 16;
  static const double LargeTextLineHeight = 24;
  static const double GreatTextSize = 18;
  static const double GreatTextLineHeight = 26;

  static const double confirmDialogContentLineHeight = 18;

  static const double DateTextSize = 15;
  static const double DateTextLineHeight = 18;

  static const double AmountTextSize = 20;
  static const double AmountTextLineHeight = 32;

  static final tinyTextStyle = _defaultTextStyle.copyWith(
    fontSize: TinyTextSize,
    height: TinyTextLineHeight / TinyTextSize,
  );

  static final smallTextStyle = _defaultTextStyle.copyWith(
    fontSize: SmallTextSize,
    height: SmallTextLineHeight / SmallTextSize,
  );

  static final regularTextStyle = _defaultTextStyle.copyWith(
    fontSize: RegularTextSize,
    height: RegularTextLineHeight / RegularTextSize,
  );

  static final largeTextStyle = _defaultTextStyle.copyWith(
    fontSize: LargeTextSize,
    height: LargeTextLineHeight / LargeTextSize,
  );

  static final greatTextStyle = _defaultTextStyle.copyWith(
    fontSize: GreatTextSize,
    height: GreatTextLineHeight / GreatTextSize,
    fontWeight: FontWeight.bold,
  );

  static final dateTextStyle = _defaultTextStyle.copyWith(
    fontSize: DateTextSize,
    height: DateTextLineHeight / DateTextSize,
    fontWeight: FontWeight.bold,
  );

  static final amountTextStyle = _defaultTextStyle.copyWith(
    fontSize: AmountTextSize,
    height: AmountTextLineHeight / AmountTextSize,
    fontWeight: FontWeight.bold,
  );

  static final confirmDialogContentStyle = _defaultTextStyle.copyWith(
    fontSize: SmallTextSize,
    height: confirmDialogContentLineHeight / SmallTextSize,
  );
}

abstract class LightStyles {
  static const Color RegularBaseColor = Color(0xFFFFFFFF);
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
}

abstract class DarkStyles {
  static const Color RegularBaseColor = Color(0xFF17181F);
  static const Color PrimaryColor = Color(0xFF524EF5);
  static const Color PrimaryLightColor = Color(0xFF5753FC);
  static const Color PrimaryDeepColor = Color(0xFF4542EB);
  static const Color PrimaryTextColor = Color(0xFFF2F4FC);
  static const Color SecondaryTextColor = Color(0xFFABAFC2);
  static const Color BackgroundColor = Color(0xFF0F0F14);
  static const Color BarrierColor = Color(0x5C10101A);
  static const Color DeactivedColor = Color(0xFF525766);
  static const Color DeactivedDeepColor = Color(0xFF8C91A3);
  static const Color ToDoItemLevelIVColor = Color(0xFF7CEFB1);
  static const Color ToDoItemLevelIIIColor = Color(0xFF63DDFF);
  static const Color ToDoItemLevelIIColor = Color(0xFFFFE563);
  static const Color ToDoItemLevelIColor = Color(0xFFFF7B63);
  static const Color StudyColor = Color(0xFFB496FF);
  static const Color WorkColor = Color(0xFF91ABFF);
  static const Color LifeColor = Color(0xFF69EDE1);
  static const Color HealthColor = Color(0xFFFF9195);
  static const Color TravelColor = Color(0xFFAEF196);
  static const Color DangerousColor = Color(0xFFFF7B63);
  static const Color DangerousActivedColor = Color(0xFFFF644F);

  static const Color CompleteColor = Color(0xFF7CEFB1);
  static const Color CompleteActivedColor = Color(0xFF60EBA6);
  static const Color ResumeColor = Color(0xFFFFE563);
  static const Color ResumeActivedColor = Color(0xFFFFDC4F);
  static const Color AddButtonShadowColor = Color(0x33312DE0);

  static const Color BookkeepingBonusColor = Color(0xFFFFD097);
  static const Color BookkeepingPartTimeJobColor = Color(0xFFABF0FB);
  static const Color BookkeepingFinancingColor = Color(0xFF728BE4);
  static const Color BookkeepingGameColor = Color(0xFFFFB39A);
  static const Color BookkeepingFoodAndDrinkColor = Color(0xFFD2EFA3);
  static const Color BookkeepingShoppingColor = Color(0xFFFFDFCB);
  static const Color BookkeepingTrafficColor = Color(0xFF92C7FF);
  static const Color BookkeepingCommunicationColor = Color(0xFFDAD3F1);
  static const Color BookkeepingHousingColor = Color(0xFFBFD2D9);
  static const Color BookkeepingOtherColor = Color(0xFFF2F2F2);

  static const Color NoteImagesIndicatorBackgroundColor = Color(0x1A373655);

  static const Color CalendarDateRangeColor = Color(0xFF1D1D47);

  static const Color DialogActionActivedColor = Color(0xFFEFEFF2);

  static const Color BookkeepingStatisticsShadowColor = Color(0x0F373655);
}
