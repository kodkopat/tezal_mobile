// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../../data/data_sources/customer_product/customer_product_local_data_source.dart';
import '../../data/data_sources/customer_product/customer_product_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import '../models/customer/add_edit_comment_rate_result_model.dart';
import '../models/customer/comments_result_model.dart';
import '../models/customer/liked_products_result_model.dart';
import '../models/customer/product_detail_result_model.dart';
import '../models/customer/products_result_model.dart';
import 'shared_user_repository.dart';

class CustomerProductRepository {
  static CustomerProductRepository? _instance;

  factory CustomerProductRepository() {
    if (_instance == null) {
      _instance = CustomerProductRepository._privateConstructor();
    }
    return _instance!;
  }

  CustomerProductRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerProductRemoteDataSource(Dio()),
        _localDataSource = CustomerProductLocalDataSource(),
        _authRepo = SharedUserRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerProductRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerProductLocalDataSource _localDataSource;
  final SharedUserRepository _authRepo;

  Future<Either<Failure, ProductsResultModel>> getProductsInSubCategory({
    required String marketId,
    required String categoryId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getProductsInSubCategory(
        userLang,
        userToken,
        marketId,
        categoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, ProductDetailResultModel>> getDetail({
    required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getDetail(
        userLang,
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> like({
    required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.like(
        userLang,
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> unlike({
    required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.unlike(
        userLang,
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, LikedProductsResultModel>> getLikedProducts() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getLikedProducts(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, CommentsResultModel>> getComments({
    required String productId,
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
        productId,
        skip,
        take,
      );

      print("productComments: ${result.toJson()}\n");

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AddEditCommentRateResultModel>> addEditCommentRate({
    required String comment,
    required String marketProductId,
    required String orderId,
    required int rate,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.addEditCommentRateProduct(
        userLang,
        userToken,
        comment,
        marketProductId,
        orderId,
        rate,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
