import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/market/market_photo_model.dart';

class PhotosListItem extends StatelessWidget {
  PhotosListItem({required this.marketPhoto});

  final MarketPhoto marketPhoto;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..width(MediaQuery.of(context).size.width)
        ..height(128)
        ..background.image(
          alignment: Alignment.center,
          path: "assets/images/img_placeholder.jpg",
          fit: BoxFit.fill,
        ),
      child: Image.memory(
        base64Decode(marketPhoto.photo),
        fit: BoxFit.fill,
      ),
    );
  }
}
