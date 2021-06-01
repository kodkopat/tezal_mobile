// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/carousel_image_slider.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/customer/comments_result_model.dart';
import '../../../data/models/customer/photos_result_model.dart';
import '../../../data/models/customer/product_detail_result_model.dart';
import '../../../data/repositories/customer_product_repository.dart';
import '../../customer_providers/basket_notifier.dart';
import '../../customer_providers/market_detail_notifier.dart';
import '../../customer_providers/product_comments_notifier.dart';
import '../../customer_providers/product_details_notifier.dart';
import '../../customer_providers/search_notifier.dart';
import '../../customer_widgets/comment_list/comment_list.dart';
import '../../customer_widgets/product_list/product_counter.dart';
import '../../customer_widgets/product_list/product_like_toggle.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../product_comments/product_comments_page.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatelessWidget {
  static const route = "/customer_product_detail";

  ProductDetailPage({
    required this.productId,
    required this.marketDetailNotifier,
  });

  final String productId;
  final MarketDetailNotifier marketDetailNotifier;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<ProductDetailNotifier>(
      builder: (context, provider, child) {
        if (provider.productDetails == null) {
          provider.fetchProductDetail(productId: productId);
        }

        return provider.productLoading
            ? AppLoading()
            : provider.productDetails == null
                ? provider.productErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.productErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : _listOfSections(context, provider.productDetails!);
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات محصول",
        showBackBtn: true,
        showBasketBtn: true,
      ),
      body: consumer,
    );
  }

  Widget _listOfSections(
      BuildContext context, ProductDetailResultModel productDetail) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _sectionCarouselSlider(productDetail),
          const SizedBox(height: 8),
          _sectionTitleAndLike(productDetail),
          const SizedBox(height: 2),
          /* Txt(
            "${productDetail.data!.description ?? ""}",
            style: AppTxtStyles().body..textAlign.right(),
          ),
          SizedBox(height: 8), */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldOriginalPrice(productDetail),
                  _fieldDiscountedPrice(productDetail),
                ],
              ),
              _fieldDiscountedRate(productDetail),
            ],
          ),
          const SizedBox(height: 16),
          // if (productDetail.data!.onSale ?? false)
          ProductListItemCounter(
            hieght: 36,
            defaultValue: productDetail.data!.amount * productDetail.data!.step,
            step: productDetail.data!.step,
            unit: "${productDetail.data!.productUnit}",
            onIncrease: () async {
              var basketNotifier = Get.find<BasketNotifier>();
              var customerSearchNotifier = Get.find<CustomerSearchNotifier>();

              await basketNotifier.addToBasket(
                productId: productDetail.data!.id,
              );

              marketDetailNotifier.refresh();
              customerSearchNotifier.refresh(context);
            },
            onDecrease: () async {
              var basketNotifier = Get.find<BasketNotifier>();
              var customerSearchNotifier = Get.find<CustomerSearchNotifier>();

              await basketNotifier.removeFromBasket(
                productId: productDetail.data!.id,
              );

              marketDetailNotifier.refresh();
              customerSearchNotifier.refresh(context);
            },
          ),
          _sectionComments(context, productDetail),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _sectionCarouselSlider(ProductDetailResultModel productDetail) {
    return CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
      future: Get.find<CustomerProductRepository>().getPhotos(
        id: productDetail.data!.id,
      ),
      successBuilder: (context, data) {
        return data!.fold(
          (left) => CarouselImageSlider(images: []),
          (right) => CarouselImageSlider(images: right.data!.photos),
        );
      },
      errorBuilder: (context, data) {
        return CarouselImageSlider(images: []);
      },
    );
  }

  Widget _sectionTitleAndLike(ProductDetailResultModel productDetail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Txt(
          "${productDetail.data!.name}",
          style: AppTxtStyles().heading
            ..textOverflow(TextOverflow.ellipsis)
            ..maxLines(1)
            ..bold(),
        ),
        ProductListItemLikeToggle(
          defaultValue: productDetail.data!.liked,
          onChange: (value) {
            if (value) {
              Get.find<CustomerProductRepository>().like(
                id: productDetail.data!.id,
              );
            } else {
              Get.find<CustomerProductRepository>().unlike(
                id: productDetail.data!.id,
              );
            }
          },
        ),
      ],
    );
  }

  Widget _fieldOriginalPrice(ProductDetailResultModel productDetail) {
    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        text: _generateOriginalPrice(productDetail),
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          color: Colors.black54,
          letterSpacing: 0.5,
          fontFamily: 'Yekan',
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _fieldDiscountedPrice(ProductDetailResultModel productDetail) {
    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        text: _generateDiscountedPrice(productDetail),
        style: TextStyle(
          color: Colors.green,
          letterSpacing: 0.5,
          fontFamily: 'Yekan',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _fieldDiscountedRate(ProductDetailResultModel productDetail) {
    if (_generateDiscountedRate(productDetail).isEmpty) {
      return SizedBox();
    }

    return Txt(
      _generateDiscountedRate(productDetail),
      style: AppTxtStyles().subHeading
        ..bold()
        ..textDirection(TextDirection.ltr)
        ..textColor(Colors.red)
        ..background.color(Colors.red.withOpacity(0.1))
        ..borderRadius(topLeft: 4, bottomLeft: 4, topRight: 24, bottomRight: 24)
        ..padding(horizontal: 12, vertical: 8),
    );
  }

  String _generateOriginalPrice(ProductDetailResultModel productDetail) {
    var priceTxt;
    if (productDetail.data!.originalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (productDetail.data!.originalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${productDetail.data!.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000")
            .format(productDetail.data!.originalPrice);
      } else {
        temp = "${productDetail.data!.originalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  String _generateDiscountedPrice(ProductDetailResultModel productDetail) {
    var priceTxt;
    if (productDetail.data!.discountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (productDetail.data!.discountedPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${productDetail.data!.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000")
            .format(productDetail.data!.originalPrice);
      } else {
        temp = "${productDetail.data!.originalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  String _generateDiscountedRate(ProductDetailResultModel productDetail) {
    var discountRateTxt;
    if (productDetail.data!.discountRate == null ||
        productDetail.data!.discountRate == 0) {
      discountRateTxt = "";
    } else {
      discountRateTxt =
          "${(productDetail.data!.discountRate * 100).toStringAsFixed(0)}٪";
    }
    return discountRateTxt;
  }

  Widget _sectionComments(
    BuildContext context,
    ProductDetailResultModel productDetail,
  ) {
    var provider = Provider.of<ProductCommentsNotifier>(
      context,
      listen: false,
    );

    print("productId: ${productDetail.data!.id}\n");

    return CustomFutureBuilder<Either<Failure, CommentsResultModel>>(
      future: provider.customerProductRepo.getComments(
        productId: productDetail.data!.id,
        skip: 0,
        take: 3,
      ),
      successBuilder: (context, data) {
        return data!.fold(
          (left) => Txt(
            left.message,
            style: AppTxtStyles().body..alignment.center(),
          ),
          (right) {
            return CommentList(
              comments: right.data!.comments!,
              showAllCommentOnTap: () {
                Routes.sailor.navigate(
                  ProductCommentsPage.route,
                  params: {"productId": productDetail.data!.id},
                );
              },
              enableHeader: right.data!.comments!.isNotEmpty,
            );
          },
        );
      },
      errorBuilder: (context, data) {
        return AppLoading();
      },
    );
  }
}
