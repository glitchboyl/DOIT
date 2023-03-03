import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/constants/styles.dart';

class BookkeepingPageAppBar extends AppBarBuilder {
  const BookkeepingPageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        title: Text(
          '记账',
          style: TextStyle(
            color: Styles.RegularBaseColor,
            fontWeight: FontWeight.bold,
            fontSize: Styles.largeTextSize,
            height: Styles.largeTextLineHeight / Styles.largeTextSize,
          ),
        ),
        backgroundColor: Colors.transparent,
      );
}
