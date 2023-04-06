import 'package:flutter/material.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/transition_route.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/keys.dart';

bool _toastShowing = false;
bool _isLoadingToast = false;
late OverlayEntry _overlayEntry;

abstract class Toast {
  static void show(
    BuildContext context, {
    String text = '',
    bool loading = false,
  }) async {
    _isLoadingToast = loading;
    if (!_toastShowing) {
      _toastShowing = true;
      Widget toast = Container(
        width: MEAS.loadingToastLength,
        height: loading ? MEAS.loadingToastLength : MEAS.toastLength,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MEAS.loadingToastRadius),
          color: Styles.PrimaryTextColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading) ...[
              SizedBox(
                child: CircularProgressIndicator(
                  color: Styles.RegularBaseColor,
                  backgroundColor: Colors.transparent,
                  strokeWidth: 2,
                ),
                height: MEAS.loadingToastIconLength,
                width: MEAS.loadingToastIconLength,
              ),
              SizedBox(height: 16),
            ],
            if (text.trim() != '')
              TextBuilder(
                text,
                color: Styles.RegularBaseColor,
                fontSize: Styles.textSize,
                lineHeight: Styles.textLineHeight,
              ),
          ],
        ),
      );
      if (_isLoadingToast) {
        Navigator.push(
          context,
          TransitionRouteBuilder(
            Scaffold(
              key: Keys.toast,
              backgroundColor: Colors.transparent,
              body: Center(
                child: toast,
              ),
            ),
          ),
        );
      } else {
        _overlayEntry = OverlayEntry(
          builder: (context) => AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _toastShowing ? 1 : 0,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 160),
                child: toast,
              ),
            ),
            curve: Curves.ease,
          ),
        );

        Overlay.of(context).insert(_overlayEntry);
        await Future.delayed(const Duration(milliseconds: 1200));
        _toastShowing = false;
        _overlayEntry.markNeedsBuild();
        Future.delayed(
          const Duration(milliseconds: 300),
          () => _overlayEntry.remove(),
        );
      }
    }
  }

  static close() {
    if (_toastShowing) {
      _toastShowing = false;
      if (_isLoadingToast) {
        Navigator.pop(Keys.toast.currentContext!);
      } else {
        _overlayEntry.remove();
      }
    }
  }
}
