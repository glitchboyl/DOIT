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
        color: Styles.RegularBaseColor,
        width: double.infinity,
        height: 192,
        child: LineChart(
          sampleData1,
          swapAnimationDuration: const Duration(milliseconds: 250),
        ),
      );

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxY: 4,
        maxX: 14,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Styles.BackgroundColor.withOpacity(0.8),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              if (flSpot.x == 0 || flSpot.x == 6) {
                return null;
              }

              TextAlign textAlign;
              switch (flSpot.x.toInt()) {
                case 1:
                  textAlign = TextAlign.left;
                  break;
                case 5:
                  textAlign = TextAlign.right;
                  break;
                default:
                  textAlign = TextAlign.center;
              }

              return LineTooltipItem(
                'ass we can',
                TextStyle(),
                children: [
                  TextSpan(
                    text: flSpot.y.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  // const TextSpan(
                  //   text: 'calories',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.normal,
                  //   ),
                  // ),
                ],
                textAlign: textAlign,
              );
            }).toList();
          },
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
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

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
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
        reservedSize: 32,
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

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
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
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );
}
