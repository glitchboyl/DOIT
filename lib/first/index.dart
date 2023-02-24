import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../styles.dart';
import 'item.dart';

class FirstTab extends StatefulWidget {
  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  List<int> top = <int>[0];
  List<int> bottom = <int>[0];

  @override
  Widget build(BuildContext context) {
    // const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return CupertinoTabView(builder: (context) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Styles.navigatorBarColor,
          middle: const Text('聚焦'),
          border: Border(
            bottom: BorderSide(color: Styles.navigatorBarColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: CustomScrollView(
            slivers: [
              SliverSafeArea(
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Item(
                        'Hello World',
                        time: ItemTime(from: DateTime(2023, 2, 27), to: DateTime(2023, 2, 26)),
                      );
                    },
                    childCount: 10,
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Styles.generalBackgroundColor,
      );
    });
  }
}