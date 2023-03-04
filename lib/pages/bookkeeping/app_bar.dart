import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/constants/styles.dart';

class BookkeepingPageAppBar extends AppBarBuilder {
  const BookkeepingPageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        title: TextBuilder(
          '记账',
          color: Styles.RegularBaseColor,
          fontWeight: FontWeight.bold,
          fontSize: Styles.largeTextSize,
          lineHeight: Styles.largeTextLineHeight,
        ),
        backgroundColor: Colors.transparent,
      );
}
