// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/dashed_line_painter.dart';

class OrderDetailStatusTimeLime extends StatelessWidget {
  OrderDetailStatusTimeLime({required this.status});

  final String status;

  final List<String> _orderStatusList = [
    "سفارش جدید", // new_order,
    "سفارش تایید شده", // approved,
    "سفارش تایید نشده", // rejected,
    "سفارش در حال آماده‌سازی", // preparing,
    "سفارش در حال تحویل", // ondelivery,
    "سفارش تحویل شده", // delivered,
    "سفارش لغو شده", // canceled,
    "سفارش بازگشتی", // returned
  ];

  @override
  Widget build(BuildContext context) {
    // final statusIndex = _orderStatusList.indexOf(status);
    final statusIndex = 4;

    return Parent(
      style: ParentStyle()
        ..padding(vertical: 16)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        )
        ..ripple(true),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Txt(
            "وضعیت فعلی سفارش",
            style: AppTxtStyles().body
              ..padding(horizontal: 16)
              ..alignmentContent.centerRight()
              ..bold(),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              iconList(statusIndex),
              Expanded(
                flex: 1,
                child: descriptionList(statusIndex),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget iconList(int statusIndex) => SizedBox(
        width: 30 + 16 + 16,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _orderStatusList.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Parent(
                  style: ParentStyle()
                    ..width(0.5)
                    ..height(6)
                    ..background.color(
                        index == 0 ? Colors.transparent : Colors.black12),
                ),
                Parent(
                  style: ParentStyle()
                    ..width(30)
                    ..height(30)
                    ..margin(horizontal: 16)
                    ..borderRadius(all: 15)
                    ..alignmentContent.center()
                    ..background.color(
                      index == statusIndex
                          ? Theme.of(context).primaryColor.withOpacity(0.2)
                          : Color(0xffEFEFEF),
                    ),
                  child: Txt(
                    "${index + 1}",
                    style: AppTxtStyles().footNote
                      ..textColor(index == statusIndex
                          ? Theme.of(context).primaryColor
                          : Colors.black)
                      ..bold(),
                  ),
                ),
                Parent(
                  style: ParentStyle()
                    ..width(0.5)
                    ..height(6)
                    ..background.color(
                      index == _orderStatusList.length - 1
                          ? Colors.transparent
                          : Colors.black12,
                    ),
                ),
              ],
            );
          },
        ),
      );

  Widget descriptionList(int statusIndex) => ListView.separated(
        shrinkWrap: true,
        itemCount: _orderStatusList.length,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Parent(
            style: ParentStyle()
              ..height(30)
              ..margin(vertical: 6),
            child: Txt(
              "${_orderStatusList[index]}",
              style: AppTxtStyles().footNote..alignmentContent.centerRight(),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return CustomPaint(painter: DashedLinePainter());
        },
      );
}
