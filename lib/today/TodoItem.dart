import 'package:flutter/material.dart';
import 'package:DO_IT/utils/Adapt.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final String type;
  final int priority;
  final String time;
  final bool isComplete;

  TodoItem({
    @required this.title,
    @required this.type,
    @required this.priority,
    @required this.time,
    @required this.isComplete,
  });

  getTodoItemStyle() {
    String type;
    List colors = [
      Color(0xFF4BEB9B),
      Color(0xFF3DCFFF),
      Color(0xFFFFD739),
      Color(0xFFFF4242)
    ];

    switch (this.type.toLowerCase()) {
      case 'work':
        type = 'work';
        break;
      case 'study':
        type = 'study';
        break;
      default:
        type = 'daily';
        break;
    }

    return {
      'icon':
          'assets/today/todo-item/$type${this.isComplete != null && this.isComplete ? '-completed' : ''}.png',
      'color': this.isComplete != null && this.isComplete
          ? Color(0xFFBECFEB)
          : colors[this.priority],
      'textColor': this.isComplete != null && this.isComplete
          ? Color(0xFFBECFEB)
          : Color(0xFF373655),
      'arrow':
          'assets/today/todo-item/entry-arrow${this.isComplete != null && this.isComplete ? '-completed' : ''}.png',
    };
  }

  Widget build(BuildContext context) {
    var todoItemStyle = getTodoItemStyle();
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Adapt.px(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: Adapt.px(10),
            height: Adapt.px(40),
            decoration: BoxDecoration(
              color: todoItemStyle['color'],
              borderRadius: BorderRadius.all(Radius.circular(Adapt.px(5))),
            ),
          ),
          Container(
            width: Adapt.px(1027),
            height: Adapt.px(174),
            margin: EdgeInsets.only(left: Adapt.px(20)),
            padding: EdgeInsets.only(left: Adapt.px(36), right: Adapt.px(52.5)),
            decoration: BoxDecoration(
              color: Color(0xFFF4FAFF),
              borderRadius: BorderRadius.all(Radius.circular(Adapt.px(89))),
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  todoItemStyle['icon'],
                  width: Adapt.px(102),
                  height: Adapt.px(102),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adapt.px(24)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.title,
                          style: TextStyle(
                            color: todoItemStyle['textColor'],
                            fontSize: Adapt.px(44),
                          ),
                        ),
                        Text(
                          this.time,
                          style: TextStyle(
                            color: todoItemStyle['textColor'],
                            fontSize: Adapt.px(28),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Image.asset(
                  todoItemStyle['arrow'],
                  width: Adapt.px(21.5),
                  height: Adapt.px(37.1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
