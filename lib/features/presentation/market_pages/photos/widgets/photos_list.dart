// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/photo_model.dart';
import 'photos_list_item.dart';

class PhotosList extends StatelessWidget {
  PhotosList({
    required this.marketPhotos,
    required this.onItemTap,
  });

  final List<PhotoModel> marketPhotos;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return marketPhotos.isEmpty
        ? _emptyState
        : GridView.builder(
            shrinkWrap: true,
            itemCount: marketPhotos.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return PhotosListItem(
                marketPhoto: marketPhotos[index],
                onTap: () => onItemTap(index),
              );
            },
          );
  }

  Widget get _emptyState => Txt(
        "لیست تصاویر شما خالی است",
        style: AppTxtStyles().body..alignment.center(),
      );
}
