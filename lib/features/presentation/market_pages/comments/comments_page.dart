// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/comments_notifier.dart';
import '../comment_reply/comment_reply.dart';
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

        return provider.loading
            ? Center(child: AppLoading())
            : provider.marketComments == null
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
                        CommentsList(
                          comments: provider.marketComments!,
                          onItemTap: (index) {
                            Routes.sailor.navigate(
                              CommentReplyPage.route,
                              params: {
                                "marketComment": provider.marketComments![index]
                              },
                            );
                          },
                        ),
                        if (provider.enableLoadMoreOption!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchComments(context);
                          }),
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).marketCommentsPage,
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
