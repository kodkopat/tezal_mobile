// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/image_view.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../features/presentation/providers/customer_providers/market_notifier.dart';
import '../../../data/repositories/customer_campaign_repository.dart';
import '../../../data/repositories/customer_market_repository.dart';
import '../../customer_widgets/market_list/markets_list.dart';
import '../../customer_widgets/simple_app_bar.dart';

class HomePage extends StatefulWidget {
  static const route = "/customer_home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final campaignRepo = CustomerCampaignRepository();
  final marketRepo = CustomerMarketRepository();

  bool campaignsLoading = true;
  List<String> campaignPhotos = [];

  void fetchCampaignPhotos() async {
    var campaignsEigher = await campaignRepo.campaignes;
    campaignsEigher.fold(
      (l) => null,
      (r) async {
        var campaignIds = r.data.map((e) => e.id).toList();
        print("campaignIds length: ${campaignIds.length}\n");
        for (int i = 0; i < campaignIds.length; i++) {
          var campaignsPhotoEigher = await campaignRepo.campaignPhoto(
            campaignId: campaignIds[i],
          );
          campaignsPhotoEigher.fold(
            (l) => null,
            (r) {
              campaignPhotos.add(r.data.photos.first);
            },
          );
        }
      },
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCampaignPhotos();
  }

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<MarketNotifier>(
      builder: (context, provider, child) {
        if (provider.nearByMarkets == null &&
            provider.nearByMarketsErrorMsg == null) {
          provider.fetchNearbyMarkets(context);
        }

        return provider.nearByMarketsLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.nearByMarketsErrorMsg != null
                ? Txt(
                    provider.nearByMarketsErrorMsg!,
                    style: AppTxtStyles().body..alignment.center(),
                  )
                : provider.nearByMarkets!.isEmpty
                    ? Txt(
                        "لیست فروشگاه‌ها خالی است",
                        style: AppTxtStyles().body..alignment.center(),
                      )
                    : SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MarketsList(
                              markets: provider.nearByMarkets!,
                              repository: marketRepo,
                            ),
                            SizedBox(height: 8),
                            if (provider.enableLoadMoreData!)
                              LoadMoreBtn(
                                onTap: () {
                                  provider.fetchNearbyMarkets(context);
                                },
                              )
                          ],
                        ),
                      );
      },
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar(context).create(
          text: "خانه",
          showBasketBtn: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await marketRepo.updateNearByMarkets();
            return Future<void>.value();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                ProductImageView(images: campaignPhotos),
                const SizedBox(height: 8),
                consumer,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
