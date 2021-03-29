import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/image_view.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/models/comments_result_model.dart';
import '../../../data/models/photos_result_model.dart';
import '../../../data/models/product_detail_result_model.dart';
import '../../../data/repositories/customer_product_repository.dart';
import '../../customer_widgets/comment_list/comment_list.dart';
import '../../customer_widgets/product_list/product_list_item_basket_toggle.dart';
import '../../customer_widgets/product_list/product_list_item_counter.dart';
import '../../customer_widgets/product_list/product_list_item_like_toggle.dart';

class ProductDetailPage extends StatelessWidget {
  static const route = "/customer_product_detail";

  ProductDetailPage({Key key, this.productId}) : super(key: key);

  final String productId;

  final _customerProductRepo = CustomerProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar.intance(
        text: "جزئیات محصول",
        showBackBtn: true,
      ),
      body: CustomFutureBuilder(
        future: _customerProductRepo.productDetail(
          id: productId,
        ),
        successBuilder: (context, data) {
          var result = data as Either<Failure, ProductDetailResultModel>;

          return result.fold(
            (l) => Txt(
              l.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (r) => _listOfSections(r),
          );
        },
        errorBuilder: (context, error) {
          return AppLoading(
            color: AppTheme.customerPrimary,
          );
        },
      ),
    );
  }

  Widget _listOfSections(ProductDetailResultModel productDetail) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _sectionCarouselSlider(productDetail),
          const SizedBox(height: 16),
          _sectionTitleAndLike(productDetail),
          const SizedBox(height: 16),
          richText(
            title: "توضیحات",
            text: productDetail.data.description,
          ),
          SizedBox(height: 8),
          _fieldOriginalPrice(productDetail),
          _fieldDiscountedPrice(productDetail),
          SizedBox(height: 8),
          ProductListItemCounter(hieght: 40),
          SizedBox(height: 8),
          _sectionComments(productDetail),
        ],
      ),
    );
  }

  Widget _sectionCarouselSlider(ProductDetailResultModel productDetail) {
    return CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
      future: _customerProductRepo.productphoto(id: productDetail.data.id),
      successBuilder: (context, data) {
        return data.fold(
          (l) => ProductImageView(images: ["", ""]),
          (r) => ProductImageView(images: r.data.photos),
        );
      },
      errorBuilder: (context, data) {
        return ProductImageView(images: ["", ""]);
      },
    );
  }

  Widget _sectionTitleAndLike(ProductDetailResultModel productDetail) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Txt(
          "${productDetail.data.name}",
          style: AppTxtStyles().subHeading
            ..padding(right: 4)
            ..textOverflow(TextOverflow.ellipsis)
            ..maxLines(1)
            ..bold(),
        ),
        Row(
          textDirection: TextDirection.ltr,
          children: [
            ProductListItemLikeToggle(
              defaultValue: productDetail.data.liked,
              onChange: (value) {
                if (value) {
                  _customerProductRepo.likeProduct(
                    id: productDetail.data.id,
                  );
                } else {
                  _customerProductRepo.unlikeProduct(
                    id: productDetail.data.id,
                  );
                }
              },
            ),
            SizedBox(width: 4),
            ProductListItemBasketToggle(
              onChange: (value) {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _fieldOriginalPrice(ProductDetailResultModel productDetail) {
    return richText(
      title: "قیمت",
      text: _generateOriginalPrice(productDetail),
    );
  }

  Widget _fieldDiscountedPrice(ProductDetailResultModel productDetail) {
    return richText(
      title: "قیمت نهایی",
      text: _generateDiscountedPrice(productDetail),
    );
  }

  String _generateOriginalPrice(ProductDetailResultModel productDetail) {
    var priceTxt;
    if (productDetail.data.originalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (productDetail.data.originalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${productDetail.data.originalPrice}".length >= 3) {
        temp =
            intl.NumberFormat("#,000").format(productDetail.data.originalPrice);
      } else {
        temp = "${productDetail.data.originalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    var discountRateTxt;
    if (productDetail.data.discountRate == null ||
        productDetail.data.discountRate == 0) {
      discountRateTxt = "";
    } else {
      discountRateTxt = "${productDetail.data.discountRate}٪";
    }

    return priceTxt + " $discountRateTxt ";
  }

  String _generateDiscountedPrice(ProductDetailResultModel productDetail) {
    var priceTxt;
    if (productDetail.data.discountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (productDetail.data.discountedPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${productDetail.data.originalPrice}".length >= 3) {
        temp =
            intl.NumberFormat("#,000").format(productDetail.data.originalPrice);
      } else {
        temp = "${productDetail.data.originalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  Widget richText({
    @required String title,
    @required String text,
  }) {
    var textStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: title + ":",
            style: textStyle,
          ),
          TextSpan(
            text: text,
            style: textStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionComments(ProductDetailResultModel productDetail) {
    return CustomFutureBuilder<Either<Failure, CommentsResultModel>>(
      future: _customerProductRepo.productComments(
        productId: productDetail.data.id,
        page: 1,
      ),
      successBuilder: (context, data) {
        return data.fold(
          (l) => Txt(
            l.message,
            style: AppTxtStyles().body..alignment.center(),
          ),
          (r) => CommentList(
            commentsResultModel: r,
            showAllCommentOnTap: () {},
            enableLoadMore: true,
          ),
        );
      },
      errorBuilder: (context, data) {
        return AppLoading(color: AppTheme.customerPrimary);
      },
    );
  }
}
