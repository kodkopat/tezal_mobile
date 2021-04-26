// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_order/customer_order_local_data_source.dart';
import '../data_sources/customer_order/customer_order_remote_data_source.dart';
import '../models/customer/base_api_result_model.dart';
import '../models/customer/older_orders_result_model.dart';
import '../models/customer/order_detail_result_model.dart';
import '../models/customer/order_result_model.dart';
import 'auth_repository.dart';

class CustomerOrderRepository {
  static CustomerOrderRepository? _instance;

  factory CustomerOrderRepository() {
    if (_instance == null) {
      _instance = CustomerOrderRepository._privateConstructor();
    }
    return _instance!;
  }

  CustomerOrderRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerOrderRemoteDataSource(Dio()),
        _localDataSource = CustomerOrderLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerOrderRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerOrderLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, OrderResultModel>> saveOrder({
    required int paymentType,
    required String addressId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.save(
        userToken,
        paymentType,
        addressId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> addOrderToBasket({
    required String orderId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.addToBasket(
        userToken,
        orderId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, OlderOrdersResultModel>> olderOrders({
    required int page,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getOlderOrders(userToken, page);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, OrderDetailResultModel>> orderDetail({
    required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getDetail(userToken, id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
