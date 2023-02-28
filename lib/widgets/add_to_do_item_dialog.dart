import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/app_bar_icon_button.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

UnderlineInputBorder titleBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: Styles.ToDoItemTitleInputColor, width: 2.h),
);
UnderlineInputBorder descriptionBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.transparent,
  ),
);

// ignore: must_be_immutable
class AddToDoItemDialog extends StatelessWidget {
  bool _sendActived = false;
  String _title = '';
  String _description = '';

  bool validate() => _title.trim() != '' && _description != '';

  @override
  Widget build(context) => StatefulBuilder(
        builder: (context, setState) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SafeArea(
              child: Container(
                height: MEAS.addToDoItemDialogHeight,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: radius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppBarBuilder(
                      title: Text(
                        '添加日程',
                        style: TextStyle(
                          color: Styles.TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: MEAS.largeTextSize,
                          height: MEAS.largeTextLineHeight / MEAS.largeTextSize,
                        ),
                      ),
                      trailing: AppBarIconButton(
                        icon:
                            'assets/images/send${_sendActived ? '' : '_disabled'}.svg',
                        onPressed: () => {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 12.h),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    (MEAS.addToDoItemDialogTitleInputHeight -
                                            MEAS.textLineHeight) /
                                        2.h,
                              ),
                              hintText: '有好计划吗，快记录下来吧…',
                              hintStyle: const TextStyle(
                                color: Styles.ToDoItemTitleHintColor,
                              ),
                              border: titleBorder,
                              focusedBorder: titleBorder,
                              enabledBorder: titleBorder,
                            ),
                            style: TextStyle(
                              color: Styles.TextColor,
                              fontSize: MEAS.textSize,
                              height: MEAS.textLineHeight / MEAS.textSize,
                            ),
                            onChanged: (value) => setState(() {
                              _title = value;
                              _sendActived = validate();
                            }),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    (MEAS.addToDoItemDialogDescriptionInputHeight -
                                            MEAS.smallTextLineHeight) /
                                        2.h,
                              ),
                              hintText: '描述信息',
                              hintStyle: const TextStyle(
                                color: Styles.ToDoItemTitleHintColor,
                              ),
                              border: descriptionBorder,
                              focusedBorder: descriptionBorder,
                              enabledBorder: descriptionBorder,
                              // hintStyle:
                            ),
                            style: TextStyle(
                              color: Styles.TextColor,
                              fontSize:
                                  MEAS.addToDoItemDialogDescriptionTextSize,
                              height: MEAS.smallTextLineHeight /
                                  MEAS.addToDoItemDialogDescriptionTextSize,
                            ),
                            onChanged: (value) => setState(() {
                              _description = value;
                              _sendActived = validate();
                            }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      );

  static BorderRadiusGeometry radius = BorderRadiusDirectional.vertical(
    top: Radius.circular(MEAS.addToDoItemDialogRadius),
  );
}
