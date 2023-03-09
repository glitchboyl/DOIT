import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableActionBuilder extends StatelessWidget {
  const SlidableActionBuilder({
    super.key,
    required this.color,
    required this.onPressed,
    required this.child,
    this.autoClose = false,
  });

  final Color color;
  final void Function(BuildContext)? onPressed;
  final Widget child;
  final bool autoClose;

  @override
  Widget build(BuildContext context) => CustomSlidableAction(
        padding: EdgeInsets.zero,
        backgroundColor: color,
        foregroundColor: color,
        onPressed: onPressed,
        child: child,
        autoClose: autoClose,
      );
}
