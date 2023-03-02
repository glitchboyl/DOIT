import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/constants/styles.dart';

class SimpleToDoListTitle extends StatelessWidget {
  const SimpleToDoListTitle(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(
            top: 12.h,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: Styles.smallTextSize,
              height: Styles.smallTextLineHeight / Styles.smallTextSize,
              color: Styles.PrimaryTextColor,
            ),
          ),
        ),
      );
}
