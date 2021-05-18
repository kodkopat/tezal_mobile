// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_address/customer_address_local_data_source.dart';
import '../data_sources/customer_address/customer_address_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import '../models/customer/address_result_model.dart';
import '../models/customer/addresses_result_model.dart';
import '../models/customer/cities_result_model.dart';
import '../models/customer/provinces_result_model.dart';
import 'auth_repository.dart';

class CustomerAddressRepository {
  static CustomerAddressRepository? _instance;

  factory CustomerAddressRepository() {
    if (_instance == null) {
      _instance = CustomerAddressRepository._privateConstructor();
    }
    return _instance!;
  }

  CustomerAddressRepository._privateConstructor()
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

  Future<Either<Failure, ProvincesResultModel>> getProvince() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;

      var result = await _remoteDataSource.getProvince(userLang);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, CitiesResultModel>> getCity({
    required String provinceId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;

      var result = await _remoteDataSource.getCity(
        userLang,
        provinceId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> save({
    required String address,
    required String description,
    required bool isDefault,
    required String cityId,
    required String name,
    required String latitude,
    required String longitude,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.save(
        userLang,
        userToken,
        address,
        description,
        isDefault,
        cityId,
        name,
        latitude,
        longitude,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> edit({
    required String id,
    required String address,
    required String description,
    required bool isDefault,
    required String cityId,
    required String name,
    required String latitude,
    required String longitude,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.edit(
        userLang,
        userToken,
        id,
        address,
        description,
        isDefault,
        cityId,
        name,
        latitude,
        longitude,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> removeAddress({
    required String addressId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.removeAddress(
        userLang,
        userToken,
        addressId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> setDefaultAddress({
    required String addressId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.setdefaultAddress(
        userLang,
        userToken,
        addressId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AddressResultModel>> getAddress({
    required String addressId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getAddress(
        userLang,
        userToken,
        addressId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AddressesResultModel>> getAddresses() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getAddresses(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
