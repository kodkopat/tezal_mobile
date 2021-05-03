// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/market_product/market_product_local_data_source.dart';
import '../data_sources/market_product/market_product_remote_data_source.dart';
import '../models/market/main_categories_result_model.dart';
import '../models/market/market_products_result_model.dart';
import '../models/market/sub_categories_result_model.dart';
import '../models/market/sub_category_products_result_model.dart';
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

  Future<Either<Failure, MainCategoriesResultModel>> getMainCategories() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMainCategories(
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, SubCategoriesResultModel>> getCategoriesOfCategory(
      {required String mainCategoryId}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getCategoriesOfCategory(
        userToken,
        mainCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, SubCategoryProductsResultModel>>
      getProductsOfSubCategory({
    required String mainCategoryId,
    required String subCategoryId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getProducts(
        userToken,
        mainCategoryId,
        subCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, MarketProductsResultModel>> getMarketProduct({
    required String mainCategoryId,
    required String subCategoryId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMarketProduct(
        userToken,
        mainCategoryId,
        subCategoryId,
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

      var result = await _remoteDataSource.addToProductMarket(
        userToken,
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

      var result = await _remoteDataSource.removeMarketProduct(
        userToken,
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

      var result = await _remoteDataSource.changeProductMarketAmount(
        userToken,
        unknown,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
