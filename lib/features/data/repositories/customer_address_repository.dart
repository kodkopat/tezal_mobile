import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_address/customer_address_local_data_source.dart';
import '../data_sources/customer_address/customer_address_remote_data_source.dart';
import '../models/address_actions_result_model.dart';
import '../models/address_result_model.dart';
import '../models/addresses_result_model.dart';
import '../models/cities_result_model.dart';
import '../models/provinces_result_model.dart';
import 'auth_repository.dart';

class CustomerAddressRepository {
  CustomerAddressRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerAddressRemoteDataSource(Dio()),
        _localDataSource = CustomerAddressLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerAddressRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerAddressLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, ProvincesResultModel>> get provinces async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getProvince();

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, CitiesResultModel>> cities({
    @required String provinceId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getCity(provinceId);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AddressActionsResultModel>> saveAddress({
    @required String latitude,
    @required String longitude,
    @required String address,
    @required String description,
    @required bool isDefault,
    @required String cityId,
    @required String name,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.save(
        userToken,
        latitude,
        longitude,
        address,
        description,
        isDefault,
        cityId,
        name,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AddressActionsResultModel>> editAddress({
    @required String latitude,
    @required String longitude,
    @required String id,
    @required String address,
    @required String description,
    @required bool isDefault,
    @required String cityId,
    @required String name,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.edit(
        userToken,
        latitude,
        longitude,
        id,
        address,
        description,
        isDefault,
        cityId,
        name,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AddressActionsResultModel>> removeAddress({
    @required String addressId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.removeAddress(
        userToken,
        addressId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AddressActionsResultModel>> setDefaultAddress({
    @required String addressId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.setdefaultAddress(
        userToken,
        addressId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AddressResultModel>> addressDetails({
    @required String addressId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getAddress(
        userToken,
        addressId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AddressesResultModel>> get addresses async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getAddresses(
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
