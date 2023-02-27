import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/svg.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/constants/colors.dart';
import 'package:doit/constants/meas.dart';

class SimpleToDoItemWidget extends StatelessWidget {
  const SimpleToDoItemWidget(this.item);

  final ToDoItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CupertinoColors.white,
      ),
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 12,
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            width: MEAS.simpleToDoItemLevelWidth,
            height: MEAS.simpleToDoItemLevelHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
              color: item.levelColor,
            ),
          ),
          Container(
            width: MEAS.simpleToDoItemTypeWidth,
            height: MEAS.simpleToDoItemTypeHeight,
            margin: const EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: item.typeColor,
            ),
            child: svg(
              item.typeIcon,
              width: MEAS.simpleToDoItemTypeIconWidth,
              height: MEAS.simpleToDoItemTypeIconHeight,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.title,
                style: TextStyle(
                  color: Colors.ToDoItemTitleColor,
                  fontSize: 14.sp,
                  height: 20.sp / 14.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                getToDoItemTime(to: item.to, from: item.from),
                style: TextStyle(
                  color: Colors.ToDoItemTimeColor,
                  fontSize: 10.sp,
                  height: 14.sp / 10.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
