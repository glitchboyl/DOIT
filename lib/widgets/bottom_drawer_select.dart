import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/constants/styles.dart';

class BottomDrawerSelect<T> extends StatelessWidget {
  const BottomDrawerSelect({
    super.key,
    required this.title,
    required this.selectList,
    required this.itemBuilder,
    required this.onSelected,
  });
  final String title;
  final List<T> selectList;
  final Widget Function(T, int) itemBuilder;
  final void Function(T, int) onSelected;

  List<Widget> _buildSelectWidgets(BuildContext context) {
    final List<Widget> _selectWidgets = [];
    for (int i = 0; i < selectList.length; i++) {
      final item = selectList[i];
      _selectWidgets.add(
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: itemBuilder(item, i),
          onTap: () => {
            onSelected(item, i),
            Navigator.of(context).pop(),
          },
        ),
      );
    }
    return _selectWidgets;
  }

  @override
  Widget build(context) => Wrap(
        children: <Widget>[
          AppBarBuilder(
            title: TextBuilder(
              title,
              color: Styles.PrimaryTextColor,
              fontSize: Styles.largeTextSize,
              lineHeight: Styles.largeTextLineHeight,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: _buildSelectWidgets(context),
            ),
          ),
        ],
      );
}
