import 'package:flutter/material.dart';
import 'package:tezal/features/data/models/market/market_photo_model.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/repositories/market_repository.dart';

class PhotosNotifier extends ChangeNotifier {
  static PhotosNotifier? _instance;

  factory PhotosNotifier(
    MarketRepository marketRepo,
  ) {
    if (_instance == null) {
      _instance = PhotosNotifier._privateConstructor(marketRepo);
    }

    return _instance!;
  }

  PhotosNotifier._privateConstructor(this.marketRepo);

  final MarketRepository marketRepo;

  bool wasFetchPhotosCalled = false;
  bool photosLoading = true;
  String? photosErrorMsg;

  int photosSkip = 0;
  int photosTake = 10;
  int? photosTotalCount;
  bool? photosEnableLoadMoreData;

  List<MarketPhoto>? marketPhotos;

  Future<void> fetchPhotos(BuildContext context) async {
    if (!wasFetchPhotosCalled) {
      wasFetchPhotosCalled = true;
      notifyListeners();
    }

    if (photosTotalCount == null) {
      var result = await marketRepo.getMarketPhotos(
        skip: photosSkip,
        take: photosTake,
      );

      result.fold(
        (left) => photosErrorMsg = left.message,
        (right) {
          photosTotalCount = right.data!.totalCount;
          marketPhotos = right.data!.result;
          photosEnableLoadMoreData = photosTotalCount != marketPhotos!.length;
          photosSkip += photosTake;
        },
      );

      photosLoading = false;
    } else {
      if (photosTotalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await marketRepo.getMarketPhotos(
        skip: photosSkip,
        take: photosTake,
      );

      result.fold(
        (left) => photosErrorMsg = left.message,
        (right) {
          marketPhotos!.addAll(right.data!.result!);
          photosEnableLoadMoreData = photosTotalCount != marketPhotos!.length;
          photosSkip += photosTake;
        },
      );

      prgDialog.hide();
    }

    notifyListeners();
  }

  bool photoLoading = true;
  String? photoErrorMsg;
  MarketPhoto? marketPhoto;

  Future<void> fetchPhoto({required String photoId}) async {
    var result = await marketRepo.getMarketPhoto(
      photoId: photoId,
    );

    result.fold(
      (left) => photoErrorMsg = left.message,
      (right) => marketPhoto = right.data,
    );

    photoLoading = false;
    notifyListeners();
  }

  void refreshPhotos(BuildContext context) async {
    wasFetchPhotosCalled = false;
    photosLoading = true;
    photosErrorMsg = null;
    photosSkip = 0;
    photosTake = 10;
    photosTotalCount = null;
    photosEnableLoadMoreData = null;
    marketPhotos = null;

    fetchPhotos(context);
  }
}
