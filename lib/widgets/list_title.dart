import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';

class ListTitle extends StatelessWidget {
  const ListTitle(
    this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(
          top: 12,
        ),
        child: Text(
          title,
          style: TextStyles.smallTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primaryTextColor,
          ),
        ),
      );
}
