import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../data_sources/customer_order/customer_order_local_data_source.dart';
import '../data_sources/customer_order/customer_order_remote_data_source.dart';
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
}
