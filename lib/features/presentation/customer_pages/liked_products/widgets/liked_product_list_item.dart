// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/customer/liked_products_result_model.dart';
import '../../../base_widgets/shared_photo.dart';
import '../../../customer_providers/liked_product_notifier.dart';
import '../../../customer_widgets/product_list/product_like_toggle.dart';

class LikedProductListItem extends StatelessWidget {
  LikedProductListItem({
    required this.likedProduct,
    required this.onTap,
    required this.productNotifier,
  });

  final LikedProduct likedProduct;
  final VoidCallback onTap;
  final LikedProductNotifier productNotifier;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..padding(horizontal: 4, vertical: 4)
        ..background.color(Colors.white)
        ..borderRadius(all: 12)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        )
        ..ripple(true),
      child: Stack(
        children: [
          Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Parent(
                    style: ParentStyle()
                      ..width(192)
                      ..height(128)
                      ..borderRadius(all: 8)
                      ..background.image(
                        alignment: Alignment.center,
                        path: "assets/images/img_placeholder.jpg",
                        fit: BoxFit.fill,
                      ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: SharedPhoto.getProductPhoto(
                        id: likedProduct.productId,
                      ),
                    ),
                  ),
                  Txt(
                    "${likedProduct.name}",
                    style: AppTxtStyles().subHeading
                      ..padding(right: 4)
                      ..textOverflow(TextOverflow.ellipsis)
                      ..maxLines(1)
                      ..bold(),
                  ),
                  Txt(
                    " دسته: " + "${likedProduct.category}",
                    style: AppTxtStyles().footNote
                      ..textColor(Colors.black38)
                      ..padding(right: 4)
                      ..textOverflow(TextOverflow.ellipsis)
                      ..maxLines(1),
                  ),
                  Txt(
                    " فروشگاه: " + "${likedProduct.market}",
                    style: AppTxtStyles().footNote
                      ..textColor(Colors.black38)
                      ..padding(right: 4)
                      ..textOverflow(TextOverflow.ellipsis)
                      ..maxLines(1),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 2,
            top: 2,
            child: ProductListItemLikeToggle(
              key: GlobalKey(),
              defaultValue: true,
              onChange: (value) async {
                productNotifier.unlikeProduct(
                  productId: likedProduct.productId,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
