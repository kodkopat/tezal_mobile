// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market/market_comments_result_model.dart';
import 'comments_list_item.dart';

class CommentsList extends StatelessWidget {
  CommentsList({
    required this.comments,
    required this.itemAbsorbing,
    required this.onItemTap,
  });

  final List<MarketComment> comments;
  final bool Function(int) itemAbsorbing;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return comments.isEmpty
        ? _emptyState
        : ListView.builder(
            shrinkWrap: true,
            itemCount: comments.length,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => CommentsListItem(
              comment: comments[index],
              absorbing: itemAbsorbing(index),
              onTap: () => onItemTap(index),
            ),
          );
  }

  Widget get _emptyState => Txt(
        "لیست نظرات خالی است",
        style: AppTxtStyles().body..alignment.center(),
      );
}
