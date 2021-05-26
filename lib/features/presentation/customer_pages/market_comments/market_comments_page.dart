// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/comment_list/comment_list.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../customer_providers/market_comments_notifier.dart';

class MarketCommentsPage extends StatelessWidget {
  static const route = "/customer_market_comments";

  MarketCommentsPage({required this.marketId});

  final String marketId;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<MarketCommentsNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchCommentsCalled) {
          provider.fetchComments(context, marketId: marketId);
        }

        return provider.loading
            ? Center(child: AppLoading())
            : provider.comments == null
                ? provider.errorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.errorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommentList(comments: provider.comments!),
                        if (provider.enableLoadMoreOption!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchComments(context, marketId: marketId);
                          }),
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "نظرات فروشگاه",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
