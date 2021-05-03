// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/market_wallet/market_wallet_local_data_source.dart';
import '../data_sources/market_wallet/market_wallet_remote_data_source.dart';
import '../models/customer/base_api_result_model.dart';
import '../models/market/wallet_balance_result_model.dart';
import '../models/market/wallet_detail_result_model.dart';
import '../models/market/withdrawal_requests_result_model.dart';
import 'auth_repository.dart';

class MarketWalletRepository {
  static MarketWalletRepository? _instance;

  factory MarketWalletRepository() {
    if (_instance == null) {
      _instance = MarketWalletRepository._privateConstructor();
    }
    return _instance!;
  }

  MarketWalletRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = MarketWalletRemoteDataSource(Dio()),
        _localDataSource = MarketWalletLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final MarketWalletRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final MarketWalletLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, WalletBalanceResultModel>> getBalance() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getBalance(userToken);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, WalletDetailResultModel>> getDetail({
    required int skip,
    required int take,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getWalletDetails(
        userToken,
        skip,
        take,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, WithdrawalRequestsResultModel>> getWithdrawalRequests({
    required int skip,
    required int take,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getWithdrawalRequests(
        userToken,
        skip,
        take,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> withdrawalRequest({
    required double amount,
    required String description,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.withdrawalRequest(
        userToken,
        amount,
        description,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
