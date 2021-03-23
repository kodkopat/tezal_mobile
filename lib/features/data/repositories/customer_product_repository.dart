import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../../data/data_sources/customer_product/customer_product_local_data_source.dart';
import '../../data/data_sources/customer_product/customer_product_remote_data_source.dart';
import '../models/photo_result_model.dart';

class CustomerProductRepository {
  CustomerProductRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerProductRemoteDataSource(Dio()),
        _localDataSource = CustomerProductLocalDataSource();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerProductRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerProductLocalDataSource _localDataSource;

  Future<Either<Failure, dynamic>> productList({
    @required int pageSize,
    @required int page,
    @required String orderBy,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.list(pageSize, page, orderBy);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> productDetail({
    @required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getDetail(id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> productphoto({
    @required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getPhoto(id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotoResultModel>> marketProductPhoto({
    @required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getMarketProductPhoto(id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> saveProduct({
    @required String id,
    @required String categoryId,
    @required String name,
    @required String description,
    @required double discountedPrice,
    @required double originalPrice,
    @required bool onSale,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.save(
        id,
        categoryId,
        name,
        description,
        discountedPrice,
        originalPrice,
        onSale,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> likeProduct({
    @required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.like(id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> unlikeProduct({
    @required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.unlike(id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> likedProdutcs() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getLikedProducts();

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
