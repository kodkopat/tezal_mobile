// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_basket/customer_basket_local_data_source.dart';
import '../data_sources/customer_basket/customer_basket_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import '../models/customer/basket_result_model.dart';
import 'shared_user_repository.dart';

class CustomerBasketRepository {
  static CustomerBasketRepository? _instance;

  factory CustomerBasketRepository() {
    if (_instance == null) {
      _instance = CustomerBasketRepository._privateConstructor();
    }
    return _instance!;
  }

  CustomerBasketRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerBasketRemoteDataSource(Dio()),
        _localDataSource = CustomerBasketLocalDataSource(),
        _authRepo = SharedUserRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerBasketRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerBasketLocalDataSource _localDataSource;
  final SharedUserRepository _authRepo;

  Future<Either<Failure, BaseApiResultModel>> emptyBasket() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.emptyBasket(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BasketResultModel>> getBasket() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      try {
        final userLang = await _authRepo.userLang;
        final userToken = await _authRepo.userToken;

        var result = await _remoteDataSource.getBasket(
          userLang,
          userToken,
        );

        return result.success
            ? Right(result)
            : Left(ApiFailure(result.message));
      } catch (e) {
        return Left(ApiFailure("اشکال در نمایش سبد خرید"));
      }
    }
  }
/*
  Future<Either<Failure, PaymentInfoResultModel>> getPaymentInfo() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getPaymentInfo(
        userLang,
        userToken,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
 */

/*
  Future<Either<Failure, BaseApiResultModel>> selectAddress({
    required String addressId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.selectAddress(
        userLang,
        userToken,
        addressId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
*/

  Future<Either<Failure, BaseApiResultModel>> addProductToBasket({
    required String productId,
    required int amount,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.addProductToBasket(
        userLang,
        userToken,
        productId,
        amount,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> removeProductFromBasket({
    required String productId,
    required int amount,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.removeProductFromBasket(
        userLang,
        userToken,
        productId,
        amount,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> getBasketCount() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      try {
        final userLang = await _authRepo.userLang;
        final userToken = await _authRepo.userToken;

        var result = await _remoteDataSource.getBasketCount(
          userLang,
          userToken,
        );

        return result.success
            ? Right(result)
            : Left(ApiFailure(result.message));
      } catch (error) {
        return Right(
          BaseApiResultModel(
            success: false,
            message: "failure",
            data: 0,
          ),
        );
      }
    }
  }

  Future<Either<Failure, BaseApiResultModel>> updateBasket({
    required String note,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.updateBasket(
        userLang,
        userToken,
        note,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
