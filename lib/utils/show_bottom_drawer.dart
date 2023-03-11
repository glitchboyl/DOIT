import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

final showBottomDrawer = ({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  Color backgroundColor = Styles.RegularBaseColor,
  double? avoidBottomPadding,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: backgroundColor,
    barrierColor: Styles.BarrierColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.vertical(
        top: Radius.circular(MEAS.bottomDrawerRadius),
      ),
    ),
    clipBehavior: Clip.antiAlias,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
          return false;
        }
        return true;
      },
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom == 0
              ? MediaQuery.of(context).viewInsets.bottom
              : avoidBottomPadding ?? MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: builder(context),
        ),
      ),
    ),
  );
};
