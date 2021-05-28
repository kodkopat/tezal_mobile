// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market/order_comments_result_model.dart';
import 'order_comments_list_item.dart';

class OrderCommentsList extends StatelessWidget {
  OrderCommentsList({
    required this.comments,
    required this.onItemTap,
    this.showAllCommentOnTap,
    this.enableHeader,
  });

  final List<OrderComment> comments;
  final void Function(int) onItemTap;
  final VoidCallback? showAllCommentOnTap;
  final bool? enableHeader;

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (enableHeader ?? false)
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 4, 0),
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  "نظرات کاربران",
                  style: AppTxtStyles().body..bold(),
                ),
                Txt(
                  "مشاهده همه نظرات \u00BB",
                  gesture: Gestures()..onTap(showAllCommentOnTap ?? () {}),
                  style: AppTxtStyles().footNote
                    ..margin(top: 2)
                    ..padding(horizontal: 4, vertical: 2)
                    ..borderRadius(all: 4)
                    ..ripple(true),
                ),
              ],
            ),
          ),
        comments.isEmpty
            ? _emptyState
            : ListView.builder(
                shrinkWrap: true,
                itemCount: comments.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => OrderCommentsListItem(
                  comment: comments[index],
                  onTap: () => onItemTap(index),
                ),
              ),
      ],
    );
  }

  Widget get _emptyState => Txt(
        "لیست نظرات خالی است",
        style: AppTxtStyles().body..alignment.center(),
      );
}
