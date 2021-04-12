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
import '../models/customer_profile_result_model.dart';
import 'auth_repository.dart';

class CustomerRepository {
  CustomerRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerRemoteDataSource(Dio()),
        _localDataSource = CustomerLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, CustomerProfileResultModel>>
      get customerProfile async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getCustomerProfile(userToken);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> editCustomerProfile({
    required String name,
    required String email,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.changeCustomerProfile(
        userToken,
        name,
        email,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
