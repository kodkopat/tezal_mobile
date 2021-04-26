// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../../../core/services/location.dart';
import '../../data/data_sources/customer_market/customer_market_local_data_source.dart';
import '../../data/data_sources/customer_market/customer_market_remote_data_source.dart';
import '../models/customer/base_api_result_model.dart';
import '../models/customer/comments_result_model.dart';
import '../models/customer/main_category_detail_result_model.dart';
import '../models/customer/market_detail_result_model.dart';
import '../models/customer/nearby_markets_result_model.dart';
import '../models/customer/photos_result_model.dart';
import '../models/customer/sub_category_detail_result_model.dart';
import 'auth_repository.dart';

class CustomerMarketRepository {
  static CustomerMarketRepository? _instance;

  factory CustomerMarketRepository() {
    if (_instance == null) {
      _instance = CustomerMarketRepository._privateConstructor();
    }
    return _instance!;
  }

  CustomerMarketRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerMarketRemoteDataSource(Dio()),
        _localDataSource = CustomerMarketLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerMarketRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerMarketLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, NearByMarketsResultModel>> nearByMarkets(
    BuildContext context, {
    required int maxDistance,
    required int page,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var lang = Localizations.localeOf(context).languageCode;
      var position = await LocationService.getSavedLocation();

      var result = await _remoteDataSource.getNearByMarkets(
        userToken,
        lang,
        "${position.latitude}",
        "${position.longitude}",
        maxDistance,
        page,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> updateNearByMarkets() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.updateNearByMarkets(
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, MarketDetailResultModel>> marketDetail({
    required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getMarketDetail(userToken, marketId);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotosResultModel>> photo({
    required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getPhoto(marketId);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, CommentsResultModel>> marketComments({
    required String marketId,
    required int page,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getListComment(marketId, page);

      return result != null
          ? Right(result)
          : Left(ApiFailure("failed to load comments"));
    }
  }

  Future<Either<Failure, dynamic>> addComment({
    required String comment,
    required int point,
    required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.addComment(comment, point, marketId);

      return result != null ? Right(result) : Left(ApiFailure("failed to add"));
    }
  }

  Future<Either<Failure, MainCategoryDetailResultModel>> mainCategoryDetail({
    required String marketId,
    required String mainCategoryId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getMainCategoryDetail(
        userToken,
        marketId,
        mainCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, SubCategoryDetailResultModel>> subCategoryDetail({
    required String marketId,
    required String subCategoryId,
    required int page,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getSubCategoryDetail(
        userToken,
        marketId,
        subCategoryId,
        page,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
