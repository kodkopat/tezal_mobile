// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_wallet/customer_wallet_local_data_source.dart';
import '../data_sources/customer_wallet/customer_wallet_remote_data_source.dart';
import '../models/customer/wallet_detail_result_model.dart';
import '../models/customer/wallet_info_result_model.dart';
import '../models/customer/wallet_load_balance_result_model.dart';
import 'shared_user_repository.dart';

class CustomerWalletRepository {
  static CustomerWalletRepository? _instance;

  factory CustomerWalletRepository() {
    if (_instance == null) {
      _instance = CustomerWalletRepository._privateConstructor();
    }
    return _instance!;
  }

  CustomerWalletRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerWalletRemoteDataSource(Dio()),
        _localDataSource = CustomerWalletLocalDataSource(),
        _authRepo = SharedUserRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerWalletRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerWalletLocalDataSource _localDataSource;
  final SharedUserRepository _authRepo;

  Future<Either<Failure, WalletInfoResultModel>> getWalletInfo() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getWalletInfo(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, WalletDetailResultModel>> getWalletDetail({
    required int page,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getWalletDetail(
        userLang,
        userToken,
        page,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, WalletLoadBalanceResultModel>> loadBalance({
    required double amount,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.loadBalance(
        userLang,
        userToken,
        amount,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, WalletLoadBalanceResultModel>>
      loadBalanceConfirmation({
    required String id,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.loadBalanceConfirmation(
        userLang,
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
