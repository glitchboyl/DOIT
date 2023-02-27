import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/constants/styles.dart';

class ThirdTab extends StatefulWidget {
  @override
  _ThirdTabState createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: const Text('Third')),
      body: Container(
        child: Text('boy next door'),
      ),
      backgroundColor: Styles.GeneralBackgroundColor,
    );
  }
}
