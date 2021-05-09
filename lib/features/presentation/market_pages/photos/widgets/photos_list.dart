import 'package:flutter/material.dart';

import '../../../../data/models/market/market_photo_model.dart';
import 'photos_list_item.dart';

class PhotosList extends StatelessWidget {
  PhotosList({required this.marketPhotos});

  final List<MarketPhoto> marketPhotos;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: marketPhotos.length,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemBuilder: (context, index) => PhotosListItem(
        marketPhoto: marketPhotos[index],
      ),
      separatorBuilder: (context, index) => SizedBox(height: 16),
    );
  }
}
