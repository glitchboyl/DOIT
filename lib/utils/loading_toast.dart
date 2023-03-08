import 'package:flutter/material.dart';
import 'package:doit/widgets/transition_route.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool toastShowing = false;

abstract class LoadingToast {
  static show(
    BuildContext context, {
    String text = '',
  }) {
    if (!toastShowing) {
      toastShowing = true;
      Navigator.push(
        context,
        TransitionRouteBuilder(
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: MEAS.loadingToastLength,
                height: MEAS.loadingToastLength,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MEAS.loadingToastRadius),
                  color: Styles.PrimaryTextColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: CircularProgressIndicator(
                        color: Styles.RegularBaseColor,
                        backgroundColor: Colors.transparent,
                        strokeWidth: 2.w,
                      ),
                      height: MEAS.loadingToastIconLength,
                      width: MEAS.loadingToastIconLength,
                    ),
                    if (text.trim() != '') ...[
                      SizedBox(height: 16.h),
                      TextBuilder(
                        text,
                        color: Styles.RegularBaseColor,
                        fontSize: Styles.textSize,
                        lineHeight: Styles.textLineHeight,
                      )
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  static close(BuildContext context) {
    if (toastShowing) {
      toastShowing = false;
      Navigator.pop(context);
    }
  }
}
