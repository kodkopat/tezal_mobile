// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_category/customer_category_local_data_source.dart';
import '../data_sources/customer_category/customer_category_remote_data_source.dart';
import '../models/customer/main_category_result_model.dart';
import '../models/customer/photo_result_model.dart';
import '../models/customer/sub_category_result_model.dart';
import 'shared_user_repository.dart';

class CustomerCategoryRepository {
  static CustomerCategoryRepository? _instance;

  factory CustomerCategoryRepository() {
    if (_instance == null) {
      _instance = CustomerCategoryRepository._privateConstructor();
    }
    return _instance!;
  }

  CustomerCategoryRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerCategoryRemoteDataSource(Dio()),
        _localDataSource = CustomerCategoryLocalDataSource(),
        _authRepo = SharedUserRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerCategoryRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerCategoryLocalDataSource _localDataSource;
  final SharedUserRepository _authRepo;

  Future<Either<Failure, MainCategoryResultModel>> getMainCategories({
    required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;

      var result = await _remoteDataSource.getMainCategories(
        userLang,
        marketId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, SubCategoryResultModel>> getSubCategories({
    required String marketId,
    required String mainCategoryId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;

      var result = await _remoteDataSource.getSubCategories(
        userLang,
        marketId,
        mainCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotoResultModel>> getMainCategoryPhoto(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getMainCategoryPhoto(
        userLang,
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotoResultModel>> getSubCategoryPhoto(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userLang = await _authRepo.userLang;
      final userToken = await _authRepo.userToken;

      var result = await _remoteDataSource.getSubCategoryPhoto(
        userLang,
        userToken,
        id,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
