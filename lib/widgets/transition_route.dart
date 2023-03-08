import 'package:flutter/material.dart';

//自定义的路由方法
class TransitionRouteBuilder extends PageRouteBuilder {
  final Widget widget;
  @override
  bool get opaque => false;
  TransitionRouteBuilder(
    this.widget, {
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) : super(
          transitionDuration: transitionDuration,
          //页面的构造器
          pageBuilder: (
            BuildContext context,
            Animation<double> animation1,
            Animation<double> animation2,
          ) {
            return widget;
          },
          //过度效果
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation1,
            Animation<double> animation2,
            Widget child,
          ) {
            // 过度的动画的值
            return FadeTransition(
              // 过度的透明的效果
              opacity: Tween(begin: 0.0, end: 1.0)
                  // 给他个透明度的动画   CurvedAnimation：设置动画曲线
                  .animate(
                CurvedAnimation(
                  //父级动画
                  parent: animation1,
                  //动画曲线
                  curve: Curves.ease,
                ),
              ),
              child: child,
            );
          },
        );
}
