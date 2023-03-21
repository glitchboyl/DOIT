import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:doit/widgets/icon.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/bookkeeping_data_row.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

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
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
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
          BookkeepingDataRow(
            icon: 'assets/images/bookkeeping_food_and_drink.svg',
            title: '饮食',
            subTitle: '43%',
            amount: 520,
            type: BookkeepingItemType.Expenses,
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
          BookkeepingDataRow(
            icon: 'assets/images/bookkeeping_food_and_drink.svg',
            title: '饮食',
            subTitle: '43%',
            amount: 520,
            type: BookkeepingItemType.Expenses,
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 24.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              color: Styles.PrimaryTextColor,
              // shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              color: Styles.PrimaryTextColor,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              color: Styles.PrimaryTextColor,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 2.8,
            title: '2.8%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              color: Styles.PrimaryTextColor,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
