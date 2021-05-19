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
import '../models/base_api_result_model.dart';
import '../models/market/main_categories_result_model.dart';
import '../models/market/market_products_result_model.dart';
import '../models/market/product_comments_result_model.dart';
import '../models/market/products_result_model.dart';
import '../models/market/sub_categories_result_model.dart';
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
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMainCategories(
        userLang,
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
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getCategoriesOfCategory(
        userLang,
        userToken,
        mainCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, ProductsResultModel>> getProducts({
    required String mainCategoryId,
    required String subCategoryId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getProducts(
        userLang,
        userToken,
        mainCategoryId,
        subCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, ProductsResultModel>> getNotListedProducts({
    required String mainCategoryId,
    required String subCategoryId,
    required String terms,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getNotListedProducts(
        userLang,
        userToken,
        mainCategoryId,
        subCategoryId,
        terms,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, MarketProductsResultModel>> getMarketProducts({
    required String mainCategoryId,
    required String subCategoryId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMarketProducts(
        userLang,
        userToken,
        mainCategoryId,
        subCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> addToProductMarket({
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
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.addToProductMarket(
        userLang,
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

  Future<Either<Failure, BaseApiResultModel>> removeMarketProduct(
      {required String marketProductId}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.removeMarketProduct(
        userLang,
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
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.changeProductMarketAmount(
        userLang,
        userToken,
        unknown,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, ProductCommentsResultModel>> getProductComments({
    required String marketProductId,
    required int skip,
    required int take,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getProductComments(
        userLang,
        userToken,
        marketProductId,
        skip,
        take,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> replyProductComments({
    required String commentId,
    required String reply,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.replyProductComments(
        userLang,
        userToken,
        commentId,
        reply,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
