// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/product_comments_notifier.dart';
import '../product_comment_reply/product_comment_reply_page.dart';
import 'widgets/product_comments_list.dart';

class ProductCommentsPage extends StatelessWidget {
  static const route = "/market_product_comments";

  ProductCommentsPage({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<ProductCommentsNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchCommentsCalled) {
          provider.fetchComments(context, marketProductId: productId);
        }

        return provider.loading
            ? Center(child: AppLoading())
            : provider.productComments == null
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
                        ProductCommentsList(
                          comments: provider.productComments!,
                          onItemTap: (index) {
                            Routes.sailor.navigate(
                              ProductCommentReplyPage.route,
                              params: {
                                "productComment":
                                    provider.productComments![index]
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        if (provider.enableLoadMoreOptions!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchComments(
                              context,
                              marketProductId: productId,
                            );
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
