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
import '../models/main_category_result_model.dart';
import '../models/photo_result_model.dart';
import '../models/sub_category_result_model.dart';
import 'auth_repository.dart';

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
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerCategoryRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerCategoryLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, MainCategoryResultModel>> mainCategories({
    required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getMainCategories(marketId);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, SubCategoryResultModel>> subCategories({
    required String marketId,
    required String mainCategoryId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getSubCategories(
        marketId,
        mainCategoryId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotoResultModel>> mainCategoryPhoto(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getMainCategoryPhoto(userToken, id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotoResultModel>> subCategoryPhoto(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getSubCategoryPhoto(userToken, id);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
