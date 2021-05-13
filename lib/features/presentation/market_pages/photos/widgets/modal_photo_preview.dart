import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../data/models/photo_model.dart';

class PhotoPreviewModal extends StatelessWidget {
  PhotoPreviewModal({
    required this.marketPhoto,
    required this.onRemoveBtnTap,
  });

  final PhotoModel marketPhoto;
  final void Function() onRemoveBtnTap;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Parent(
        style: ParentStyle()
          ..width(screenSize.width)
          ..height(screenSize.height)
          ..alignmentContent.center(),
        child: Stack(
          children: [
            SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: Image.memory(
                base64Decode(marketPhoto.photo),
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: _buildCloseBtn(),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: _buildRemoveBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseBtn() {
    return Parent(
      gesture: Gestures()..onTap(() => Routes.sailor.pop()),
      style: ParentStyle()
        ..width(48)
        ..height(48)
        ..borderRadius(all: 24)
        ..ripple(true),
      child: Icon(
        Feather.x,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Widget _buildRemoveBtn() {
    return Parent(
      gesture: Gestures()..onTap(onRemoveBtnTap),
      style: ParentStyle()
        ..width(48)
        ..height(48)
        ..alignmentContent.center()
        ..borderRadius(all: 24)
        ..ripple(true),
      child: Image.asset(
        "assets/images/ic_delete.png",
        color: Colors.white,
        fit: BoxFit.contain,
        width: 24,
        height: 24,
      ),
    );
  }
}
