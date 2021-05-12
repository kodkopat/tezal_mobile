// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/order_comments_notifier.dart';
import '../order_comment_reply/order_comment_reply_page.dart';
import 'widgets/order_comments_list.dart';

class OrderCommentsPage extends StatelessWidget {
  static const route = "/market_order_comments";

  OrderCommentsPage({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<OrderCommentsNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchCommentsCalled) {
          provider.fetchComments(context, orderId: orderId);
        }

        return provider.commentsLoading
            ? Center(child: AppLoading())
            : provider.orderComments == null
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
                        OrderCommentsList(
                          comments: provider.orderComments!,
                          onItemTap: (index) {
                            Routes.sailor.navigate(
                              OrderCommentReplyPage.route,
                              params: {
                                "orderComment": provider.orderComments![index]
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        if (provider.commentsEnableLoadMoreData!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchComments(context, orderId: orderId);
                          }),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "نظرات سفارش",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
