import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

final showBottomDrawer = ({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  Color? backgroundColor,
  double? avoidBottomPadding,
  void Function()? onDismissed,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: backgroundColor ?? colorScheme.backgroundColor,
    barrierColor: colorScheme.barrierColor,
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
        padding: EdgeInsets.only(
          bottom: () {
            final viewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;
            if (avoidBottomPadding != null) {
              return viewInsetsBottom -
                  (avoidBottomPadding > viewInsetsBottom
                      ? viewInsetsBottom
                      : avoidBottomPadding);
            } else {
              return viewInsetsBottom;
            }
          }(),
        ),
        child: SafeArea(
          child: builder(context),
        ),
      ),
    ),
  ).then(
    (_) => onDismissed != null ? onDismissed() : null,
  );
};
