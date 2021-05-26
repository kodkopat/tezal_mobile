import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/carousel_image_slider.dart';
import '../base_providers/photo_provider.dart';

class ProductPhotosWidget extends ConsumerWidget {
  ProductPhotosWidget({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, watch) {
    return watch(PhotoProvider(productId: productId).photosFutureProvider).map(
      data: (data) {
        return data.value.fold(
          (left) => CarouselImageSlider(images: []),
          (right) => CarouselImageSlider(
            images: right.data!.map((e) => "${e.photo}").toList(),
          ),
        );
      },
      loading: (_) => CarouselImageSlider(images: []),
      error: (_) => CarouselImageSlider(images: []),
    );
  }
}
