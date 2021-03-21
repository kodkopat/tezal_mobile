import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:tezal/features/customer_home/data/models/photos_result_model.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/image_view.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../data/models/market_detail_result_model.dart';
import '../../data/repositories/customer_market_repository.dart';
import 'market_detail_category_list.dart';

class MarketDetailModal extends StatelessWidget {
  MarketDetailModal({
    Key key,
    @required this.marketId,
  }) : super(key: key);

  final String marketId;
  final repository = CustomerMarketRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar.intance(
        text: "جزئیات فروشگاه",
        showBackBtn: true,
      ),
      body: CustomFutureBuilder(
        future: repository.marketDetail(
          marketId: marketId,
        ),
        successBuilder: (context, data) {
          var result = data as Either<Failure, MarketDetailResultModel>;

          return result.fold(
            (l) => Txt(
              l.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (r) {
              // return _sectionCategories(r.data.categories);
              return _listOfSections(r);
            },
          );
        },
        errorBuilder: (context, error) {
          return AppLoading(color: AppTheme.customerPrimary);
        },
      ),
    );
  }

  Widget _listOfSections(MarketDetailResultModel marketDetail) {
    var categories = marketDetail.data.categories;

    return SingleChildScrollView(
      child: Column(
        children: [
          _sectionCarouselSlider(marketDetail),
          _sectionCategories(categories),
        ],
      ),
    );
  }

  Widget _sectionCarouselSlider(MarketDetailResultModel marketDetail) {
    return CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
      future: repository.photos(marketId: marketId),
      successBuilder: (context, data) {
        return data.fold(
          (l) => ProductImageView(images: ["", ""]),
          (r) => ProductImageView(
            images: r.data.map((e) => e.fileContents).toList(),
          ),
        );
      },
      errorBuilder: (context, data) {
        return ProductImageView(images: ["", ""]);
      },
    );
  }

  Widget _sectionCategories(List<Category> categories) {
    return MarketDetailCategoryList(categories: categories);
  }
}
