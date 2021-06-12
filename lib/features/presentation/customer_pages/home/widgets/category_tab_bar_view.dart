// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../data/models/customer/nearby_markets_result_model.dart';
import '../../market_detail/market_detail_page.dart';
import 'markets_list_item.dart';

class CategoryTabBarView extends StatelessWidget {
  CategoryTabBarView({
    Key? key,
    required this.market,
  }) : super(key: key);

  // final String marketCategoryId;
  final Data market;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: MarketsListItem(
        market: market.markets!,
        onTap: () {
          Routes.sailor.navigate(
            MarketDetailPage.route,
            params: {"marketId": market.markets!.id},
          );
        },
        onLikeStatusChanged: () {
          // var marketId = provider.nearByMarkets![index].id;
          // provider.like(marketId: marketId);
        },
      ),
    ) /* ChangeNotifierProvider(
      create: (context) => MarketNotifier(
        Get.find<CustomerMarketRepository>(),
      ),
      child: Consumer<MarketNotifier>(
        builder: (context, provider, child) {
          if (provider.nearByMarkets == null) {
            provider.fetchNearbyMarkets();
          }

          return provider.nearByMarketsLoading
              ? AppLoading()
              : provider.nearByMarkets == null
                  ? provider.nearByMarketsErrorMsg == null
                      ? Txt("خطای بارگذاری لیست",
                          style: AppTxtStyles().body..alignment.center())
                      : Txt(provider.nearByMarketsErrorMsg,
                          style: AppTxtStyles().body..alignment.center())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MarketsList(
                          markets: provider.nearByMarkets!,
                          onItemTap: (index) {
                            Routes.sailor.navigate(
                              MarketDetailPage.route,
                              params: {
                                "marketId": provider.nearByMarkets![index].id
                              },
                            );
                          },
                          onItemLikeStatusChanged: (index) {
                            var marketId = provider.nearByMarkets![index].id;
                            provider.like(marketId: marketId);
                          },
                        ),
                        if (provider.enableLoadMoreData!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchNearbyMarkets(
                              context,
                              marketCategoryId: marketCategoryId,
                            );
                          }),
                      ],
                    );
        },
      ),
    ) */
        ;
  }
}
