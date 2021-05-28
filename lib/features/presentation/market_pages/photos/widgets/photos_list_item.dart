import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/photo_model.dart';

class PhotosListItem extends StatelessWidget {
  PhotosListItem({
    required this.marketPhoto,
    required this.onTap,
  });

  final PhotoModel marketPhoto;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..width(64)
        ..height(64)
        ..background.image(
          alignment: Alignment.center,
          path: "assets/images/img_placeholder.jpg",
          fit: BoxFit.fill,
        )
        ..ripple(true),
      child: Image.memory(
        base64Decode(marketPhoto.photo),
        fit: BoxFit.contain,
      ),
    );
  }
}
