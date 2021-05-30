// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/load_more_btn.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../data/repositories/customer_market_repository.dart';
import '../../../customer_providers/market_notifier.dart';
import '../../market_detail/market_detail_page.dart';
import 'markets_list.dart';

class CategoryTabBarView extends StatelessWidget {
  CategoryTabBarView({
    Key? key,
    required this.marketCategoryId,
  }) : super(key: key);

  final String marketCategoryId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MarketNotifier(
        Get.find<CustomerMarketRepository>(),
      ),
      child: Consumer<MarketNotifier>(
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
                            }),
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
    );
  }
}
