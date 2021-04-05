import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_wallet/customer_wallet_local_data_source.dart';
import '../data_sources/customer_wallet/customer_wallet_remote_data_source.dart';
import '../models/wallet_detail_result_model.dart';
import '../models/wallet_info_result_model.dart';
import '../models/wallet_load_balance_result_model.dart';
import 'auth_repository.dart';

class CustomerWalletRepository {
  CustomerWalletRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerWalletRemoteDataSource(Dio()),
        _localDataSource = CustomerWalletLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerWalletRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerWalletLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, WalletInfoResultModel>> get walletInfo async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getWalletInfo(userToken);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, WalletDetailResultModel>> walletDetails({
    @required int page,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getWalletDetail(userToken, page);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, WalletLoadBalanceResultModel>> loadBalance({
    @required double amount,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.loadBalance(userToken, amount);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, WalletLoadBalanceResultModel>> confirmLoadBalance({
    @required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result =
          await _remoteDataSource.loadBalanceConfirmation(userToken, id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
