import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/shared_application_repository.dart';

class PhotoProvider {
  PhotoProvider({required this.productId});

  final String productId;

  get photoFutureProvider => FutureProvider.autoDispose((ref) =>
      SharedApplicationRepository().getProductPhoto(productId: productId));

  get photosFutureProvider => FutureProvider.autoDispose((ref) =>
      SharedApplicationRepository().getProductPhotos(productId: productId));
}
