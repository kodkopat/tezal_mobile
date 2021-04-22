// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/laguages.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/modal_location_error.dart';
import '../../../../features/presentation/providers/customer_providers/market_notifier.dart';
import '../../customer_widgets/market_list/markets_list.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/base_providers/location_notifier.dart';
import '../../providers/customer_providers/campaign_notifier.dart';
import 'widgets/campaigns_slider.dart';

class HomePage extends StatelessWidget {
  static const route = "/customer_home";

  @override
  Widget build(BuildContext context) {
    var marketNotifier = Provider.of<MarketNotifier>(
      context,
      listen: false,
    );

    // Provider.of<CampaignNotifier>(context, listen: false).fetchCampaigns();
    var campaignsConsumer = Consumer<CampaignNotifier>(
      builder: (context, provider, child) {
        if (provider.campaigns == null) {
          provider.fetchCampaigns();
        }

        return provider.campaignLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.campaigns == null
                ? provider.campaignErrorMsg == null
                    ? SizedBox()
                    : Txt(provider.campaignErrorMsg!,
                        style: AppTxtStyles().body..alignment.center())
                : Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 4),
                    child: CampaignSlider(campaigns: provider.campaigns!),
                  );
      },
    );

    var marketsConsumer = Consumer<MarketNotifier>(
      builder: (context, provider, child) {
        if (provider.nearByMarkets == null) {
          provider.fetchNearbyMarkets(context);
        }

        return provider.nearByMarketsLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.nearByMarkets == null
                ? provider.nearByMarketsErrorMsg == null
                    ? Txt("خطای بارگذاری لیست",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.nearByMarketsErrorMsg!,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MarketsList(
                          markets: provider.nearByMarkets!,
                          repository: provider.customerMarketRepo,
                        ),
                        SizedBox(height: 8),
                        if (provider.enableLoadMoreData!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchNearbyMarkets(context);
                          })
                      ],
                    ),
                  );
      },
    );

    return Consumer<LocationNotifier>(
      builder: (context, provider, child) {
        if (provider.currentLocation == null) {
          provider.fetechLocation(context);
        }

        return provider.loading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.currentLocation == null
                ? LocationErrorModal(
                    onTryAgainBtnTap: () {
                      provider.fetechLocation(context);
                    },
                  )
                : Scaffold(
                    appBar: SimpleAppBar(context).create(
                      text: Lang.of(context).pageHomeAppBar,
                      showBasketBtn: true,
                    ),
                    body: RefreshIndicator(
                      onRefresh: () async {
                        provider.fetechLocation(context);
                        await marketNotifier.customerMarketRepo
                            .updateNearByMarkets();
                        return Future<void>.value();
                      },
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            campaignsConsumer,
                            marketsConsumer,
                          ],
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
