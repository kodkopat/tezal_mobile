import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../data/repositories/shared_application_repository.dart';

class PhotoProvider {
  PhotoProvider({required this.productId});

  final String productId;

  get photoFutureProvider => FutureProvider.autoDispose((ref) =>
      Get.find<SharedApplicationRepository>()
          .getProductPhoto(productId: productId));

  get photosFutureProvider => FutureProvider.autoDispose((ref) =>
      Get.find<SharedApplicationRepository>()
          .getProductPhotos(productId: productId));
}
