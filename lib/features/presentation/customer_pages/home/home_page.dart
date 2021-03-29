import 'package:dartz/dartz.dart' hide State;
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/image_view.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/models/nearby_markets_result_model.dart';
import '../../../data/repositories/customer_campaign_repository.dart';
import '../../../data/repositories/customer_market_repository.dart';
import 'widgets/nearby_markets_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar.intance(text: "خانه"),
        body: CustomFutureBuilder(
          future: marketRepo.nearByMarkets(
            context,
            maxDistance: 50,
            count: 10,
          ),
          successBuilder: (context, data) {
            var result = data as Either<Failure, NearByMarketsResultModel>;

            return result.fold(
                (l) => Txt(
                      l.message,
                      style: AppTxtStyles().body..alignment.center(),
                    ), (r) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ProductImageView(images: campaignPhotos),
                    const SizedBox(height: 8),
                    NearByMarketsList(
                      markets: r.data.markets,
                      repository: marketRepo,
                    ),
                  ],
                ),
              );
            });
          },
          errorBuilder: (context, error) {
            return AppLoading(color: AppTheme.customerPrimary);
          },
        ),
      ),
    );
  }
}
