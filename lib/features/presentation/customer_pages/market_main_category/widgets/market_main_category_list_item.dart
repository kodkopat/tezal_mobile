import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/exceptions/failure.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/custom_future_builder.dart';
import '../../../../data/models/customer/main_category_result_model.dart';
import '../../../../data/models/customer/photo_result_model.dart';
import '../../../customer_providers/category_notifier.dart';

class MarketMainCategoryListItem extends StatelessWidget {
  MarketMainCategoryListItem({
    required this.mainCategory,
    required this.onTap,
    required this.categoryNotifier,
  });

  final MainCategory mainCategory;
  final VoidCallback onTap;
  final CategoryNotifier categoryNotifier;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

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
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Parent(
              style: ParentStyle()
                ..width(screenSize.width)
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
                child: _futureImgFile,
              ),
            ),
          ),
          SizedBox(height: 8),
          Txt(
            "${mainCategory.name}",
            style: AppTxtStyles().footNote
              ..alignment.center()
              ..textOverflow(TextOverflow.ellipsis)
              ..maxLines(1),
          ),
        ],
      ),
    );
  }

  Widget get _futureImgFile {
    return CustomFutureBuilder<Either<Failure, PhotoResultModel>>(
      future: categoryNotifier.customerCategoryRepo.getMainCategoryPhoto(
        id: mainCategory.id,
      ),
      successBuilder: (context, data) {
        return data!.fold(
          (l) => SizedBox(),
          (r) => Image.memory(
            base64Decode(r.data!.photo),
            fit: BoxFit.fill,
          ),
        );
      },
      errorBuilder: (context, data) => SizedBox(),
    );
  }
}
