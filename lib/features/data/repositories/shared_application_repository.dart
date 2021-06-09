// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/shared_application/shared_application_local_data_source.dart';
import '../data_sources/shared_application/shared_application_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import '../models/photo_result_model.dart';
import '../models/photos_result_model.dart';
import 'shared_user_repository.dart';

class SharedApplicationRepository {
  static SharedApplicationRepository? _instance;

  factory SharedApplicationRepository() {
    if (_instance == null) {
      _instance = SharedApplicationRepository._privateConstructor();
    }
    return _instance!;
  }

  SharedApplicationRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = SharedApplicationRemoteDataSource(Dio()),
        _localDataSource = SharedApplicationLocalDataSource(),
        _authRepo = SharedUserRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final SharedApplicationRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final SharedApplicationLocalDataSource _localDataSource;
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

  Future<Either<Failure, BaseApiResultModel>> getUpdate(
      {required String version}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;

      var result = await _remoteDataSource.getUpdate(
        userLang,
        version,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> share({
    required List<String> contactNumbers,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.share(
        userLang,
        userToken,
        contactNumbers,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotoResultModel>> getProductPhoto({
    required String productId,
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
        true,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotosResultModel>> getProductPhotos({
    required String productId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getProductPhotos(
        userLang,
        userToken,
        productId,
        false,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
