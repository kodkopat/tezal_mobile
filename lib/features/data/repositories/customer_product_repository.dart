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
import '../models/comments_result_model.dart';
import '../models/liked_products_result_model.dart';
import '../models/photos_result_model.dart';
import '../models/product_detail_result_model.dart';
import '../models/products_result_model.dart';
import 'auth_repository.dart';

class CustomerProductRepository {
  CustomerProductRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerProductRemoteDataSource(Dio()),
        _localDataSource = CustomerProductLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerProductRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerProductLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, ProductsResultModel>> productList({
    required String marketId,
    required String categoryId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getAll(marketId, categoryId);
      print("allProducts: ${result.toJson()}\n");
      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, ProductDetailResultModel>> productDetail({
    required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getDetail(userToken, id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotosResultModel>> productphoto({
    required String id,
    required bool multi,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getPhoto(id, multi);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> likeProduct({
    required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.like(userToken, id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> unlikeProduct({
    required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.unlike(userToken, id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, LikedProductsResultModel>> likedProdutcs() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getLikedProducts(userToken);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, CommentsResultModel>> productComments({
    required String productId,
    required int page,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getComments(productId, page);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
