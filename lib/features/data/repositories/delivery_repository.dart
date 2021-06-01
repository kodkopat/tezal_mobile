// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../../../core/services/location.dart';
import '../data_sources/delivery/delivery_local_data_source.dart';
import '../data_sources/delivery/delivery_remote_data_source.dart';
import 'auth_repository.dart';

class DeliveryRepository {
  static DeliveryRepository? _instance;

  factory DeliveryRepository() {
    if (_instance == null) {
      _instance = DeliveryRepository._privateConstructor();
    }
    return _instance!;
  }

  DeliveryRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = DeliveryRemoteDataSource(Dio()),
        _localDataSource = DeliveryLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final DeliveryRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final DeliveryLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, dynamic>> setAvailablity(
      {required bool available}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.setAvailablity(
        userLang,
        userToken,
        available,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> setLocation() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;
      final position = await LocationService.getSavedLocation();

      var result = await _remoteDataSource.setLocation(
        userLang,
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> list({
    required int pageSize,
    required int page,
    required String orderBy,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;
      final position = await LocationService.getSavedLocation();

      var result = await _remoteDataSource.list(
        userLang,
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        pageSize,
        page,
        orderBy,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
