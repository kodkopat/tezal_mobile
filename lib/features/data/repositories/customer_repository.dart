import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer/customer_local_data_source.dart';
import '../data_sources/customer/customer_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import '../models/customer/customer_profile_result_model.dart';
import 'shared_user_repository.dart';

class CustomerRepository {
  static CustomerRepository? _instance;

  factory CustomerRepository() {
    if (_instance == null) {
      _instance = CustomerRepository._privateConstructor();
    }
    return _instance!;
  }

  CustomerRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerRemoteDataSource(Dio()),
        _localDataSource = CustomerLocalDataSource(),
        _authRepo = SharedUserRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerLocalDataSource _localDataSource;
  final SharedUserRepository _authRepo;

  Future<Either<Failure, CustomerProfileResultModel>>
      getCustomerProfile() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getCustomerProfile(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> changeCustomerProfile({
    required String name,
    required String email,
    required File photo,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.changeCustomerProfile(
        userLang,
        userToken,
        name,
        email,
        photo,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>>
      changeCustomerProfileWithoutPhoto({
    required String name,
    required String email,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.changeCustomerProfileWithoutPhoto(
        userLang,
        userToken,
        name,
        email,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, String>> getPhoto() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getPhoto(
        userLang,
        userToken,
      );

      return result != null
          ? Right(result)
          : Left(ApiFailure("Failed to Load Profile Photo!"));
    }
  }
}
