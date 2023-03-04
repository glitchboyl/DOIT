import 'package:doit/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/constants/meas.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class ExpansionTileBuilder extends StatefulWidget {
  const ExpansionTileBuilder(
      {super.key, required this.title, this.children = const <Widget>[]});
  final Widget title;
  final List<Widget> children;

  @override
  State<ExpansionTileBuilder> createState() => _ExpansionTileState();

  // static _ExpansionTileState of(BuildContext context) {
  //   print('asdasd');
  //   final _ExpansionTileState? result =
  //       context.findAncestorStateOfType<_ExpansionTileState>();
  //   if (result != null) {
  //     return result;
  //   }
  //   throw FlutterError.fromParts([]);
  // }
}

class _ExpansionTileState extends State<ExpansionTileBuilder>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });
  }

  Widget _buildChildren(BuildContext context, Widget? child) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Row(
                children: [
                  Expanded(child: widget.title),
                  RotationTransition(
                    turns: _iconTurns,
                    child: SVGIcon(
                      icon: 'assets/images/arrow.svg',
                      width: MEAS.drawerExpandArrowWidth,
                      height: MEAS.drawerExpandArrowHeight,
                    ),
                  ),
                  SizedBox(width: 16.w)
                ],
              ),
              onTap: _handleTap,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: _heightFactor.value,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: Offstage(
        offstage: closed,
        child: TickerMode(
          enabled: !closed,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }
}
