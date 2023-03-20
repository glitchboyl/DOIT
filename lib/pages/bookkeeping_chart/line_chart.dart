import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/constants/styles.dart';

class BookkeepingLineChart extends StatelessWidget {
  const BookkeepingLineChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: 192,
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Styles.RegularBaseColor,
        ),
        child: LineChart(
          chartData,
          swapAnimationDuration: const Duration(milliseconds: 250),
        ),
      );

  LineChartData get chartData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxY: 4,
        maxX: 14,
        minY: 0,
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Styles.BackgroundColor.withOpacity(0.9),
          tooltipPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              if (flSpot.x == 0 || flSpot.x == 6) {
                return null;
              }

              return LineTooltipItem(
                '2022\n',
                TextStyle(
                  color: Styles.PrimaryColor,
                  fontSize: Styles.tinyTextSize,
                  height: Styles.tinyTextLineHeight / Styles.tinyTextSize,
                ),
                children: [
                  TextSpan(
                      // text: flSpot.y.toString(),
                      text: '收入：478,971.74'),
                ],
                textAlign: TextAlign.left,
              );
            }).toList();
          },
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
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '12w';
        break;
      case 2:
        text = '24w';
        break;
      case 3:
        text = '36w';
        break;
      case 4:
        text = '48w';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return SizedBox.shrink();
    }

    return TextBuilder(
      text,
      color: Styles.PrimaryTextColor,
      fontSize: Styles.tinyTextSize,
      lineHeight: Styles.tinyTextLineHeight,
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 34,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 1:
        text = '2017';
        break;
      case 3:
        text = '2018';
        break;
      case 5:
        text = '2019';
        break;
      case 7:
        text = '2020';
        break;
      case 9:
        text = '2021';
        break;
      case 11:
        text = '2022';
        break;
      case 13:
        text = '2023';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 3,
      child: TextBuilder(
        text,
        color: Styles.PrimaryTextColor,
        fontSize: Styles.tinyTextSize,
        lineHeight: Styles.tinyTextLineHeight,
      ),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 14,
        interval: 1,
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
        color: Styles.PrimaryColor,
        barWidth: 6,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(9, 2),
          FlSpot(11, 2.2),
          FlSpot(13, 1.8),
        ],
      );
}
