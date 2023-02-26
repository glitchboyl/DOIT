import 'package:flutter/cupertino.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/styles.dart';

DottedLine dashedLine() => DottedLine(
      dashLength: 3.2.h,
      direction: Axis.vertical,
      dashColor: Styles.DashedLineColor,
      lineThickness: 2.w,
    );
