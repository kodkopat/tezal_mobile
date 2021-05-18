// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../../../core/services/location.dart';
import '../../data/data_sources/customer_market/customer_market_local_data_source.dart';
import '../../data/data_sources/customer_market/customer_market_remote_data_source.dart';
import '../models/base_api_result_model.dart';
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

  Future<Either<Failure, NearByMarketsResultModel>> getNearByMarkets({
    required int maxDistance,
    required int page,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;
      final position = await LocationService.getSavedLocation();

      var result = await _remoteDataSource.getNearByMarkets(
        userLang,
        userToken,
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
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.updateNearByMarkets(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, MarketDetailResultModel>> getMarketDetail({
    required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMarketDetail(
        userLang,
        userToken,
        marketId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotosResultModel>> getPhoto({
    required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;

      var result = await _remoteDataSource.getPhoto(
        userLang,
        marketId,
        false,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotosResultModel>> getPhotos({
    required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;

      var result = await _remoteDataSource.getPhoto(
        userLang,
        marketId,
        true,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, CommentsResultModel>> getComments({
    required String marketId,
    required int skip,
    required int take,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getComments(
        userLang,
        userToken,
        marketId,
        skip,
        take,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> addEditCommentRate({
    required String comment,
    required int point,
    required String orderId,
    required int rate,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.addEditCommentRate(
        userLang,
        userToken,
        comment,
        point,
        orderId,
        rate,
      );

      return result != null ? Right(result) : Left(ApiFailure("failed to add"));
    }
  }

  Future<Either<Failure, MainCategoryDetailResultModel>> getMainCategoryDetail({
    required String marketId,
    required String mainCategoryId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMainCategoryDetail(
        userLang,
        userToken,
        marketId,
        mainCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, SubCategoryDetailResultModel>> getSubCategoryDetail({
    required String marketId,
    required String subCategoryId,
    required int page,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getSubCategoryDetail(
        userLang,
        userToken,
        marketId,
        subCategoryId,
        page,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
