// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/market_order/market_order_local_data_source.dart';
import '../data_sources/market_order/market_order_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import '../models/market/order_comments_result_model.dart';
import '../models/market/order_photos_result_model.dart';
import '../models/market/orders_result_model.dart';
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

  Future<Either<Failure, OrdersResultModel>> getOrders({
    required int skip,
    required int take,
    required String status,
    required bool? distanceAscending,
    required bool? dateAscescending,
    required bool? priceAscending,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getOrders(
        userToken,
        skip,
        take,
        status,
        distanceAscending,
        dateAscescending,
        priceAscending,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> approveOrder(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.approveOrder(
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> cancelOrderApprove(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.cancelOrderApprove(
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, OrderPhotosResultModel>> getOrderPhotos({
    required String orderId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getOrderPhotos(
        userToken,
        orderId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getOrderSummary() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getOrderSummary(
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getPostOrderSummary() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getPostOrderSummary(
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getOrderDetail({required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getOrderDetail(
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> rejectOrder(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.rejectOrder(
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> prepareOrder(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.prepareOrder(
        userToken,
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

      var result = await _remoteDataSource.returnedOrderApprove(
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, OrderCommentsResultModel>> getOrderComments({
    required String orderId,
    required int skip,
    required int take,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getOrderComments(
        userToken,
        orderId,
        skip,
        take,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> replyOrderComments({
    required String commentId,
    required String reply,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.replyOrderComments(
        userToken,
        commentId,
        reply,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
