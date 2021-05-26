// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_providers/product_comments_notifier.dart';
import '../../customer_widgets/comment_list/comment_list.dart';
import '../../customer_widgets/simple_app_bar.dart';

class ProductCommentsPage extends StatelessWidget {
  static const route = "/customer_product_comments";

  ProductCommentsPage({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<ProductCommentsNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchCommentsCalled) {
          provider.fetchComments(context, productId: productId);
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
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommentList(comments: provider.comments!),
                        if (provider.enableLoadMoreOption!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchComments(context,
                                productId: productId);
                          }),
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "نظرات محصول",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
