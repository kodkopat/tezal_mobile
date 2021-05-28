// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/languages/language.dart';
import '../../../../../core/page_routes/base_routes.dart';
import 'modal_photos_menu_list_item.dart';

class PhotosMenuModal extends StatelessWidget {
  PhotosMenuModal({
    required this.addPhotoOnTap,
    required this.reOrderPhotosOnTap,
  });

  final VoidCallback addPhotoOnTap;
  final VoidCallback reOrderPhotosOnTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Parent(
        style: ParentStyle()
          ..padding(top: 8)
          ..borderRadius(topLeft: 16, topRight: 16)
          ..background.color(Colors.white),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(vertical: 8),
          children: [
            PhotosMenuListItem(
              text: Lang.of(context).addNewPhoto,
              iconPath: "assets/images/ic_plus_square.png",
              onTap: () {
                Routes.sailor.pop();
                addPhotoOnTap();
              },
            ),
            PhotosMenuListItem(
              text: Lang.of(context).submitPhotosOrder,
              iconPath: "assets/images/ic_category.png",
              onTap: () {
                Routes.sailor.pop();
                reOrderPhotosOnTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}
