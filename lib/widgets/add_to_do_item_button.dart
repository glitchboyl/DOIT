import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/styles.dart';

Widget addToDoItemButton(Function() onPressed) => Positioned(
      right: 0,
      bottom: 48,
      child: Container(
        width: 52.w,
        height: 52.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Styles.AddToDoItemButtonShadowColor,
              offset: Offset(0, 12), //阴影y轴偏移量
              blurRadius: 18, //阴影模糊程度
              spreadRadius: -4, //阴影扩散程度
            ),
          ],
        ),
        child: CupertinoButton(
          color: Styles.AddToDoItemButtonColor,
          padding: EdgeInsets.zero,
          pressedOpacity: 0.8,
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 28.sp,
              color: CupertinoColors.white,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
