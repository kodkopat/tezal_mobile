import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base_providers/photo_provider.dart';

class ProductPhotoWidget extends ConsumerWidget {
  ProductPhotoWidget({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, watch) {
    return watch(PhotoProvider(productId: productId).photoFutureProvider).map(
      data: (data) {
        return data.value.fold(
          (left) => SizedBox(),
          (right) => Image.memory(
            base64Decode(right.data!.photo),
            fit: BoxFit.fill,
          ),
        );
      },
      loading: (_) => SizedBox(),
      error: (_) => SizedBox(),
    );
  }
}
