// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../languages/language.dart';
import '../page_routes/base_routes.dart';
import 'modal_image_picker_list_item.dart';

class ImagePickerModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

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
            ImagePickerListItem(
              text: Lang.of(context).imageFromCamera,
              iconPath: "assets/images/ic_camera.png",
              onTap: () async {
                PickedFile? pickedFile = await picker.getImage(
                  source: ImageSource.camera,
                );

                if (pickedFile != null) {
                  Routes.sailor.pop(pickedFile.path);
                }
              },
            ),
            ImagePickerListItem(
              text: Lang.of(context).imageFromGallery,
              iconPath: "assets/images/ic_image.png",
              onTap: () async {
                PickedFile? pickedFile = await picker.getImage(
                  source: ImageSource.gallery,
                );

                if (pickedFile != null) {
                  Routes.sailor.pop(pickedFile.path);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
