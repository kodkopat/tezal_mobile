// ignore: import_of_legacy_library_into_null_safe
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/comment_list/comment_list.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/market_comments_notifier.dart';

class MarketCommentsPage extends StatelessWidget {
  static const route = "/customer_market_comments";

  MarketCommentsPage({required this.marketId});

  final String marketId;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<MarketCommentsNotifier>(
      builder: (context, provider, child) {
        if (provider.marketComments == null) {
          provider.fetchMarketComments(
            context,
            marketId: marketId,
          );
        }

        return provider.marketCommentsLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.marketComments == null
                ? provider.marketCommentsErrorMsg == null
                    ? Txt("لیست نظرات خالی است",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.marketCommentsErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommentList(comments: provider.marketComments!),
                        const SizedBox(height: 8),
                        if (provider.enableLoadMoreData!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchMarketComments(
                              context,
                              marketId: marketId,
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
        text: "نظرات فروشگاه",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
