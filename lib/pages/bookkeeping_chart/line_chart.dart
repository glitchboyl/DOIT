import 'dart:math';
import 'package:doit/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/models/bookkeeping.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/providers/bookkeeping.dart';
import 'package:doit/utils/money_format.dart';
import 'package:doit/constants/calendar.dart';
import 'package:doit/constants/styles.dart';

final _maxX = 14.0;
final _maxY = 4.0;

class BookkeepingLineChart extends StatelessWidget {
  BookkeepingLineChart({
    super.key,
    required this.focusedTime,
    required this.type,
    required this.viewType,
  });

  final DateTime focusedTime;
  final BookkeepingItemType type;
  final BookkeepingChartViewType viewType;
  final List _calculations = [];
  double _peakAmount = 0;

  LineChartData get chartData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: _maxX,
        minY: 0,
        maxY: _maxY,
        
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Styles.BackgroundColor.withOpacity(0.9),
          tooltipPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) =>
              touchedBarSpots.map((barSpot) {
            final spot = _calculations.firstWhere((c) => c[0] == barSpot.x);
            return LineTooltipItem(
              '${spot[3]}\n',
              TextStyle(
                color: type == BookkeepingItemType.Incomes
                    ? Styles.PrimaryColor
                    : Styles.DangerousColor,
                fontSize: Styles.tinyTextSize,
                height: Styles.tinyTextLineHeight / Styles.tinyTextSize,
              ),
              children: [
                TextSpan(
                  text:
                      '${type == BookkeepingItemType.Incomes ? '收入' : '支出'}：${moneyFormat(spot[1])}',
                ),
              ],
              textAlign: TextAlign.left,
            );
          }).toList(),
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData => [
        lineChartBarData,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return TextBuilder(
      (_peakAmount / _maxY * value.toInt()).truncate().toString(),
      color: Styles.PrimaryTextColor,
      fontSize: Styles.tinyTextSize,
      lineHeight: Styles.tinyTextLineHeight,
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 46,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final index = _calculations.indexWhere(
      (e) =>
          (e[0].toStringAsFixed(2) == value.toStringAsFixed(2)) && e[2] != '',
    );
    if (index != -1) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 4,
        child: TextBuilder(
          _calculations[index][2],
          color: Styles.PrimaryTextColor,
          fontSize: Styles.tinyTextSize,
          lineHeight: Styles.tinyTextLineHeight,
        ),
      );
    }
    return SizedBox.shrink();
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 14,
        interval: 0.01,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Styles.DeactivedColor,
          ),
        ),
      );

  LineChartBarData get lineChartBarData => LineChartBarData(
        isCurved: true,
        color: type == BookkeepingItemType.Incomes
            ? Styles.PrimaryColor
            : Styles.DangerousColor,
        barWidth: 6,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        preventCurveOverShooting: true,
        spots: _calculations
            .map<FlSpot>(
              (e) => FlSpot(
                e[0],
                e[1] / _peakAmount * 4,
              ),
            )
            .toList(),
      );

  void calculate(BuildContext context) {
    final statisticsMap = Provider.of<BookkeepingProvider>(
      context,
      listen: false,
    ).statisticsMap;
    switch (viewType) {
      case BookkeepingChartViewType.Overview:
        var _focusedYear = focusedTime;
        for (int i = 0; i < 7; i++) {
          _calculations.add([
            double.parse((0.5 + i * (_maxX - 1) / 6).toStringAsFixed(2)),
            getAllStatisticsSum(
              statisticsMap[BookkeepingStatisticType.Year]?[_focusedYear]
                      ?[type.index]
                  .values,
            ),
            _focusedYear.year.toString(),
            _focusedYear.year.toString(),
          ]);
          if (_calculations.last[1] > _peakAmount) {
            _peakAmount = _calculations.last[1];
          }
          _focusedYear = DateTime(_focusedYear.year + 1);
        }
        break;
      case BookkeepingChartViewType.Year:
        var _focusedTime = DateTime(focusedTime.year);
        for (int i = 0; i < 12; i++) {
          _calculations.add([
            double.parse((13 / 11 * i + 0.5).toStringAsFixed(2)),
            getAllStatisticsSum(
              statisticsMap[BookkeepingStatisticType.Month]?[_focusedTime]
                      ?[type.index]
                  .values,
            ),
            '${_focusedTime.month}月',
            '${_focusedTime.year}.${_focusedTime.month}月',
          ]);
          if (_calculations.last[1] > _peakAmount) {
            _peakAmount = _calculations.last[1];
          }
          _focusedTime = DateTime(_focusedTime.year, _focusedTime.month + 1);
        }
        break;
      case BookkeepingChartViewType.Month:
        var _focusedTime = DateTime(focusedTime.year, focusedTime.month);
        final daysOfMonth =
            DateTime(focusedTime.year, focusedTime.month + 1, 0).day;
        for (int i = 0; i < daysOfMonth; i++) {
          _calculations.add([
            double.parse(
              (i < 25
                      ? 0.5 + i * (_maxX - 1) / 6 * 5 / 25
                      : 0.5 +
                          (_maxX - 1) / 6 * (5 + (i - 25) / (daysOfMonth - 26)))
                  .toStringAsFixed(2),
            ),
            getAllStatisticsSum(
              statisticsMap[BookkeepingStatisticType.Day]?[_focusedTime]
                      ?[type.index]
                  .values,
            ),
            (i % 5 == 0 || i == daysOfMonth - 1)
                ? fillDateZero(_focusedTime.day)
                : '',
            '${!_focusedTime.isSameYear(nowTime) ? '${nowTime.year}.' : ''}${fillDateZero(_focusedTime.month)}.${fillDateZero(_focusedTime.day)}',
          ]);
          if (_calculations.last[1] > _peakAmount) {
            _peakAmount = _calculations.last[1];
          }
          _focusedTime = _focusedTime.add(const Duration(days: 1));
        }
        break;
      case BookkeepingChartViewType.Week:
      default:
        var _focusedTime =
            focusedTime.subtract(Duration(days: focusedTime.weekday - 1));
        for (int i = 0; i < 7; i++) {
          _calculations.add([
            double.parse((0.5 + i * (_maxX - 1) / 6).toStringAsFixed(2)),
            getAllStatisticsSum(
              statisticsMap[BookkeepingStatisticType.Day]?[_focusedTime]
                      ?[type.index]
                  .values,
            ),
            weekDayTextMap[_focusedTime.weekday],
            '${!_focusedTime.isSameYear(nowTime) ? '${nowTime.year}.' : ''}${fillDateZero(_focusedTime.month)}.${fillDateZero(_focusedTime.day)}',
          ]);
          if (_calculations.last[1] > _peakAmount) {
            _peakAmount = _calculations.last[1];
          }
          _focusedTime = _focusedTime.add(const Duration(days: 1));
        }
        break;
    }
    if (_peakAmount < 100) {
      _peakAmount = 100;
    } else {
      final _peakAmountString = _peakAmount.truncate().toString();
      int _firstDigit = int.parse(_peakAmountString[0]);
      int _secondDigit = int.parse(_peakAmountString[1]);
      if (_secondDigit >= 5) {
        _firstDigit++;
        _secondDigit = 0;
      } else {
        _secondDigit = 5;
      }
      _peakAmount = (_firstDigit * pow(10, _peakAmountString.length - 1) +
              _secondDigit * pow(10, _peakAmountString.length - 2))
          .toDouble();
    }
  }

  String getSummaryText() {
    String summaryText = '';
    switch (viewType) {
      case BookkeepingChartViewType.Overview:
        summaryText += '总';
        break;
      case BookkeepingChartViewType.Year:
        summaryText += '年';
        break;
      case BookkeepingChartViewType.Month:
        summaryText += '月';
        break;
      case BookkeepingChartViewType.Week:
      default:
        summaryText += '一周';

        break;
    }
    summaryText +=
        '${type == BookkeepingItemType.Incomes ? '收入' : '支出'}：${moneyFormat(
      getAllStatisticsSum(
        _calculations.map(
          (c) => c[1],
        ),
      ),
    )}';
    return summaryText;
  }

  @override
  Widget build(BuildContext context) {
    calculate(context);
    return Container(
      height: 224,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Styles.RegularBaseColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBuilder(
            getSummaryText(),
            color: Styles.PrimaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: Styles.smallTextSize,
            lineHeight: Styles.smallTextLineHeight,
          ),
          SizedBox(height: 16),
          Expanded(
            child: LineChart(
              chartData,
              swapAnimationDuration: const Duration(milliseconds: 250),
            ),
          )
        ],
      ),
    );
  }
}
