import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/list_title.dart';
import 'package:doit/widgets/time_picker.dart';
import 'package:doit/widgets/time_picker_drawer.dart';
import 'line_chart.dart';
import 'category_chart.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/models/bookkeeping.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingChartPage extends StatefulWidget {
  const BookkeepingChartPage({super.key});
  @override
  _BookkeepingChartPageState createState() => _BookkeepingChartPageState();
}

class _BookkeepingChartPageState extends State<BookkeepingChartPage>
    with TickerProviderStateMixin {
  BookkeepingItemType _type = BookkeepingItemType.Expenses;
  late TabController _tabController;
  late TabController _typeTabController;
  BookkeepingChartViewType _viewType = BookkeepingChartViewType.Week;
  late DateTime _focusedTime;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
    _typeTabController = TabController(
      length: 2,
      initialIndex: _type.index,
      vsync: this,
    );
    _focusedTime = initialFocusedTime();
  }

  DateTime initialFocusedTime() {
    switch (_viewType) {
      case BookkeepingChartViewType.Overview:
        return DateTime(
          nowTime.year - 6,
        );
      case BookkeepingChartViewType.Year:
        return DateTime(
          nowTime.year,
        );
      case BookkeepingChartViewType.Month:
        return DateTime(
          nowTime.year,
          nowTime.month,
        );
      case BookkeepingChartViewType.Week:
      default:
        return DateTime(
          nowTime.year,
          nowTime.month,
          nowTime.day,
        ).subtract(
          Duration(
            days: nowTime.weekday - 1,
          ),
        );
    }
  }

  String getFocusedTimeText() {
    switch (_viewType) {
      case BookkeepingChartViewType.Year:
        return '${_focusedTime.year}年';
      case BookkeepingChartViewType.Month:
        return '${_focusedTime.year}.${_focusedTime.month}月';
      case BookkeepingChartViewType.Week:
      default:
        final _weekEnd =
            _focusedTime.add(Duration(days: 7 - _focusedTime.weekday));
        return '${!_focusedTime.isSameYear(nowTime) ? '${_focusedTime.year}.' : _focusedTime.isSameDay(
            nowTime.subtract(
              Duration(days: nowTime.weekday - 1),
            ),
          ) ? '本周 ' : ''}${fillDateZero(_focusedTime.month)}.${fillDateZero(_focusedTime.day)} - ${!_weekEnd.isSameYear(_focusedTime) && !_weekEnd.isSameYear(nowTime) ? '${_weekEnd.year}.' : ''}${fillDateZero(_weekEnd.month)}.${fillDateZero(_weekEnd.day)}';
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarBuilder(
          leading: SVGIconButton(
            Ico.Back,
            onPressed: () => Navigator.pop(context),
          ),
          title: TextBuilder(
            '图表',
            color: Styles.PrimaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: Styles.greatTextSize,
            lineHeight: Styles.greatTextLineHeight,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Styles.RegularBaseColor,
              padding: EdgeInsets.only(
                top: 4,
                left: 16,
                right: 16,
                bottom: 6,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Styles.BackgroundColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: TabBar(
                      padding: EdgeInsets.all(4),
                      controller: _tabController,
                      labelStyle: TextStyle(
                        fontSize: Styles.smallTextSize,
                      ),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: Styles.PrimaryColor,
                      ),
                      labelColor: Styles.RegularBaseColor,
                      unselectedLabelColor: Styles.PrimaryTextColor,
                      tabs: [
                        Tab(
                          text: '一周',
                        ),
                        Tab(
                          text: '整月',
                        ),
                        Tab(
                          text: '整年',
                        ),
                        Tab(
                          text: '总览',
                        ),
                      ],
                      onTap: (index) {
                        if (index != _viewType.index) {
                          setState(() {
                            _viewType = BookkeepingChartViewType.values[index];
                            _focusedTime = initialFocusedTime();
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      if (_viewType != BookkeepingChartViewType.Overview)
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              TextBuilder(
                                getFocusedTimeText(),
                                fontSize: Styles.textSize,
                                lineHeight: Styles.textLineHeight,
                              ),
                              SizedBox(width: 4),
                              RotatedBox(
                                quarterTurns: -1,
                                child: SVGIcon(
                                  Ico.Triangle,
                                  width: MEAS.arrowLength,
                                  height: MEAS.arrowLength,
                                ),
                              ),
                            ],
                          ),
                          onTap: () => showBottomDrawer(
                            context: context,
                            builder: (context) => TimePickerDrawer(
                              _focusedTime,
                              mode: _viewType == BookkeepingChartViewType.Month
                                  ? CupertinoDatePickerMode.ym
                                  : _viewType == BookkeepingChartViewType.Year
                                      ? CupertinoDatePickerMode.year
                                      : CupertinoDatePickerMode.week,
                              onConfirmed: (time) => setState(
                                () => _focusedTime = time,
                              ),
                            ),
                          ),
                        ),
                      Spacer(),
                      Container(
                        width: 96,
                        height: 28,
                        child: TabBar(
                          controller: _typeTabController,
                          labelStyle: TextStyle(
                            fontSize: Styles.smallTextSize,
                          ),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                            color: Styles.BackgroundColor,
                          ),
                          labelPadding: EdgeInsets.zero,
                          labelColor: Styles.PrimaryColor,
                          unselectedLabelColor: Styles.PrimaryTextColor,
                          tabs: [
                            Tab(
                              text: '收入',
                            ),
                            Tab(
                              text: '支出',
                            ),
                          ],
                          onTap: (index) {
                            if (index == 0 &&
                                _type != BookkeepingItemType.Incomes) {
                              setState(
                                () => {
                                  _type = BookkeepingItemType.Incomes,
                                },
                              );
                            } else if (index == 1 &&
                                _type != BookkeepingItemType.Expenses) {
                              setState(
                                () => {
                                  _type = BookkeepingItemType.Expenses,
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ListView(
                  children: [
                    BookkeepingLineChart(
                      focusedTime: _focusedTime,
                      type: _type,
                      viewType: _viewType,
                    ),
                    ListTitle(
                      '分类统计',
                    ),
                    BookkeepingCategoryChart(
                      focusedTime: _focusedTime,
                      type: _type,
                      viewType: _viewType,
                    ),
                    SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
