import 'package:flutter/material.dart';
import 'dart:ui';

class Adapt {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static double width = mediaQuery.size.width;
  static double height = mediaQuery.size.height;
  static double topbarH = mediaQuery.padding.top;
  static double botbarH = mediaQuery.padding.bottom;
  static double pixelRatio = mediaQuery.devicePixelRatio;
  static var ratio;

  static init(int number) {
    int uiwidth = number is int ? number : 750;
    ratio = width / uiwidth;
  }

  static px(number) {
    if (!(ratio is double || ratio is int)) {
      Adapt.init(1125);
    }
    return number * ratio;
  }

  static onepx() {
    return 1 / pixelRatio;
  }

  static screenW() {
    return width;
  }

  static screenH() {
    return height;
  }

  static padTopH() {
    return topbarH;
  }

  static padBotH() {
    return botbarH;
  }
}
