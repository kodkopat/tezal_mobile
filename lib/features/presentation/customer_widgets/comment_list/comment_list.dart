// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/comments_result_model.dart';
import 'comment_list_item.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    required this.comments,
    required this.showAllCommentOnTap,
    required this.enableHeader,
  });

  final List<Comment> comments;
  final void Function() showAllCommentOnTap;
  final bool enableHeader;

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (enableHeader)
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
                  gesture: Gestures()..onTap(showAllCommentOnTap),
                  style: AppTxtStyles().footNote
                    ..margin(top: 2)
                    ..padding(horizontal: 4, vertical: 2)
                    ..borderRadius(all: 4)
                    ..ripple(true),
                ),
              ],
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: comments.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => CommentListItem(
            comment: comments[index],
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
