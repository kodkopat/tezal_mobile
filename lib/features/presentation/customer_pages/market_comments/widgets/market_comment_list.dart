import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market_comments_result_model.dart';
import '../../../widgets/../customer_pages/market_comments/widgets/market_comment_list_item.dart';
import '../../../widgets/../customer_pages/market_comments/widgets/market_comment_list_show_more_btn.dart';
import '../market_comments_page.dart';

class MarketCommentList extends StatelessWidget {
  const MarketCommentList({
    Key key,
    @required this.marketId,
    @required this.marketComments,
    @required this.enableLoadMore,
  }) : super(key: key);

  final String marketId;
  final MarketCommentsResultModel marketComments;
  final bool enableLoadMore;

  @override
  Widget build(BuildContext context) {
    var comments = marketComments.data;

    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                gesture: Gestures()
                  ..onTap(() {
                    Routes.sailor.navigate(
                      MarketCommentsPage.route,
                      params: {
                        "marketId": marketId,
                      },
                    );
                  }),
                style: AppTxtStyles().footNote
                  ..borderRadius(all: 4)
                  ..margin(top: 2)
                  ..padding(horizontal: 4, vertical: 2)
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
                    return MarketCommentListItem(
                      comment: comments[index],
                      onTap: () {},
                    );
                  } else {
                    return MarketCommentListShowMoreBtn(
                      text: "مشاهده همه نظرات",
                      onTap: () {
                        Routes.sailor.navigate(
                          MarketCommentsPage.route,
                          params: {
                            "marketId": marketId,
                          },
                        );
                      },
                    );
                  }
                }
              : (context, index) {
                  return MarketCommentListItem(
                    comment: comments[index],
                    onTap: () {},
                  );
                },
        ),
      ],
    );
  }
}
