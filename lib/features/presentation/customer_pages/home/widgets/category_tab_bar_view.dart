// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/load_more_btn.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../customer_providers/market_notifier.dart';
import 'markets_list.dart';

class CategoryTabBarView extends StatelessWidget {
  CategoryTabBarView({required this.marketCategoryId});

  final String marketCategoryId;

  @override
  Widget build(BuildContext context) {
    var marketNotifier = Get.find<MarketNotifier>();

    return Consumer<MarketNotifier>(
      builder: (context, provider, child) {
        if (provider.nearByMarkets == null) {
          provider.fetchNearbyMarkets(
            context,
            marketCategoryId: marketCategoryId,
          );
        }

        return provider.nearByMarketsLoading
            ? AppLoading()
            : provider.nearByMarkets == null
                ? provider.nearByMarketsErrorMsg == null
                    ? Txt("خطای بارگذاری لیست",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.nearByMarketsErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MarketsList(
                            markets: [],
                            onItemTap: (index) {
                              /* Routes.sailor.navigate(
                                MarketDetailPage.route,
                                params: {"marketId": markets[index].id},
                              ); */
                            }),
                        if (marketNotifier.enableLoadMoreData!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchNearbyMarkets(
                              context,
                              marketCategoryId: marketCategoryId,
                            );
                          })
                      ],
                    ),
                  );
      },
    );
  }
}
