// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/page_routes/routes.dart';
import 'image_picker_list_item.dart';

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
              text: "گرفتن عکس با دوربین",
              iconPath: "assets/images/ic_camera.png",
              onTap: () async {
                final pickedFile =
                    await picker.getImage(source: ImageSource.camera);

                if (pickedFile != null) {
                  Routes.sailor.pop({
                    "imagePath": pickedFile.path,
                  });
                }
              },
            ),
            ImagePickerListItem(
              text: "انتخاب عکس از گالری",
              iconPath: "assets/images/ic_image.png",
              onTap: () async {
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  Routes.sailor.pop({
                    "imagePath": pickedFile.path,
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
