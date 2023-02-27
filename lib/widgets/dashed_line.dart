import 'package:flutter/cupertino.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:doit/constants/colors.dart';
import 'package:doit/constants/meas.dart';

DottedLine dashedLine() => DottedLine(
      dashLength: MEAS.dashLength,
      dashGapLength: MEAS.dashGapLength,
      direction: Axis.vertical,
      dashColor: Colors.DashedLineColor,
      lineThickness: MEAS.lineThickness,
      dashRadius: MEAS.dashRadius,
    );
