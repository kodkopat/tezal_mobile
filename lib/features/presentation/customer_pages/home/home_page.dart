// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/modal_location_error.dart';
import '../../../../features/presentation/customer_providers/market_notifier.dart';
import '../../base_providers/location_notifier.dart';
import '../../customer_providers/campaign_notifier.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/campaigns_slider.dart';
import 'widgets/combo_box.dart';
import 'widgets/markets.dart';

class HomePage extends StatelessWidget {
  static const route = "/customer_home";

  @override
  Widget build(BuildContext context) {
    CampaignNotifier campaignNotifier =
        Provider.of<CampaignNotifier>(context, listen: false);
    Get.put<CampaignNotifier>(campaignNotifier);

    var campaignsConsumer = Consumer<CampaignNotifier>(
      builder: (context, provider, child) {
        if (provider.campaigns == null) {
          provider.fetchCampaigns();
        }

        return provider.campaignLoading
            ? AppLoading()
            : provider.campaigns == null
                ? provider.campaignErrorMsg == null
                    ? Txt("خطای بارگذاری لیست",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.campaignErrorMsg!,
                        style: AppTxtStyles().body..alignment.center())
                : CampaignSlider(campaigns: provider.campaigns!);
      },
    );

    MarketNotifier marketNotifier =
        Provider.of<MarketNotifier>(context, listen: false);
    Get.put<MarketNotifier>(marketNotifier);

    var marketsConsumer = Consumer<MarketNotifier>(
      builder: (context, provider, child) {
        if (provider.marketCategories == null) {
          provider.fetchMarketCategories();
        }

        return provider.marketCategoriesLoading
            ? AppLoading()
            : provider.marketCategories == null
                ? provider.marketCategoriesErrorMsg == null
                    ? Txt("خطای بارگذاری لیست",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.marketCategoriesErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : HomeMarketsWidget(
                    marketCategories: provider.marketCategories!);
      },
    );

    return Consumer<LocationNotifier>(
      builder: (context, provider, child) {
        if (provider.currentLocation == null) {
          provider.fetechLocation(context);
        }

        return provider.loading
            ? AppLoading()
            : provider.currentLocation == null
                ? LocationErrorModal(
                    onTryAgainBtnTap: () {
                      provider.fetechLocation(context);
                    },
                  )
                : Scaffold(
                    appBar: SimpleAppBar(context).create(
                      text: Lang.of(context).homePage,
                      showBasketBtn: true,
                    ),
                    body: RefreshIndicator(
                      onRefresh: () async {
                        provider.fetechLocation(context);
                        await marketNotifier.customerMarketRepo
                            .updateNearByMarkets();
                        return Future<void>.value();
                      },
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 40),
                              campaignsConsumer,
                              Expanded(
                                child: marketsConsumer,
                              ),
                            ],
                          ),
                          HomeComboBox(),
                        ],
                      ),
                    ),
                  );
      },
    );
  }
}
