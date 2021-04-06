import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_order/customer_order_local_data_source.dart';
import '../data_sources/customer_order/customer_order_remote_data_source.dart';
import '../models/older_orders_result_model.dart';
import '../models/order_detail_result_model.dart';
import '../models/order_result_model.dart';
import 'auth_repository.dart';

class CustomerOrderRepository {
  CustomerOrderRepository()
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
    @required int paymentType,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.save(userToken, paymentType);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, OlderOrdersResultModel>> olderOrders() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getOlderOrders(userToken);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, OrderDetailResultModel>> orderDetail({
    @required String id,
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
