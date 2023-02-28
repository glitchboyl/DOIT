import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/keys.dart';

class ThirdTab extends StatefulWidget {
  @override
  ThirdTabState createState() => ThirdTabState();
}

class ThirdTabState extends State<ThirdTab> {
  @override
  Widget build(BuildContext context) => Scaffold(
        key: Keys.Third,
        appBar: AppBarBuilder(title: const Text('Third')),
        body: Container(
          child: Text('boy next door'),
        ),
        // backgroundColor: Styles.PageBackgroundColor,
      );
}
