import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/exceptions/failure.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/custom_future_builder.dart';
import '../../../../data/models/main_category_result_model.dart';
import '../../../../data/models/photo_result_model.dart';
import '../../../providers/customer_providers/category_notifier.dart';

class MainCategoryListItem extends StatelessWidget {
  MainCategoryListItem({
    required this.mainCategory,
    required this.onTap,
    required this.categoryNotifier,
  });

  final MainCategory mainCategory;
  final void Function() onTap;
  final CategoryNotifier categoryNotifier;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..padding(horizontal: 4, vertical: 4)
        ..background.color(Colors.white)
        ..borderRadius(all: 12)
        ..boxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        )
        ..ripple(true),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Parent(
                style: ParentStyle()
                  ..width(80)
                  ..height(80)
                  ..borderRadius(all: 8)
                  ..background.image(
                    alignment: Alignment.center,
                    path: "assets/images/placeholder.jpg",
                    fit: BoxFit.fill,
                  ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: _futureImgFile,
                ),
              ),
              Txt(
                "${mainCategory.name}",
                style: AppTxtStyles().footNote
                  ..textOverflow(TextOverflow.ellipsis)
                  ..maxLines(1)
                  ..bold(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _futureImgFile {
    return CustomFutureBuilder<Either<Failure, PhotoResultModel>>(
      future: categoryNotifier.customerCategoryRepo.mainCategoryPhoto(
        id: mainCategory.id,
      ),
      successBuilder: (context, data) {
        return data!.fold(
          (l) => SizedBox(),
          (r) => Image.memory(
            base64Decode(r.data!),
            fit: BoxFit.fill,
          ),
        );
      },
      errorBuilder: (context, data) => SizedBox(),
    );
  }
}
