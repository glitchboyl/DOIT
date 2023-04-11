import 'package:flutter/widgets.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/constants/styles.dart';

class CalendarViewToDoItem extends StatelessWidget {
  const CalendarViewToDoItem(
    this.item, {
    super.key,
  });

  final ToDoItem item;

  @override
  Widget build(BuildContext context) => Container(
        height: 14,
        margin: EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: item.typeColor(context).withOpacity(0.16),
        ),
        child: Row(
          children: [
            Container(
              width: 2,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(1),
                ),
                color: item.levelColor(context),
              ),
            ),
            SizedBox(width: 2),
            Expanded(
              child: Text(
                item.title,
                style: TextStyles.tinyTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                // maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
