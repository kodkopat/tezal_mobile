// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/delivery_order/delivery_order_local_data_source.dart';
import '../data_sources/delivery_order/delivery_order_remote_data_source.dart';
import 'auth_repository.dart';

class DeliveryOrderRepository {
  static DeliveryOrderRepository? _instance;

  factory DeliveryOrderRepository() {
    if (_instance == null) {
      _instance = DeliveryOrderRepository._privateConstructor();
    }
    return _instance!;
  }

  DeliveryOrderRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = DeliveryOrderRemoteDataSource(Dio()),
        _localDataSource = DeliveryOrderLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final DeliveryOrderRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final DeliveryOrderLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, dynamic>> getDeliveryOrders({
    required int orderStatus,
    required bool orderbyDistanceDescending,
    required bool orderbyCreateDate,
    required int skip,
    required int take,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getDeliveryOrders(
        userLang,
        userToken,
        orderStatus,
        orderbyDistanceDescending,
        orderbyCreateDate,
        skip,
        take,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> takeOrder({required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.takeOrder(
        userLang,
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> deliverOrder({required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.deliverOrder(
        userLang,
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
