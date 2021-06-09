// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/delivery_wallet/delivery_wallet_local_data_source.dart';
import '../data_sources/delivery_wallet/delivery_wallet_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import '../models/wallet_balance_result_model.dart';
import '../models/wallet_detail_result_model.dart';
import '../models/withdrawal_requests_result_model.dart';
import 'shared_user_repository.dart';

class DeliveryWalletRepository {
  static DeliveryWalletRepository? _instance;

  factory DeliveryWalletRepository() {
    if (_instance == null) {
      _instance = DeliveryWalletRepository._privateConstructor();
    }
    return _instance!;
  }

  DeliveryWalletRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = DeliveryWalletRemoteDataSource(Dio()),
        _localDataSource = DeliveryWalletLocalDataSource(),
        _authRepo = SharedUserRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final DeliveryWalletRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final DeliveryWalletLocalDataSource _localDataSource;
  final SharedUserRepository _authRepo;

  Future<Either<Failure, WalletBalanceResultModel>> getBalance() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getBalance(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, WalletDetailResultModel>> getWalletDetails({
    required int skip,
    required int take,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getWalletDetails(
        userLang,
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
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getWithdrawalRequests(
        userLang,
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
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.withdrawalRequest(
        userLang,
        userToken,
        amount,
        description,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
