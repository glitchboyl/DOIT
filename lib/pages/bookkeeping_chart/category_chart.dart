import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/bookkeeping_data_row.dart';
import 'package:doit/models/bookkeeping.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/providers/bookkeeping.dart';
import 'package:doit/constants/styles.dart';

class BookkeepingCategoryChart extends StatefulWidget {
  const BookkeepingCategoryChart({
    super.key,
    required this.focusedTime,
    required this.type,
    required this.viewType,
  });

  final DateTime focusedTime;
  final BookkeepingItemType type;
  final BookkeepingChartViewType viewType;

  @override
  State<StatefulWidget> createState() => _BookkeepingCategoryChartState();
}

class _BookkeepingCategoryChartState extends State<BookkeepingCategoryChart> {
  int _touchedIndex = -1;
  late DateTime _focusedTime;
  late BookkeepingItemType _type;
  late BookkeepingChartViewType _viewType;
  final Map<BookkeepingItemCategory, double> _statistics = {};
  double _totalAmount = 0;

  @override
  void initState() {
    super.initState();
    gatherStatistics(this.context);
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_focusedTime != widget.focusedTime ||
        _type != widget.type ||
        _viewType != widget.viewType) {
      gatherStatistics(this.context);
    }
  }

  gatherStatistics(BuildContext context) {
    _focusedTime = widget.focusedTime;
    _type = widget.type;
    _viewType = widget.viewType;
    _statistics.clear();
    final statisticsMap = Provider.of<BookkeepingProvider>(
      context,
      listen: false,
    ).statisticsMap;
    switch (_viewType) {
      case BookkeepingChartViewType.Overview:
        var _focusedYear = _focusedTime;
        for (int i = 0; i < 7; i++) {
          final statistics = statisticsMap[BookkeepingStatisticType.Year]
              ?[_focusedYear]?[_type.index];
          if (statistics != null) {
            statistics.forEach((key, value) {
              if (_statistics[key] == null) {
                _statistics[key] = 0;
              }
              _statistics[key] = _statistics[key]! + value;
            });
          }
          _focusedYear = DateTime(_focusedYear.year + 1);
        }
        break;
      case BookkeepingChartViewType.Year:
        var _focusedMonth = DateTime(_focusedTime.year);
        for (int i = 0; i < 12; i++) {
          final statistics = statisticsMap[BookkeepingStatisticType.Month]
              ?[_focusedMonth]?[_type.index];
          if (statistics != null) {
            statistics.forEach((key, value) {
              if (_statistics[key] == null) {
                _statistics[key] = 0;
              }
              _statistics[key] = _statistics[key]! + value;
            });
          }
          _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
        }
        break;
      case BookkeepingChartViewType.Month:
        var _focusedDay = DateTime(_focusedTime.year, _focusedTime.month);
        final daysOfMonth =
            DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;
        for (int i = 0; i < daysOfMonth; i++) {
          final statistics = statisticsMap[BookkeepingStatisticType.Day]
              ?[_focusedDay]?[_type.index];
          if (statistics != null) {
            statistics.forEach((key, value) {
              if (_statistics[key] == null) {
                _statistics[key] = 0;
              }
              _statistics[key] = _statistics[key]! + value;
            });
          }
          _focusedDay = _focusedDay.add(const Duration(days: 1));
        }
        break;
      case BookkeepingChartViewType.Week:
      default:
        var _focusedDay =
            _focusedTime.subtract(Duration(days: _focusedTime.weekday - 1));
        for (int i = 0; i < 7; i++) {
          final statistics = statisticsMap[BookkeepingStatisticType.Day]
              ?[_focusedDay]?[_type.index];
          if (statistics != null) {
            statistics.forEach((key, value) {
              if (_statistics[key] == null) {
                _statistics[key] = 0;
              }
              _statistics[key] = _statistics[key]! + value;
            });
          }
          _focusedDay = _focusedDay.add(const Duration(days: 1));
        }
        break;
    }
    final Map<BookkeepingItemCategory, double> sortedMap = {};
    final sortedKeys = _statistics.keys.toList(growable: false)
      ..sort((a, b) => _statistics[b]!.compareTo(_statistics[a]!));
    for (int i = 0; i < sortedKeys.length; i++) {
      sortedMap[sortedKeys[i]] = _statistics[sortedKeys[i]]!;
    }
    _statistics.clear();
    _statistics.addAll(sortedMap);
    _totalAmount = getAllStatisticsSum(_statistics.values);
  }

  List<PieChartSectionData> showingSections() {
    if (_statistics.length == 0) {
      return [
        PieChartSectionData(
          color: Styles.BackgroundColor,
          value: 100,
          title: '',
          titleStyle: TextStyle(
            fontSize: Styles.smallTextSize,
            color: Styles.PrimaryTextColor,
          ),
        )
      ];
    }
    int i = 0;
    return _statistics.keys.map((categoryType) {
      final isTouched = i++ == _touchedIndex;
      final fontSize = isTouched ? Styles.amountTextSize : Styles.smallTextSize;
      final radius = isTouched ? 60.0 : 50.0;
      final percentage = double.parse(
          (_statistics[categoryType]! / _totalAmount * 100).toStringAsFixed(0));
      return PieChartSectionData(
        color: BookkeepingItemCategoryMap[categoryType]!.color,
        value: percentage,
        title: '${percentage.toInt()}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          color: Styles.PrimaryTextColor,
          // shadows: shadows,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Styles.RegularBaseColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 280,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        _touchedIndex = -1;
                        return;
                      }
                      _touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 64,
                sections: showingSections(),
              ),
            ),
          ),
          ..._statistics.keys.map((categoryType) {
            final percentage = double.parse(
                (_statistics[categoryType]! / _totalAmount * 100)
                    .toStringAsFixed(0));
            return BookkeepingDataRow(
              icon: BookkeepingItemCategoryMap[categoryType]!.icon,
              title: BookkeepingItemCategoryMap[categoryType]!.text,
              subTitle: '${percentage.toInt()}%',
              amount: _statistics[categoryType]!,
              type: _type,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
