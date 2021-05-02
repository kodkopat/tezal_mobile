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
import '../models/customer/base_api_result_model.dart';
import 'auth_repository.dart';

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
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final SharedApplicationRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final SharedApplicationLocalDataSource _localDataSource;
  // ignore: unused_field
  final AuthRepository _authRepo;

  Future<Either<Failure, BaseApiResultModel>> hasNewVersion(
      {required String version}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.hasNewVersion(version);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> getUpdate(
      {required String version}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getUpdate(version);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> share({
    required String contactNumbers,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.share(
        userToken,
        contactNumbers,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
