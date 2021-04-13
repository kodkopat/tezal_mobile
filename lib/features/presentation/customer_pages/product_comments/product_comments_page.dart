// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/comment_list/comment_list.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/product_comments_notifier.dart';

class ProductCommentsPage extends StatelessWidget {
  static const route = "/customer_product_comments";

  ProductCommentsPage({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<ProductCommentsNotifier>(
      builder: (context, provider, child) {
        if (provider.productComments == null) {
          provider.fetchProductComments(context, productId: productId);
        }

        return provider.productCommentsLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.productComments == null
                ? provider.productCommentsErrorMsg == null
                    ? Txt("لیست نظرات خالی است",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.productCommentsErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommentList(
                          comments: provider.productComments!,
                          showAllCommentOnTap: () {
                            Routes.sailor.navigate(
                              ProductCommentsPage.route,
                              params: {"productId": productId},
                            );
                          },
                          enableHeader: provider.productComments!.isNotEmpty,
                        ),
                        const SizedBox(height: 8),
                        if (provider.enableLoadMoreData!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchProductComments(context,
                                productId: productId);
                          }),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "نظرات کاربران",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
