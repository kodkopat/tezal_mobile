// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../../../core/services/location.dart';
import '../data_sources/market_product/market_product_local_data_source.dart';
import '../data_sources/market_product/market_product_remote_data_source.dart';
import 'auth_repository.dart';

class MarketProductRepository {
  static MarketProductRepository? _instance;

  factory MarketProductRepository() {
    if (_instance == null) {
      _instance = MarketProductRepository._privateConstructor();
    }
    return _instance!;
  }

  MarketProductRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = MarketProductRemoteDataSource(Dio()),
        _localDataSource = MarketProductLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final MarketProductRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final MarketProductLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, dynamic>> getMainCategories() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getMainCategories(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getSubCategoriesOfCategory(
      {required String mainCategoryId}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getSubCategoriesOfCategory(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        mainCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getProductsOfSubCategory(
      {required String subCategoryId}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getProductsOfSubCategory(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        subCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getMarketProduct() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getMarketProduct(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> addToProductMarket({
    required String productId,
    required double amount,
    required double discountRate,
    required double discountedPrice,
    required double originalPrice,
    required bool onSale,
    required String description,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.addToProductMarket(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        productId,
        amount,
        discountRate,
        discountedPrice,
        originalPrice,
        onSale,
        description,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> removeMarketProduct(
      {required String marketProductId}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.removeMarketProduct(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        marketProductId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> changeProductMarketAmount(
      {required String unknown}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.changeProductMarketAmount(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        unknown,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
