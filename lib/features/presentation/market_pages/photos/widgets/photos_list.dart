// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/photo_model.dart';
import 'photos_list_item.dart';

class PhotosList extends StatelessWidget {
  PhotosList({
    required this.marketPhotos,
    required this.onItemTap,
    required this.onReorder,
  });

  final List<PhotoModel> marketPhotos;
  final void Function(int) onItemTap;
  final void Function(int, int) onReorder;

  @override
  Widget build(BuildContext context) {
    return marketPhotos.isEmpty
        ? _emptyState
        : DragAndDropGridView(
            itemCount: marketPhotos.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
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
            onWillAccept: (oldIndex, newIndex) => true,
            onReorder: onReorder,
          );
  }

  Widget get _emptyState => Txt(
        "لیست تصاویر شما خالی است",
        style: AppTxtStyles().body..alignment.center(),
      );
}
