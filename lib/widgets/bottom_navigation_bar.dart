import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BottomNavigationBarBuilder extends StatelessWidget {
  const BottomNavigationBarBuilder(
      {required this.items, required this.currentIndex, required this.onTap});

  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.BottomNavigationBarColor,
      child: SafeArea(
        child: SizedBox(
          height: MEAS.bottomNavigationBarHeight,
          child: BottomNavigationBar(
            elevation: 0,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Styles.BottomNavigationBarColor,
            items: items,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
