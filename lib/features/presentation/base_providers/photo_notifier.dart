import 'package:flutter/material.dart';

import '../../data/models/photo_model.dart';
import '../../data/repositories/shared_application_repository.dart';

class PhotoNotifier extends ChangeNotifier {
  static PhotoNotifier? _instance;

  factory PhotoNotifier(
    SharedApplicationRepository sharedApplicationRepo,
  ) {
    if (_instance == null) {
      _instance = PhotoNotifier._privateConstructor(sharedApplicationRepo);
    }

    return _instance!;
  }

  PhotoNotifier._privateConstructor(this.sharedApplicationRepo);

  final SharedApplicationRepository sharedApplicationRepo;

  bool loading = true;
  String? errorMsg;
  PhotoModel? result;

  Future<void> fetchPhoto({
    required String productId,
  }) async {
    var result = await sharedApplicationRepo.getProductPhoto(
      productId: productId,
    );

    result.fold(
      (left) => errorMsg = left.message,
      (right) => result = right.data!.photo,
    );

    loading = false;
    notifyListeners();
  }
}
