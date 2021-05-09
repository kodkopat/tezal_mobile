// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/comments_notifier.dart';
import 'widgets/comments_list.dart';

class CommentsPage extends StatelessWidget {
  static const route = "/market_comments";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<CommentsNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchCommentsCalled) {
          provider.fetchComments(context);
        }

        return provider.commentsLoading
            ? Center(child: AppLoading())
            : provider.marketComments == null
                ? provider.commentsErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.commentsErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommentsList(comments: provider.marketComments!),
                        const SizedBox(height: 8),
                        if (provider.commentsEnableLoadMoreData!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchComments(context);
                          }),
                        const SizedBox(height: 8),
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
