import 'package:flutter/material.dart';
import 'package:DO_IT/utils/Adapt.dart';
import 'package:DO_IT/home/TodoItem.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List dataList = [
    {
      'title': '墨鱼丸项目',
      'type': 'work',
      'priority': 3,
      'isComplete': false,
      'time': '14:00-18:00'
    },
    {
      'title': '叮当小程序修改',
      'type': 'work',
      'priority': 3,
      'isComplete': false,
      'time': '10:00-12:00'
    },
    {
      'title': '每天阅读1小时',
      'type': 'study',
      'priority': 2,
      'isComplete': false,
      'time': '每天重复'
    },
    {
      'title': '傻宝贝今天生日',
      'type': 'daily',
      'priority': 2,
      'isComplete': false,
      'time': '19:00-21:00'
    },
    {
      'title': '今天你喝水了吗',
      'type': 'daily',
      'priority': 0,
      'isComplete': true,
      'time': '每天重复'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '今日',
          style: TextStyle(
            color: Colors.black,
            fontSize: Adapt.px(60),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/home/more.png',
              width: Adapt.px(54),
              height: Adapt.px(12),
            ),
            color: Colors.white,
            splashColor: Colors.white,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            highlightColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(
            width: Adapt.px(34),
            height: 1,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            var model = dataList[index];
            return TodoItem(
              title: model['title'],
              type: model['type'],
              priority: model['priority'],
              time: model['time'],
              isComplete: model['isComplete'],
            );
          },
        ),
      ),
    );
  }
}
