import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_basket/customer_basket_local_data_source.dart';
import '../data_sources/customer_basket/customer_basket_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import '../models/basket_count_result_model.dart';
import '../models/basket_result_model.dart';
import '../models/payment_info_result_model.dart';
import 'auth_repository.dart';

class CustomerBasketRepository {
  CustomerBasketRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerBasketRemoteDataSource(Dio()),
        _localDataSource = CustomerBasketLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerBasketRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerBasketLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, BaseApiResultModel>> emptyBasket() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.emptyBasket(userToken);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BasketResultModel>> get basket async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getBasket(userToken);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PaymentInfoResultModel>> get pamentInfo async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getPaymentInfo(userToken);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> selectAddress({
    @required String addressId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.selectAddress(userToken, addressId);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> addProductToBasket({
    @required String productId,
    @required int amount,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.addProductToBasket(
        userToken,
        productId,
        amount,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> removeProductToBasket({
    @required String productId,
    @required int amount,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.removeProductFromBasket(
        userToken,
        productId,
        amount,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BasketCountResultModel>> get basketCount async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      try {
        final userToken = await _authRepo.userToken;
        var result = await _remoteDataSource.getBasketCount(userToken);

        return result.success
            ? Right(result)
            : Left(ApiFailure(result.message));
      } catch (error) {
        return Right(
          BasketCountResultModel(
            success: false,
            message: "failure",
            data: 0,
          ),
        );
      }
    }
  }

  Future<Either<Failure, BaseApiResultModel>> updateBasket({
    @required String note,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.updateBasket(userToken, note);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
