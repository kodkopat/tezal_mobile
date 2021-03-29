import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/comments_result_model.dart';
import 'comment_list_item.dart';
import 'comment_list_load_more_btn.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    Key key,
    @required this.commentsResultModel,
    @required this.showAllCommentOnTap,
    @required this.enableLoadMore,
    @required this.enableHeader,
  }) : super(key: key);

  final CommentsResultModel commentsResultModel;
  final void Function() showAllCommentOnTap;
  final bool enableLoadMore;
  final bool enableHeader;

  @override
  Widget build(BuildContext context) {
    var comments = commentsResultModel.data.comments;

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
          itemCount:
              enableLoadMore ?? false ? comments.length + 1 : comments.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: enableLoadMore ?? false
              ? (context, index) {
                  if (index != comments.length) {
                    return CommentListItem(
                      comment: comments[index],
                      onTap: () {},
                    );
                  } else {
                    return CommentListLoadMoreBtn(
                      text: "مشاهده موارد بیشتر",
                      onTap: () {},
                    );
                  }
                }
              : (context, index) {
                  return CommentListItem(
                    comment: comments[index],
                    onTap: () {},
                  );
                },
        ),
      ],
    );
  }
}
