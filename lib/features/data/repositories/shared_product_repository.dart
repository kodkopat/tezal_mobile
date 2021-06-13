// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/shared_product/shared_product_local_data_source.dart';
import '../data_sources/shared_product/shared_product_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import 'shared_user_repository.dart';

class SharedProductRepository {
  static SharedProductRepository? _instance;

  factory SharedProductRepository() {
    if (_instance == null) {
      _instance = SharedProductRepository._privateConstructor();
    }
    return _instance!;
  }

  SharedProductRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = SharedProductRemoteDataSource(Dio()),
        _localDataSource = SharedProductLocalDataSource(),
        _authRepo = SharedUserRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final SharedProductRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final SharedProductLocalDataSource _localDataSource;
  // ignore: unused_field
  final SharedUserRepository _authRepo;

  Future<Either<Failure, BaseApiResultModel>> hasUpdate(
      {required String version}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;

      var result = await _remoteDataSource.hasUpdate(
        userLang,
        version,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getProductPhotoList(
      {required String productId}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getProductPhotoList(
        userLang,
        userToken,
        productId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getProductPhoto({
    required String productId,
    required String photoId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getProductPhoto(
        userLang,
        userToken,
        productId,
        photoId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}