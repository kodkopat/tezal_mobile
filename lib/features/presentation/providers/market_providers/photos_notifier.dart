import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/base_api_result_model.dart';
import '../../../data/models/market/add_photo_result_model.dart';
import '../../../data/models/photo_model.dart';
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

  List<PhotoModel>? marketPhotos;

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
  PhotoModel? marketPhoto;

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

  String? addPhotoErrorMsg;
  AddPhotoResultModel? addPhotoResult;

  Future<void> addPhoto(BuildContext context, {required File img}) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketRepo.addMarketPhoto(
      photo: img,
    );

    result.fold(
      (left) => addPhotoErrorMsg = left.message,
      (right) => addPhotoResult = right,
    );

    prgDialog.hide();
    _refresh(context);
  }

  String? removePhotoErrorMsg;
  BaseApiResultModel? removePhotoResult;

  Future<void> removePhoto(BuildContext context,
      {required String photoId}) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketRepo.removeMarketPhoto(
      photoId: photoId,
    );

    result.fold(
      (left) => removePhotoErrorMsg = left.message,
      (right) => removePhotoResult = right.data,
    );

    prgDialog.hide();
    _refresh(context);
  }

  String? reOrderPhotosErrorMsg;
  BaseApiResultModel? reOrderPhotosResult;

  Future<void> reOrderPhotos(BuildContext context,
      {required Map<String, int> photosList}) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketRepo.reOrderMarketPhoto(
      photosList: photosList,
    );

    result.fold(
      (left) => reOrderPhotosErrorMsg = left.message,
      (right) => reOrderPhotosResult = right.data,
    );

    prgDialog.hide();
    _refresh(context);
  }

  void _refresh(BuildContext context) async {
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
