// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../../../core/services/location.dart';
import '../data_sources/market_order/market_order_local_data_source.dart';
import '../data_sources/market_order/market_order_remote_data_source.dart';
import 'auth_repository.dart';

class MarketOrderRepository {
  static MarketOrderRepository? _instance;

  factory MarketOrderRepository() {
    if (_instance == null) {
      _instance = MarketOrderRepository._privateConstructor();
    }
    return _instance!;
  }

  MarketOrderRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = MarketOrderRemoteDataSource(Dio()),
        _localDataSource = MarketOrderLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final MarketOrderRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final MarketOrderLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, dynamic>> getOrders() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getOrders(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getOrderSummary() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getOrderSummary(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getPostOrderSummary() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getPostOrderSummary(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getOrderDetail({required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getOrderDetail(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> approveOrder({required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.approveOrder(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> rejectOrder({required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.rejectOrder(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> prepareOrder({required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.prepareOrder(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> returnedOrderApprove(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.returnedOrderApprove(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getReturnOrder() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getReturnOrder(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
