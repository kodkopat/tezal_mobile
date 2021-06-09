import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/market/market_local_data_source.dart';
import '../data_sources/market/market_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import '../models/market/add_photo_result_model.dart';
import '../models/market/market_comments_result_model.dart';
import '../models/market/market_default_hours_result_model.dart';
import '../models/market/market_photos_result_model.dart';
import '../models/market/market_profile_result_model.dart';
import '../models/market/update_market_default_hours_model.dart';
import '../models/photo_result_model.dart';
import 'shared_user_repository.dart';

class MarketRepository {
  static MarketRepository? _instance;

  factory MarketRepository() {
    if (_instance == null) {
      _instance = MarketRepository._privateConstructor();
    }
    return _instance!;
  }

  MarketRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = MarketRemoteDataSource(Dio()),
        _localDataSource = MarketLocalDataSource(),
        _authRepo = SharedUserRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final MarketRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final MarketLocalDataSource _localDataSource;
  final SharedUserRepository _authRepo;

  Future<Either<Failure, MarketProfileResultModel>> getMarketProfile() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMarketProfile(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> changeMarketProfile({
    required String? id,
    required String? name,
    required String? phone,
    required String? telephone,
    required String? email,
    required String? address,
    required String? shabaNumber,
    required bool? isOpen,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.changeMarketProfile(
        userLang,
        userToken,
        id,
        name,
        phone,
        telephone,
        email,
        address,
        shabaNumber,
        isOpen,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> openCloseMarket() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.openCloseMarket(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> updateMarketDefaultHours(
      {required List<UpdateMarketDefaultHoursModel> defaultHours}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.updateMarketDefaultHours(
        userLang,
        userToken,
        defaultHours,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, MarketDefaultHoursResultModel>>
      getMarketDefaultHours() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMarketDefaultHours(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, MarketPhotosResultModel>> getMarketPhotos({
    required int skip,
    required int take,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMarketPhotos(
        userLang,
        userToken,
        skip,
        take,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotoResultModel>> getMarketPhoto(
      {required String photoId}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMarketPhoto(
        userLang,
        userToken,
        photoId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AddPhotoResultModel>> addMarketPhoto({
    required File photo,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.addMarketPhoto(
        userLang,
        userToken,
        photo,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> removeMarketPhoto({
    required String photoId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.removeMarketPhoto(
        userLang,
        userToken,
        photoId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> reOrderMarketPhoto({
    required Map<String, int> photosList,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.reOrderMarketPhoto(
        userLang,
        userToken,
        photosList,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, MarketCommentsResultModel>> getMarketComments({
    required int skip,
    required int take,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMarketComments(
        userLang,
        userToken,
        skip,
        take,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> replyMarketComment({
    required String commentId,
    required String reply,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.replyMarketComment(
        userLang,
        userToken,
        commentId,
        reply,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
